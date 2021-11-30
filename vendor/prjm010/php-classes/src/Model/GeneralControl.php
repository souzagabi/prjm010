<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    
    class GeneralControl extends Model {

        public static function listGeneralControlAll($list)
        {
            $sql = new Sql();
                
            $results =  $sql->select("CALL prc_generalcontrol_sel(:location,:daydate, :date_fim, :start, :limit)", array(
                ":location"     => $list["location"],   
                ":daydate"      => $list["daydate"],
                ":date_fim"     => $list["date_fim"],
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
            $results = Metodo::convertDateToView($results);
            
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
                ":generalcontrol_id"     => $this->getgeneralcontrol_id(),
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
            
            $results = $sql->select("CALL prc_generalcontrol_delete(:generalcontrol_id)", array(
                ":generalcontrol_id"  =>$this->getgeneralcontrol_id()
            ));
            
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }

    }

?>
