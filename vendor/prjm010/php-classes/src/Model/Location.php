<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    
    class Location extends Model {

        public static function listAll($list)
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

        public function getById($location_id) 
        {
            $sql = new Sql();
            $results = $sql->select("CALL prc_location_sel_byid(:location_id)", array(
                ":location_id"=>(int)$location_id
            ));
            
            $this->setData($results[0]);
                     
        }

        public function save()
        {
            $sql = new Sql();
           
            $results = $sql->select("CALL prc_location_save(:deslocation)", array(
                ":deslocation"      => $this->getdeslocation()
            ));
            
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }

        public function update()
        {
            
            $sql = new Sql();

            $results = $sql->select("CALL prc_location_update(:location_id,:deslocation)", array(
                ":location_id"      => $this->getlocation_id(),
                ":deslocation"      => $this->getdeslocation()
            ));

            $this->setData($results);
            //var_dump($results[0]);exit;
            return $results[0]["MESSAGE"];
            
        }

        public function delete()
        {
            $sql = new Sql();
          
            $results = $sql->select("CALL prc_location_delete(:location_id,:user_id)", array(
                ":location_id"  =>(int)$this->getlocation_id(),
                ":user_id"  =>(int)$this->getuser_id()
            ));
        
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }

    }

?>
