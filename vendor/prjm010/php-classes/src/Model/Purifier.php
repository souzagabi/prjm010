<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    
    class Purifier extends Model {

        public static function listAll($list)
        {
            $sql = new Sql();
            
            $list["start"] = 0;
            $pg = isset($_GET["pg"]) ? $_GET["pg"] : 1;
          
            $list["limit"] = (isset($list["limit"]) && $list["limit"] != '') ? $list["limit"] : 10;
            if (($pg - 1) * $list["limit"] > 0) {
                $list["start"] = ($pg - 1) * $list["limit"];
            }
            
            $results =  $sql->select("CALL prc_purifier_sel(:daydate, :date_fim, :start, :limit)", array(
                ":daydate"      => $list["daydate"],
                ":date_fim"     => $list["date_fim"],
                ":start"        => $list["start"],
                ":limit"        => $list["limit"]
            ));
      
            return $results;
        }

        public function getById($purifier_id) 
        {
            $sql = new Sql();
            
            $results = $sql->select("CALL prc_purifier_sel_byid(:purifier_id)", array(
                ":purifier_id"=>(int)$purifier_id
            ));
            
            $results = Metodo::convertDateToView($results);
            $this->setData($results[0]);
                     
        }

        public function save()
        {
            $sql = new Sql();
           
            $results = $sql->select("CALL prc_purifier_save(:person_id, :daydate, :serialnumber, :location_id, :local_id, :nextmanager)", array(
                ":person_id"        => $this->getperson_id(),    
                ":daydate"          => $this->getdaydate(),
                ":serialnumber"     => $this->getserialnumber(),
                ":location_id"      => $this->getlocation_id(),
                ":local_id"         => $this->getlocal_id(),   
                ":nextmanager"      => $this->getnextmanager()
            ));
            
            $this->setData($results);
           
            return $results[0]["MESSAGE"];
        }

        public function update()
        {
            
            $sql = new Sql();
         
            $results = $sql->select("CALL prc_purifier_update(:purifier_id,:person_id,:daydate,:serialnumber,:location_id,:local_id,:nextmanager)", array(
                ":purifier_id"      => $this->getpurifier_id(),    
                ":person_id"        => $this->getperson_id(),    
                ":daydate"          => $this->getdaydate(),
                ":serialnumber"     => $this->getserialnumber(),
                ":location_id"      => $this->getlocation_id(),
                ":local_id"         => $this->getlocal_id(),   
                ":nextmanager"      => $this->getnextmanager()
            ));

            $this->setData($results);
         
            return $results[0]["MESSAGE"];
            
        }

        public function delete()
        {
            $sql = new Sql();
          
            $results = $sql->select("CALL prc_purifier_delete(:purifier_id)", array(
                ":purifier_id"  => $this->getpurifier_id()
            ));
        
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }
        
    }

?>
