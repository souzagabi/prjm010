<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    
    class HistoricA extends Model {

        public static function listAll($list)
        {
            $sql = new Sql();
            
            $pg = isset($_GET["pg"]) ? $_GET["pg"] : 1;
          
            $list["limit"] = (isset($list["limit"]) && $list["limit"] != '') ? $list["limit"] : 10;
            $list["start"] = ($pg - 1) * $list["limit"];
            
            $results =  $sql->select("CALL prc_historicA_sel(:airconditioning_id,:daydate,:date_fim,:start, :limit)", array(
                ":airconditioning_id"   => $list["airconditioning_id"],
                ":daydate"              => $list["daydate"],
                ":date_fim"             => $list["date_fim"],
                ":start"                => $list["start"],
                ":limit"                => $list["limit"]
            ));
           
            return $results;
        }

        public function getById($historic_id) 
        {
            $sql = new Sql();
            $results = $sql->select("CALL prc_historicA_sel_byid(:historic_id)", array(
                ":historic_id"=>(int)$historic_id
            ));
           
            $results = Metodo::convertDateToView($results);
             
            $this->setData($results[0]);
                     
        }

        public function save()
        {
            $sql = new Sql();
            
            $results = $sql->select("CALL prc_historicA_save(:airconditioning_id,:inmonth,:daydate,:dtnextmanager)", array(
                ":airconditioning_id"   => $this->getairconditioning_id(),
                ":inmonth"              => $this->getinmonth(),
                ":daydate"              => $this->getdaydate(),
                ":dtnextmanager"        => $this->getdtnextmanager()
                
            ));
           
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }

        public function update()
        {
            
            $sql = new Sql();
                        
            $results = $sql->select("CALL prc_historicA_update(:historic_id,:airconditioning_id,:inmonth,:daydate,:dtnextmanager)", array(
                ":historic_id"          => $this->gethistoric_id(),
                ":airconditioning_id"   => $this->getairconditioning_id(),
                ":inmonth"              => $this->getinmonth(),
                ":daydate"              => $this->getdaydate(),
                ":dtnextmanager"        => $this->getdtnextmanager()
            ));

            $this->setData($results);
            
            return $results[0]["MESSAGE"];
            
        }

        public function delete()
        {
            $sql = new Sql();
          
            $results = $sql->select("CALL prc_historicA_delete(:historic_id)", array(
                ":historic_id"  =>(int)$this->gethistoric_id()
            ));
        
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }
    }

?>
