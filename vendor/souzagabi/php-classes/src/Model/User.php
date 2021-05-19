<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    use \PRJM010\Mailer;
    
    class User extends Model {
        const SESSION = "User";
        const SECRET = "HcodePhp7_secret";

        public static function login($login, $password)
        {
            $sql = new Sql();

            $results = $sql->select("SELECT * FROM PRJM010010 PRJM010 INNER JOIN prjm010013 PRJM013 WHERE PRJM013.login = :LOGIN", array(
                ":LOGIN"=>$login
            ));
            
            if (count($results) === 0) {
                throw new \Exception("Usuário inexistente ou senha inválida", 1);
            }
            $data = $results[0];

            if (password_verify($password, $data["password"]) === true) {
                $user = new User;
                $user->setData($data);
                $_SESSION[User::SESSION] = $user->getValues();
                
                return $user;
            } else{
                throw new \Exception("Usuário inexistente ou senha inválida", 1);
            }
            
        }

        public static function verifyLogin($inadmin = true)
        {
            if (!isset($_SESSION[User::SESSION]) || !$_SESSION[User::SESSION] || !(int)$_SESSION[User::SESSION]["user_id"] > 0 || (bool)$_SESSION[User::SESSION]["inadmin"] !== $inadmin) {
                header("Location: /admin/login");
                exit;
            } 
        }

        public static function logout()
        {
            $_SESSION[User::SESSION] = NULL;
        }

        public static function listAll()
        {
            $sql = new Sql();
            return $sql->select("SELECT * FROM PRJM010013 PRJM013 INNER JOIN PRJM010010 PRJM010 USING(person_id) ORDER BY PRJM010.name_person");
        }

        public function get($iduser) 
        {
            $sql = new Sql();
            
            $results = $sql->select("SELECT * FROM PRJM010013 PRJM013 INNER JOIN PRJM010010 PRJM010 USING(person_id) WHERE PRJM013.user_id = :iduser", array(
            ":iduser"=>$iduser
            ));
            
            $data = $results[0];
            
            $this->setData($data);
        }

        public function save()
        {
            $sql = new Sql();
            
            $results = $sql->select("CALL sp_users_save(:desperson, :sgcompany, :descpfcnpj, :deslogin, :password, :inadmin)", array(
                ":desperson"    =>  $this->getdesperson(),
                ":sgcompany"    =>  $this->getsgcompany(),
                ":descpfcnpj"   =>  $this->getdescpfcnpj(),
                ":deslogin"     =>  $this->getdeslogin(),
                ":password"  =>  $this->getpassword(),
                ":inadmin"      =>  $this->getinadmin()
            ));
            $this->setData($results);
        }
        
        public function update()
        {
            $sql = new Sql();
                       
            $results = $sql->select("CALL sp_users_update_save(:iduser, :idperson, :desperson, :sgcompany, :descpfcnpj, :deslogin, :password, :inadmin)", array(
                ":iduser"       =>  $this->getiduser(),
                ":idperson"     =>  $this->getidperson(),
                ":desperson"    =>  $this->getdesperson(),
                ":descpfcnpj"   =>  $this->getdescpfcnpj(),
                ":sgcompany"    =>  $this->getsgcompany(),
                ":deslogin"     =>  $this->getdeslogin(),
                ":password"  =>  $this->getpassword(),
                ":inadmin"      =>  $this->getinadmin()
            ));
            $this->setData($results);
        }

        public function delete()
        {
            $sql = new Sql();
            
            $sql->query("CALL sp_users_delete(:iduser)", array(
                ":iduser"=>$this->getiduser()
            ));
        }
        public static function getForgot($email)
        {
            $sql = new Sql();
            $results = $sql->select("
                SELECT * FROM tb_persons a
                INNER JOIN tb_users b USING(idperson)
                WHERE a.desemail = :email",
                 array(
                     ":email"=>$email
            ));
            if(count($results) === 0){
                throw new \Exception("Não foi pssível recuperar a senha.");
            } else {
                $data = $results[0];
                $results2 = $sql->select("CALL sp_userspasswordsrecoveries_create(:iduser, :desid)", array(
                    ":iduser"=>$data["iduser"],
                    ":desid"=>$_SERVER["REMOTE_ADDR"]
                ));
                if (count($results2) === 0) {
                    throw new \Exception("Não foi pssível recuperar a senha.");
                } else {
                    $dataRecovery = $results2[0];
                    $ivlen = openssl_cipher_iv_length("aes-256-ctr");
                    $iv = openssl_random_pseudo_bytes($ivlen);
                    $code = base64_encode(openssl_encrypt($dataRecovery["idrecovery"], "aes-256-ctr", USER::SECRET, 0, $iv));
                    $link = "http://www.gbsuporte.com.br:99/admin/forgot/reset?code=$code";
                    $mailer = new Mailer($data["desemail"], $data["desperson"], "Redefinir senha da Hcode store", "forgot", 
                        array(
                            "name"=>$data["desperson"],
                            "link"=>$link
                    ));

                    $mailer->send();

                    return $data;
                }
            }
        }

        public static function validForgotDecrypt($code)
        {
            $ivlen = openssl_cipher_iv_length("aes-256-ctr");
            $iv = openssl_random_pseudo_bytes($ivlen);
            $idrecovery = openssl_decrypt(base64_decode($code), "aes-256-ctr", USER::SECRET, 0, $iv);
            $sql = new Sql();
            $results = $sql->select("
                SELECT *
                FROM tb_userspasswordsrecoveries a
                INNER JOIN tb_users b USING(iduser)
                INNER JOIN tb_persons c USING(idperson)
                WHERE
                    a.idrecovery = :idrecovery
                    AND
                    AND
                    a.dtrecovery IS NULL
                    AND
                    DATE_ADD(a.dtregister, INTERVAL 1 HOUR) >= NOW();
            ", array(
                ":idrecovery"=>$idrecovery
            ));

            if (count($results) === 0) {
                throw new \Exception("Não foi possível recuperar a senha.");
            } else {
                return $results[0];
            }
        }

        public static function setForgotUsed($idrecovery)
        {
            $sql = new Sql();
            $sql->query("UPDATE tb_userspasswordsrecoveries SET dtrecovery = NOW() WHERE idrecovery = :idrecovery", array(
                ":idrecovery"=>$idrecovery
            ));
        }

        public function setPassword($password)
        {
            $sql = new Sql();
            $sql->query("UPDATE tb_users SET password = :password WHERE iduser = :iduser", array(
                ":password" =>$password,
                ":iduser"  =>1
            ));
        }
    }
    

?>
