<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    
    class Nobreak extends Model {

        public static function listAll($list)
        {
            $sql = new Sql();
            
            $list["start"] = 0;
            $pg = isset($_GET["pg"]) ? $_GET["pg"] : 1;
          
            $list["limit"] = (isset($list["limit"]) && $list["limit"] != '') ? $list["limit"] : 10;
            if (($pg - 1) * $list["limit"] > 0) {
                $list["start"] = ($pg - 1) * $list["limit"];
            }
            
            $results =  $sql->select("CALL prc_nobreak_sel(:location,:serialnumber, :daydate, :date_fim, :start, :limit)", array(
                ":location"     => $list["location"],   
                ":serialnumber" => $list["serialnumber"],   
                ":daydate"      => $list["daydate"],
                ":date_fim"     => $list["date_fim"],
                ":start"        => $list["start"],
                ":limit"        => $list["limit"]
            ));
            
            return $results;
        }

        public function getById($nobreak_id) 
        {
            $sql = new Sql();
            
            $results = $sql->select("CALL prc_nobreak_sel_byid(:nobreak_id)", array(
                ":nobreak_id"=>(int)$nobreak_id
            ));
            
            $results = Metodo::convertDateToView($results);
            $this->setData($results[0]);
                     
        }

        public function save()
        {
            $sql = new Sql();
            
            $results = $sql->select("CALL prc_nobreak_save(:person_id,:daydate,:dayhour,:location_id,:local_id,:nobreakmodel,:resulttest,:observation,:serialnumber)", array(
                ":person_id"        => $this->getperson_id(),    
                ":daydate"          => $this->getdaydate(),
                ":dayhour"          => $this->getdayhour(),
                ":location_id"      => $this->getlocation_id(),
                ":local_id"         => $this->getlocal_id(),   
                ":nobreakmodel"     => $this->getnobreakmodel(),    
                ":resulttest"       => $this->getresulttest(),
                ":observation"      => $this->getobservation(),
                ":serialnumber"     => $this->getserialnumber()
            ));
            
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }

        public function update()
        {
            
            $sql = new Sql();
            
            $results = $sql->select("CALL prc_nobreak_update(:nobreak_id,:person_id,:daydate,:dayhour,:location_id,:local_id,:nobreakmodel,:resulttest,:observation,:serialnumber)", array(
                ":nobreak_id"   => $this->getnobreak_id(),    
                ":person_id"        => $this->getperson_id(),    
                ":daydate"          => $this->getdaydate(),
                ":dayhour"          => $this->getdayhour(),
                ":location_id"      => $this->getlocation_id(),
                ":local_id"         => $this->getlocal_id(),   
                ":nobreakmodel"     => $this->getnobreakmodel(),    
                ":resulttest"       => $this->getresulttest(),
                ":observation"      => $this->getobservation(),
                ":serialnumber"     => $this->getserialnumber()
            ));

            $this->setData($results);
            
            return $results[0]["MESSAGE"];
            
        }

        public function delete()
        {
            $sql = new Sql();
          
            $results = $sql->select("CALL prc_nobreak_delete(:nobreak_id)", array(
                ":nobreak_id"  =>(int)$this->getnobreak_id()
            ));
        
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }
        
    }

?>
