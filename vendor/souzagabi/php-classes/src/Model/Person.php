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
                                                     
            $results = $sql->select("CALL sp_persons_update_save(:idperson, :desperson, :sgcompany, :descpfcnpj)", array(
                ":idperson"         => $this->getidperson(),
                ":desperson"        => $this->getdesperson(),   
                ":sgcompany"        => $this->getsgcompany(),   
                ":descpfcnpj"       => $this->getdescpfcnpj()
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
