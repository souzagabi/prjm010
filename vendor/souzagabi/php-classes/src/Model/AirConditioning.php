<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    
    class AirConditioning extends Model {

        public static function listAll($list)
        {
            $sql = new Sql();
            
           $pg = isset($_GET["pg"]) ? $_GET["pg"] : 1;
          
            $list["limit"] = (isset($list["limit"]) && $list["limit"] != '') ? $list["limit"] : 10;
            $list["start"] = ($pg - 1) * $list["limit"];
       
            return  $sql->select("CALL prc_airconditioning_sel(:daydate, :date_fim,:start, :limit)", array(
                ":daydate"      => $list["daydate"],
                ":date_fim"     => $list["date_fim"],
                ":start"        => $list["start"],
                ":limit"        => $list["limit"]
            ));
        }

        public function getById($airconditioning_id) 
        {
            $sql = new Sql();
            $results = $sql->select("CALL prc_airconditioning_sel_byid(:airconditioning_id)", array(
                ":airconditioning_id"=>(int)$airconditioning_id
            ));
            
            $this->setData($results[0]);
                     
        }

        public function save()
        {
            $sql = new Sql();
           
            $results = $sql->select("CALL prc_airconditioning_save(:person_id,:location)", array(
                ":person_id"        => $this->getperson_id(),
                ":location"         => $this->getlocation()
            ));
            
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }

        public function update()
        {
            
            $sql = new Sql();

            $results = $sql->select("CALL prc_airconditioning_update(:airconditioning_id,:person_id,:location)", array(
                ":airconditioning_id"   => $this->getairconditioning_id(),
                ":person_id"            => $this->getperson_id(),
                ":location"             => $this->getlocation()
            ));

            $this->setData($results);
            
            return $results[0]["MESSAGE"];
            
        }

        public function delete()
        {
            $sql = new Sql();
          
            $results = $sql->select("CALL prc_airconditioning_delete(:airconditioning_id, :user_id)", array(
                ":airconditioning_id"  =>(int)$this->getairconditioning_id(),
                ":user_id"      =>(int)$this->getuser_id()
            ));
        
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }

    }

?>
