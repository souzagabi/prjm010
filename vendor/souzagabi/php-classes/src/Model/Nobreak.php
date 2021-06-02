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
            
            $results =  $sql->select("CALL prc_nobreak_sel(:name_person, :daydate, :date_fim, :start, :limit)", array(
                ":name_person"  => $list["name_person"],   
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
            
            $results[0] = Metodo::convertDateToView($results[0]);
            $this->setData($results[0]);
                     
        }

        public function save()
        {
            $sql = new Sql();
            
            $results = $sql->select("CALL prc_nobreak_save(:user_id,:person_id,:name_person,:daydate,:dayhour,:location,:nobreakmodel,:resulttest,:observation,:serialnumber)", array(
                ":user_id"          => $this->getuser_id(),
                ":person_id"        => $this->getperson_id(),    
                ":name_person"      => $this->getname_person(),
                ":daydate"          => $this->getdaydate(),
                ":dayhour"          => $this->getdayhour(),    
                ":location"         => $this->getlocation(),   
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
            
            $results = $sql->select("CALL prc_nobreak_update(:nobreak_id,:user_id,:person_id,:name_person,:daydate,:dayhour,:location,:nobreakmodel,:resulttest,:observation,:serialnumber)", array(
                ":nobreak_id"   => $this->getnobreak_id(),    
                ":user_id"          => $this->getuser_id(),
                ":person_id"        => $this->getperson_id(),    
                ":name_person"      => $this->getname_person(),
                ":daydate"          => $this->getdaydate(),
                ":dayhour"          => $this->getdayhour(),    
                ":location"         => $this->getlocation(),   
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
          
            $results = $sql->select("CALL prc_nobreak_delete(:nobreak_id, :user_id)", array(
                ":nobreak_id"  =>(int)$this->getnobreak_id(),
                ":user_id"      =>(int)$this->getuser_id()
            ));
        
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }
        
    }

?>
