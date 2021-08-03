<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    use \PRJM010\Mailer;
    
    class User extends Model {
        const SESSION = "User";
        const SECRET  = "ADJ-SIG_SistemasTi";
        const SECRET2 = "1234567899876543";

        public static function login($login, $password)
        {
            $sql = new Sql();

            $results = $sql->select("SELECT * FROM PRJM010010 PRJM010 INNER JOIN PRJM010013 PRJM013 ON PRJM013.person_id = PRJM010.person_id WHERE PRJM013.login = :LOGIN", array(
                ":LOGIN"=>$login
            ));
            
            if (count($results) === 0) {
                $msg = "ERROR: Usuário ou senha inválida!";
                header("Location: /admin/login?msg=$msg");
			    exit;
            }
            $data = $results[0];
            
            User::passwordVerity($password, $data );
            
        }

        public static function passwordVerity($passUser, $data = array() )
        {
            if (password_verify($passUser, $data["pass"]) === true) {
                $user = new User;
                if (!$data["photo"] && $data["photo"] == '') {
                    $data["photo"] = 0;
                }
                $user->setData($data);
                
                $_SESSION[User::SESSION] = $user->getValues();
                
                return $user;
            } else{
                $msg = "ERROR: Usuário ou senha inválida!";
                header("Location: /admin/login?msg=$msg");
			    exit;
            }
        }

        public static function verifyLogin($inadmin = true)
        {
            if (!isset($_SESSION[User::SESSION]) || !(int)$_SESSION[User::SESSION]["user_id"] > 0  ) {
                
                $msg = "ERROR: É necessário fazer login!";
                header("Location: /admin/login?msg=$msg");
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

        public function get($person_id) 
        {
            $sql = new Sql();
            
            $results = $sql->select("SELECT *, PRJM010.person_id as responsable_id FROM PRJM010001 PRJM001 INNER JOIN PRJM010012 PRJM012 ON PRJM012.person_id = PRJM001.person_id INNER JOIN PRJM010010 PRJM010 ON PRJM010.person_id = PRJM001.person_id LEFT JOIN PRJM010013 PRJM013 ON PRJM013.person_id = PRJM001.person_id WHERE PRJM001.person_id = :person_id", array(
            ":person_id"=>$person_id
            ));
            
            $data = $results[0];
            
            $this->setData($data);
            
        }

        public function save()
        {
            $sql = new Sql();
           
            $results = $sql->select("CALL prc_person_save(:name_person,:phonenumber,:photo,:rg_person, :cpf_person,:email,:classification_id,:daydate,:situation, :login, :pass, :inadmin)", array(
                ":name_person"          => $this->getname_person(),
                ":phonenumber"          => $this->getphonenumber(),
                ":photo"                => $this->getphoto(),
                ":rg_person"            => $this->getrg_person(),
                ":cpf_person"           => $this->getcpf_person(),
                ":email"                => $this->getemail(),
                ":classification_id"    => $this->getclassification_id(),
                ":daydate"              => $this->getdaydate(),
                ":situation"            => $this->getsituation(),
                ":login"                => $this->getlogin(),
                ":pass"                 => $this->getpass(),
                ":inadmin"              => $this->getinadmin()
            ));
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }
        
        public function update()
        {
            $sql = new Sql();
       
            $results = $sql->select("CALL prc_person_update(:seq_person_id,:seq_classp_id,:person_id,:name_person,:phonenumber,:photo,:rg_person,:cpf_person,:email,:classification_id,:daydate,:situation,:login,:pass,:inadmin)", array(
                ":seq_person_id"     => $this->getseq_person_id(),
                ":seq_classp_id"     => $this->getseq_classp_id(),
                ":person_id"         => $this->getperson_id(),
                ":name_person"       => $this->getname_person(),
                ":phonenumber"       => $this->getphonenumber(),
                ":photo"             => $this->getphoto(),
                ":rg_person"         => $this->getrg_person(),
                ":cpf_person"        => $this->getcpf_person(),
                ":email"             => $this->getemail(),
                ":classification_id" => $this->getclassification_id(),
                ":daydate"           => $this->getdt_save(),
                ":situation"         => $this->getsituation(),
                ":login"             => $this->getlogin(),
                ":pass"              => $this->getpass(),
                ":inadmin"           => $this->getinadmin()
            ));
           
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }

        public function delete()
        {
            $sql = new Sql();
            $results = $sql->select("CALL prc_person_delete(:responsable_id)", array(
                ":responsable_id"=>(int)$this->getresponsable_id()
            ));
           
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }
        
        public static function getForgot($email)
        {
            $sql = new Sql();
            
            $results = $sql->select("SELECT * FROM PRJM010010 PRJM010
                INNER JOIN PRJM010013 PRJM013 ON PRJM013.person_id = PRJM010.person_id
                WHERE PRJM010.email = :email",
                 array(
                     ":email"=>$email
            ));
            
            if(count($results) === 0){
                $msg = "ERROR: 1 - Não foi pssível recuperar a senha.";
                header("Location: /admin/forgot?msg=$msg");
			    exit;
            } else {
                $data = $results[0];
                $results2 = $sql->select("CALL prc_passwordsrecoveries_create(:user_id, :desip)", array(
                    ":user_id"=>$data["user_id"],
                    ":desip"=>$_SERVER["REMOTE_ADDR"]
                ));
              
                if (count($results2) === 0) {
                    $msg = "ERROR: 2 - Não foi pssível recuperar a senha.";
                    header("Location: /admin/forgot?msg=$msg");
                    exit;
                } else {
                    
                    $dataRecovery = $results2[0];
                    $method = "aes-256-ctr";
                    $ivlen = openssl_cipher_iv_length($method);
                    $iv = USER::SECRET2;
                    
                    $code = base64_encode(openssl_encrypt($dataRecovery["recovery_id"], $method, USER::SECRET, 0, $iv));

                    $link = "http://www.gbsuporte.com.br:99/admin/forgot/reset?code=$code";
                    
                    $mailer = new Mailer($data["email"], $data["name_person"], "Redefinir senha", "forgot", 
                    array(
                        "name"=>$data["name_person"],
                        "link"=>$link
                    ));
                   
                    $mailer->send();

                    return $data;
                }
            }
        }

        public static function validForgotDecrypt($code)
        {
            $method = "aes-256-ctr";
            $ivlen = openssl_cipher_iv_length($method);
            $iv = USER::SECRET2;
            $code2 = base64_decode($code);
            $recovery_id = openssl_decrypt($code2, $method, USER::SECRET, 0, $iv);
            
            $sql = new Sql();
            $results = $sql->select("SELECT *
                FROM PRJM010009 PRJM009
                INNER JOIN PRJM010013 PRJM013 ON PRJM013.user_id = PRJM009.user_id
                INNER JOIN PRJM010010 PRJM010 ON PRJM010.person_id = PRJM013.person_id
                WHERE
                    PRJM009.recovery_id = :recovery_id
                    AND
                    PRJM009.dtrecovery IS NULL
                    AND
                    DATE_ADD(PRJM009.dtregister, INTERVAL 5 MINUTE) >= NOW();
            ", array(
                ":recovery_id"=>$recovery_id
            ));

            if (count($results) === 0) {
                $msg = "ERROR: 3 - Não foi pssível recuperar a senha.";
                header("Location: /admin/forgot?msg=$msg");
                exit;
            } else {
                return $results[0];
            }
        }

        public static function setForgotUsed($recovery_id)
        {
            $sql = new Sql();
            $sql->query("UPDATE PRJM010009 SET dtrecovery = NOW() WHERE recovery_id = :recovery_id", array(
                ":recovery_id"=>$recovery_id
            ));
        }

        public function setPassword($pass)
        {
            $sql = new Sql();
            $sql->query("UPDATE PRJM010013 SET pass = :pass WHERE user_id = :user_id", array(
                ":pass" =>$pass,
                ":user_id"  =>$this->getuser_id()
            ));
        }
    }

?>
