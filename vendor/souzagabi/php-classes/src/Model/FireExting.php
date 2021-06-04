<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    
    class FireExting extends Model {


        public static function listAll($list)
        {
            $sql = new Sql();
            
            $pg = isset($_GET["pg"]) ? $_GET["pg"] : 1;
          
            $list["limit"] = (isset($list["limit"]) && $list["limit"] != '') ? $list["limit"] : 10;
            $list["start"] = ($pg - 1) * $list["limit"];
            
            $results =  $sql->select("CALL prc_fireexting_sel(:daydate, :date_fim, :start, :limit)", array(
                ":daydate"      => $list["daydate"],
                ":date_fim"     => $list["date_fim"],
                ":start"        => $list["start"],
                ":limit"        => $list["limit"]
            ));
            
            return $results;
        }

        public function getById($fireexting_id) 
        {
            $sql = new Sql();
            $results = $sql->select("CALL prc_fireexting_sel_byid(:fireexting_id)", array(
                ":fireexting_id"=>(int)$fireexting_id
            ));
            
            $results[0] = Metodo::convertDateToView($results[0]);
            $this->setData($results[0]);
                     
        }

        public function save()
        {
            $sql = new Sql();
          
            $results = $sql->select("CALL prc_fireexting_save(:user_id,:person_id,:daydate,:dayhour,:location,:tipe,:weight,:capacity,:rechargedate)", array(
                ":user_id"          => $this->getuser_id(),
                ":person_id"        => $this->getperson_id(),
                ":daydate"          => $this->getdaydate(),
                ":dayhour"          => $this->getdayhour(),
                ":location"         => $this->getlocation(),
                ":tipe"             => $this->gettipe(),
                ":weight"           => $this->getweight(),
                ":capacity"         => $this->getcapacity(),
                ":rechargedate"     => $this->getrechargedate()
            ));
           
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }
  
        public function update()
        {
            
            $sql = new Sql();
            echo '<pre>';
            print_r($this);
            echo '</pre>';//exit;
            

            $results = $sql->select("CALL prc_fireexting_update(:fireexting_id,:user_id,:person_id,:daydate,:dayhour,:location,:tipe,:weight,:capacity,:rechargedate)", array(
                ":fireexting_id"    => $this->getfireexting_id(),
                ":user_id"          => $this->getuser_id(),
                ":person_id"        => $this->getperson_id(),
                ":daydate"          => $this->getdaydate(),
                ":dayhour"          => $this->getdayhour(),
                ":location"         => $this->getlocation(),
                ":tipe"             => $this->gettipe(),
                ":weight"           => $this->getweight(),
                ":capacity"         => $this->getcapacity(),
                ":rechargedate"     => $this->getrechargedate()
            ));

            $this->setData($results);
            
            return $results[0]["MESSAGE"];
            
        }

        public function delete()
        {
            $sql = new Sql();
          
            $results = $sql->select("CALL prc_fireexting_delete(:fireexting_id, :user_id)", array(
                ":fireexting_id"  =>(int)$this->getfireexting_id(),
                ":user_id"      =>(int)$this->getuser_id()
            ));
        
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }
    }

?>
