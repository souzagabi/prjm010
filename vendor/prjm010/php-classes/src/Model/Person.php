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

        public function get($person_id) 
        {
            $sql = new Sql();
            
            $results = $sql->select("SELECT * FROM PRJM010001 PRJM001 INNER JOIN PRJM010012 PRJM012 ON PRJM012.person_id = PRJM001.person_id INNER JOIN PRJM010010 PRJM010 ON PRJM010.person_id = PRJM001.person_id WHERE PRJM001.person_id = :person_id", array(
                ":person_id"=>$person_id
            ));
            
            $data = $results[0];
            
            $this->setData($data);
        }

        public function update()
        {
            $sql = new Sql();
                                      
            $results = $sql->select("CALL sp_persons_update_save(:person_id, :name_person, :sgcompany, :descpfcnpj, :email)", array(
                ":person_id"        => $this->getperson_id(),
                ":name_person"      => $this->getname_person(),   
                ":sgcompany"        => $this->getsgcompany(),   
                ":descpfcnpj"       => $this->getdescpfcnpj(),
                ":email"            => $this->getemail()
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
