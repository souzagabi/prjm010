<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    
    class AirConditioning extends Model {

        public static function listAll($list)
        {
            $sql = new Sql();
           
            return  $sql->select("CALL prc_airconditioning_sel(:location,:start, :limit)", array(
                ":location"     => $list["location"],
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
           
            $results = $sql->select("CALL prc_airconditioning_save(:person_id,:location_id,:local_id,:brand,:serialnumber)", array(
                ":person_id"        => $this->getperson_id(),
                ":location_id"      => $this->getlocation_id(),
                ":local_id"         => $this->getlocal_id(),
                ":brand"            => $this->getbrand(),
                ":serialnumber"     => $this->getserialnumber()
            ));
            
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }

        public function update()
        {
            
            $sql = new Sql();
            
            $results = $sql->select("CALL prc_airconditioning_update(:airconditioning_id,:person_id,:location_id,:local_id,:brand,:serialnumber)", array(
                ":airconditioning_id"   => $this->getairconditioning_id(),
                ":person_id"            => $this->getperson_id(),
                ":location_id"          => $this->getlocation_id(),
                ":local_id"             => $this->getlocal_id(),
                ":brand"                => $this->getbrand(),
                ":serialnumber"         => $this->getserialnumber()
            ));

            $this->setData($results);
            
            return $results[0]["MESSAGE"];
            
        }

        public function delete()
        {
            $sql = new Sql();
          
            $results = $sql->select("CALL prc_airconditioning_delete(:airconditioning_id)", array(
                ":airconditioning_id"  =>(int)$this->getairconditioning_id()
            ));
        
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }

    }

?>
