<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    
    class Hydrant extends Model {

        public static function listAll($list)
        {
            $sql = new Sql();
            
            $pg = isset($_GET["pg"]) ? $_GET["pg"] : 1;
          
            $list["limit"] = (isset($list["limit"]) && $list["limit"] != '') ? $list["limit"] : 10;
            $list["start"] = ($pg - 1) * $list["limit"];
            
            $results =  $sql->select("CALL prc_hydrant_sel(:deslocation,:tipe,:idnumber,:start, :limit)", array(
                ":deslocation"  => $list["deslocation"],
                ":tipe"         => $list["tipe"],
                ":idnumber"     => $list["idnumber"],
                ":start"        => $list["start"],
                ":limit"        => $list["limit"]
            ));
            
            return $results;
        }

        public function getById($hydrant_id) 
        {
            $sql = new Sql();
            $results = $sql->select("CALL prc_hydrant_sel_byid(:hydrant_id)", array(
                ":hydrant_id"=>(int)$hydrant_id
            ));
            
            $this->setData($results[0]);
                     
        }

        public function save()
        {
            $sql = new Sql();
         
            $results = $sql->select("CALL prc_hydrant_save(:person_id,:location_id,:local_id,:tipe,:idnumber,:observation)", array(
                ":person_id"        => $this->getperson_id(),
                ":location_id"      => $this->getlocation_id(),
                ":local_id"         => $this->getlocal_id(),
                ":tipe"             => $this->gettipe(),
                ":idnumber"         => $this->getidnumber(),
                ":observation"      => $this->getobservation()
            ));
           
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }
  
        public function update()
        {
            
            $sql = new Sql();
           
            $results = $sql->select("CALL prc_hydrant_update(:hydrant_id,:person_id,:location_id,:local_id,:tipe,:idnumber,:observation)", array(
                ":hydrant_id"       => $this->gethydrant_id(),
                ":person_id"        => $this->getperson_id(),
                ":location_id"      => $this->getlocation_id(),
                ":local_id"         => $this->getlocal_id(),
                ":tipe"             => $this->gettipe(),
                ":idnumber"         => $this->getidnumber(),
                ":observation"      => $this->getobservation()
            ));

            $this->setData($results);
            
            return $results[0]["MESSAGE"];
            
        }

        public function delete()
        {
            $sql = new Sql();
           
            $results = $sql->select("CALL prc_hydrant_delete(:hydrant_id)", array(
                ":hydrant_id"  => $this->gethydrant_id()
            ));
      
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }
    }

?>
