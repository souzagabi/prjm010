<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    
    class GeneralControl extends Model {

        public static function listGeneralControlAll($list)
        {
            $sql = new Sql();
            
            $list["start"] = 0;
            $pg = isset($_GET["pg"]) ? $_GET["pg"] : 1;
          
            $list["limit"] = (isset($list["limit"]) && $list["limit"] != '') ? $list["limit"] : 10;
            if (($pg - 1) * $list["limit"] > 0) {
                $list["start"] = ($pg - 1) * $list["limit"];
            }
                     
            $results =  $sql->select("CALL prc_generalcontrol_sel(:start, :limit)", array(
                ":start"        => $list["start"],
                ":limit"        => $list["limit"]
            ));
            
            return $results;
        }

        public function getById($generalcontrol_id) 
        {
            $sql = new Sql();
            $results = $sql->select("CALL prc_generalcontrol_sel_byid(:generalcontrol_id)", array(
                ":generalcontrol_id"=>(int)$generalcontrol_id
            ));
            
            $this->setData($results[0]);
                     
        }

        public function save()
        {
            $sql = new Sql();
            
            $results = $sql->select("CALL prc_generalcontrol_save(:location_id,:local_id,:dthydraulic,:dteletric,:dtbuilding)", array(
                ":location_id"  => $this->getlocation_id(),
                ":local_id"     => $this->getlocal_id(),
                ":dthydraulic"  => $this->getdthydraulic(),
                ":dteletric"    => $this->getdteletric(),
                ":dtbuilding"   => $this->getdtbuilding()
            ));
            
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }

        public function update()
        {
            
            $sql = new Sql();
            
            $results = $sql->select("CALL prc_generalcontrol_update(:generalcontrol_id,:location_id,:local_id,:dthydraulic,:dteletric,:dtbuilding)", array(
                ":generalcontrol_id"    => $this->getgeneralcontrol_id(),
                ":location_id"           => $this->getlocation_id(),
                ":local_id"              => $this->getlocal_id(),
                ":dthydraulic"           => $this->getdthydraulic(),
                ":dteletric"             => $this->getdteletric(),
                ":dtbuilding"            => $this->getdtbuilding()
            ));

            $this->setData($results);
            
            return $results[0]["MESSAGE"];
            
        }

        public function delete()
        {
            $sql = new Sql();
            
            $results = $sql->select("CALL prc_generalcontrol_delete(:generalcontrol_id,:user_id)", array(
                ":generalcontrol_id"  =>$this->getgeneralcontrol_id(),
                ":user_id"  =>$this->getuser_id()
            ));
            
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }

    }

?>
