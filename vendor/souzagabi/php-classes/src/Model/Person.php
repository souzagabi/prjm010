<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    use \PRJM010\Mailer;
    
    class Person extends Model {
        public static function listAll()
        {
            $sql = new Sql();
            return $sql->select("SELECT * FROM tb_persons ORDER BY idperson");
        }

        public function get($idperson) 
        {
            $sql = new Sql();
            
            $results = $sql->select("SELECT * FROM tb_persons WHERE idperson = :idperson", array(
            ":idperson"=>$idperson
            ));
            
            $data = $results[0];
            
            $this->setData($data);
        }

        public function update()
        {
            $sql = new Sql();

            $results = $sql->select("CALL sp_persons_update_save(:seq_person_id,:seq_classp_id,:person_id,:user_id,:name_person,:phonenumber,:photo,:rg_person,:cpf_person,:classification_id,:daydate,:situation,:login,:password,:inadmin)", array(
                ":seq_person_id"     => $this->getseq_person_id(),
                ":seq_classp_id"     => $this->getseq_classp_id(),
                ":person_id"         => $this->getperson_id(),
                ":user_id"           => $this->getuser_id(),
                ":name_person"       => $this->getname_person(),
                ":phonenumber"       => $this->getphonenumber(),
                ":photo"             => $this->getphoto(),
                ":rg_person"         => $this->getrg_person(),
                ":cpf_person"        => $this->getcpf_person(),
                ":classification_id" => $this->getclassification_id(),
                ":daydate"           => $this->getdaydate(),
                ":situation"         => $this->getsituation(),
                ":login"             => $this->getlogin(),
                ":password"          => $this->getpassword(),
                ":inadmin"           => $this->getinadmin()
            ));
           
            $this->setData($results);
        }

        public function delete()
        {
            $sql = new Sql();
            
            $sql->query("CALL sp_persons_delete(:idperson)", array(
                ":idperson"=>$this->getidperson()
            ));
        }
    }
?>
