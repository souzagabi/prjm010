<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    
    class AnualPlan extends Model {

        public static function listEquipamentAll($list)
        {
            $sql = new Sql();
            
            $list["start"] = 0;
            $pg = isset($_GET["pg"]) ? $_GET["pg"] : 1;
          
            $list["limit"] = (isset($list["limit"]) && $list["limit"] != '') ? $list["limit"] : 10;
            if (($pg - 1) * $list["limit"] > 0) {
                $list["start"] = ($pg - 1) * $list["limit"];
            }
            
            if ($list["start"] == 1) {
                $list["start"] = 0;
            }
            
            $results =  $sql->select("CALL prc_equipament_sel(:start, :limit)", array(
                ":start"        => $list["start"],
                ":limit"        => $list["limit"]
            ));
            
            return $results;
        }

        public static function listLocationAll($list)
        {
            $sql = new Sql();
            
            $list["start"] = 0;
            $pg = isset($_GET["pg"]) ? $_GET["pg"] : 1;
          
            $list["limit"] = (isset($list["limit"]) && $list["limit"] != '') ? $list["limit"] : 10;
            if (($pg - 1) * $list["limit"] > 0) {
                $list["start"] = ($pg - 1) * $list["limit"];
            }
            
            if ($list["start"] == 1) {
                $list["start"] = 0;
            }
            $results =  $sql->select("CALL prc_location_sel(:start, :limit)", array(
                ":start"        => $list["start"],
                ":limit"        => $list["limit"]
            ));
            
            return $results;
        }

        public static function listResponsableAll($list)
        {
            $sql = new Sql();
            
            $list["start"] = 0;
            $pg = isset($_GET["pg"]) ? $_GET["pg"] : 1;
          
            $list["limit"] = (isset($list["limit"]) && $list["limit"] != '') ? $list["limit"] : 10;
            if (($pg - 1) * $list["limit"] > 0) {
                $list["start"] = ($pg - 1) * $list["limit"];
            }
            
            if ($list["start"] == 1) {
                $list["start"] = 0;
            }
            $results =  $sql->select("CALL prc_responsable_sel(:start, :limit)", array(
                ":start"        => $list["start"],
                ":limit"        => $list["limit"]
            ));
            
            return $results;
        }

        public static function listAnualPlanAll($list)
        {
            $sql = new Sql();
            
            $list["start"] = 0;
            $pg = isset($_GET["pg"]) ? $_GET["pg"] : 1;
          
            $list["limit"] = (isset($list["limit"]) && $list["limit"] != '') ? $list["limit"] : 10;
            if (($pg - 1) * $list["limit"] > 0) {
                $list["start"] = ($pg - 1) * $list["limit"];
            }
            
            if ($list["start"] == 1) {
                $list["start"] = 0;
            }
    
            return  $sql->select("CALL prc_anualplan_sel(:daydate, :start, :limit)", array(
                ":daydate"      => $list["daydate"],
                ":start"        => $list["start"],
                ":limit"        => $list["limit"]
            ));
        }

        public function getByIdE($equipament_id) 
        {
            $sql = new Sql();
            $results = $sql->select("CALL prc_equipament_sel_byid(:equipament_id)", array(
                ":equipament_id"=>(int)$equipament_id
            ));
            
            $this->setData($results[0]);
                     
        }

        public function getByIdL($location_id) 
        {
            $sql = new Sql();
            $results = $sql->select("CALL prc_location_sel_byid(:location_id)", array(
                ":location_id"=>(int)$location_id
            ));
            
            $this->setData($results[0]);
                     
        }

        public function getByIdA($anualplan_id) 
        {
            $sql = new Sql();
            $results = $sql->select("CALL prc_anualplan_sel_byid(:anualplan_id)", array(
                ":anualplan_id"=>(int)$anualplan_id
            ));
            $results[0] = Metodo::convertDateToView($results[0]);
      
            $this->setData($results[0]);
                     
        }
        
        public function saveE()
        {
            $sql = new Sql();
           
            $results = $sql->select("CALL prc_equipament_save(:desequipament)", array(
                ":desequipament"      => $this->getdesequipament()
            ));
            
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }

        public function saveL()
        {
            $sql = new Sql();
           
            $results = $sql->select("CALL prc_location_save(:deslocation)", array(
                ":deslocation"      => $this->getdeslocation()
            ));
            
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }

        public function saveA()
        {
            $sql = new Sql();
           
            $results = $sql->select("CALL prc_anualplan_save(:person_id,:dateout,:qtdeout,:signout,:datein,:qtdein,:signin)", array(
                ":person_id"        => $this->getperson_id(),
                ":dateout"          => $this->getdateout(),
                ":qtdeout"          => $this->getqtdeout(),
                ":signout"          => $this->getsignout(),
                ":datein"           => $this->getdatein(),
                ":qtdein"           => $this->getqtdein(),
                ":signin"           => $this->getsignin()
            ));
            
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }

        public function updateE()
        {
            
            $sql = new Sql();

            $results = $sql->select("CALL prc_equipament_update(:equipament_id,:desequipament)", array(
                ":equipament_id"      => $this->getequipament_id(),
                ":desequipament"      => $this->getdesequipament()
            ));

            $this->setData($results);
            
            return $results[0]["MESSAGE"];
            
        }

        public function updateL()
        {
            
            $sql = new Sql();

            $results = $sql->select("CALL prc_location_update(:location_id,:deslocation)", array(
                ":location_id"      => $this->getlocation_id(),
                ":deslocation"      => $this->getdeslocation()
            ));

            $this->setData($results);
            
            return $results[0]["MESSAGE"];
            
        }

        public function updateA()
        {
            
            $sql = new Sql();

            $results = $sql->select("CALL prc_anualplan_update(:anualplan_id,:person_id,:dateout,:qtdeout,:signout,:datein,:qtdein,:signin)", array(
                ":anualplan_id"      => $this->getanualplan_id(),
                ":person_id"        => $this->getperson_id(),
                ":dateout"          => $this->getdateout(),
                ":qtdeout"          => $this->getqtdeout(),
                ":signout"          => $this->getsignout(),
                ":datein"           => $this->getdatein(),
                ":qtdein"           => $this->getqtdein(),
                ":signin"           => $this->getsignin()
            ));

            $this->setData($results);
            
            return $results[0]["MESSAGE"];
            
        }

        public function deleteE()
        {
            $sql = new Sql();
          
            $results = $sql->select("CALL prc_equipament_delete(:equipament_id)", array(
                ":equipament_id"  =>(int)$this->getequipament_id()
            ));
        
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }

        public function deleteL()
        {
            $sql = new Sql();
          
            $results = $sql->select("CALL prc_location_delete(:location_id)", array(
                ":location_id"  =>(int)$this->getlocation_id()
            ));
        
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }

        public function deleteA()
        {
            $sql = new Sql();
          
            $results = $sql->select("CALL prc_anualplan_delete(:anualplan_id, :user_id)", array(
                ":anualplan_id"  =>(int)$this->getanualplan_id(),
                ":user_id"      =>(int)$this->getuser_id()
            ));
        
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }

    }

?>
