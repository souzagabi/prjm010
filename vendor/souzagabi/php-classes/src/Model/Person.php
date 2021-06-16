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
            
            $results = $sql->select("SELECT *, PRJM001.dt_save as daydate FROM PRJM010010 PRJM010 INNER JOIN PRJM010001 PRJM001 ON PRJM001.person_id = PRJM010.person_id INNER JOIN PRJM010012 PRJM012 ON PRJM012.person_id = PRJM010.person_id WHERE PRJM010.person_id = :idperson", array(
            ":idperson"=>$idperson
            ));
            
            $data = $results[0];
            
            $this->setData($data);
           
        }

        public function save()
        {
            $sql = new Sql();

            $result = $sql->select("CALL prc_person_save(:seq_person_id,:seq_classp_id,:person_id,:name_person,:phonenumber,:photo,:rg_person,:cpf_person,:classification_id,:daydate,:situation,:login,:password,:inadmin)", array(
                ":seq_person_id"        =>$this->getseq_person_id(),
                ":seq_classp_id"        =>$this->getseq_classp_id(),
                ":person_id"            =>$this->getperson_id(),
                ":name_person"          =>$this->getname_person(),
                ":phonenumber"          =>$this->getphonenumber(),
                ":photo"                =>$this->getphoto(),
                ":rg_person"            =>$this->getrg_person(),
                ":cpf_person"           =>$this->getcpf_person(),
                ":classification_id"    =>$this->getclassification_id(),
                ":daydate"              =>$this->getdaydate(),
                ":situation"            =>$this->getsituation(),
                ":login"                =>$this->getlogin(),
                ":password"             =>$this->getpassword(),
                ":inadmin"              =>$this->getinadmin()
            ));
        }

        public function update()
        {
            $sql = new Sql();

            $results = $sql->select("CALL prc_person_update(:seq_person_id,:seq_classp_id,:person_id,:name_person,:phonenumber,:photo,:rg_person,:cpf_person,:classification_id,:daydate,:situation,:login,:pass,:inadmin)", array(
                ":seq_person_id"        =>$this->getseq_person_id(),
                ":seq_classp_id"        =>$this->getseq_classp_id(),
                ":person_id"            =>$this->getperson_id(),
                ":name_person"          =>$this->getname_person(),
                ":phonenumber"          =>$this->getphonenumber(),
                ":photo"                =>$this->getphoto(),
                ":rg_person"            =>$this->getrg_person(),
                ":cpf_person"           =>$this->getcpf_person(),
                ":classification_id"    =>$this->getclassification_id(),
                ":daydate"              =>$this->getdaydate(),
                ":situation"            =>$this->getsituation(),
                ":login"                =>$this->getlogin(),
                ":pass"                 =>$this->getpass(),
                ":inadmin"              =>$this->getinadmin()
            ));
            
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }

        public function delete()
        {
            $sql = new Sql();
            
            $results = $sql->select("CALL prc_person_delete(:person_id)", array(
                ":person_id"=>$this->getperson_id()
            ));
            return $results[0]["MESSAGE"];
        }
    }
?>
