<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    
    class Visitant extends Model {

        public static function listAll($list)
        {
            $sql = new Sql();
            
            $list["start"] = 1;
            $pg = isset($_GET["pg"]) ? $_GET["pg"] : 1;
          
            $list["limit"] = (isset($list["limit"]) && $list["limit"] != '') ? $list["limit"] : 10;
            if (($pg - 1) * $list["limit"] > 0) {
                $list["start"] = ($pg - 1) * $list["limit"];
            }
            
            if ($list["start"] == 1) {
                $list["start"] = 0;
            }
            
            return $sql->select("CALL prc_visitant_sel(:name_person, :date_save, :date_fim, :start, :limit)", array(
                ":name_person"  => $list["name_person"],   
                ":date_save"    => $list["date_save"],
                ":date_fim"     => $list["date_fim"],
                ":start"        => $list["start"],
                ":limit"        => $list["limit"]
            ));
         
        }

        public static function listClassification()
        {
            $sql = new Sql();
            return $sql->select("Call prc_classification_sel()");
        }
   
        public function getById($person_id) 
        {
            $sql = new Sql();
                        
            $results = $sql->select("CALL prc_visitant_sel_byid(:person_id)", array(
                ":person_id"=>(int)$person_id
            ));
                  
            $results[0] = Visitant::convertDateToView($results[0]);
         
            $this->setData($results[0]);
        }

        public function save()
        {
            $sql = new Sql();
        
            $results = $sql->select("CALL prc_visitant_save(:name_person,:rg_person,:cpf_person,:phonenumber,:photo,:company,:reason,:badge,:auth,:sign,:daydate,:dayhour,:user_id,:classification_id)", array(
                ":name_person"      => $this->getname_person(),    
                ":rg_person"        => $this->getrg_person(),    
                ":cpf_person"       => $this->getcpf_person(),    
                ":phonenumber"      => $this->getphonenumber(),    
                ":photo"            => $this->getphoto(),    
                ":company"          => $this->getcompany(),    
                ":reason"           => $this->getreason(),
                ":badge"            => $this->getbadge(),
                ":auth"             => $this->getauth(),
                ":sign"             => $this->getsign(),
                ":daydate"          => $this->getdaydate(),
                ":dayhour"          => $this->getdayhour(),
                ":user_id"          => $this->getuser_id(),
                ":classification_id"=> $this->getclassification_id()
            ));
            
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }
        
        public function update()
        {
            $sql = new Sql();
            
            $results = $sql->select("CALL prc_visitant_update(:seq_person_id,:seq_classp_id,:visitant_id,:person_id,:name_person,:rg_person,:cpf_person,:phonenumber,:photo,:company,:reason,:badge,:auth,:sign,:daydate,:dayhour,:user_id,:classification_id,:situation)", array(
                ":seq_person_id"    => $this->getseq_person_id(),    
                ":seq_classp_id"    => $this->getseq_classp_id(),    
                ":visitant_id"      => $this->getvisitant_id(),    
                ":person_id"        => $this->getperson_id(),    
                ":name_person"      => $this->getname_person(),    
                ":rg_person"        => $this->getrg_person(),    
                ":cpf_person"        => $this->getcpf_person(),    
                ":phonenumber"      => $this->getphonenumber(),    
                ":photo"            => $this->getphoto(),    
                ":company"          => $this->getcompany(),    
                ":reason"           => $this->getreason(),
                ":badge"            => $this->getbadge(),
                ":auth"             => $this->getauth(),
                ":sign"             => $this->getsign(),
                ":daydate"          => $this->getdaydate(),
                ":dayhour"          => $this->getdayhour(),
                ":user_id"          => $this->getuser_id(),
                ":classification_id"=> $this->getclassification_id(),
                ":situation"        => $this->getsituation()
            ));
            $this->setData($results);
          
            return $results[0]["MESSAGE"];
        }

        public function delete()
        {
            $sql = new Sql();
           
            $results = $sql->select("CALL prc_visitant_delete(:person_id)", array(
                ":person_id"    =>(int)$this->getperson_id()
            ));
            
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }
        
        public function convertDateToView($object = array())
        {
            for ($i=0; $i < count($object); $i++) { 
                if (isset($object["daydate"]) && $object["daydate"] != '') {
                    $object["daydate"] =  Visitant::convertDateView($object["daydate"]);
                }
                if (isset($object["dt_save"]) && $object["dt_save"] != '') {
                    $object["dt_save"] =  Visitant::convertDateView($object["dt_save"]);
                }
            }
            return $object;
        }
        
        public function convertDateToDataBase($object = array())
        {
            foreach ($object as $key => $value) {
                if (isset($value) && $value !='') {
                    $object[$key] =  Visitant::convertDateDataBase($object[$key]);
                }
            }
            return $object;
           
        }

        public function convertDateView($date)
        {
            return $data = date("d-m-Y", strToTime($date));
        }

        public function convertDateDataBase($date)
        {
            return $data = date("Y-m-d", strToTime($date));
        }
        
        public function convertToInt($object = array())
        {
            if (isset($object[0]["pgs"])) {
                for ($i=0; $i < count($object); $i++) { 
                    $object[$i]["pgs"] = ceil($object[$i]["pgs"]);
                }
                return $object;
            }
            return $object;
        }

        public function countRegister($qtdeRegister, $company)
        {
            $pgs = [];
            for ($j=0; $j < $qtdeRegister - 1; $j++) { 
                $pgs[$j]    = $j;
            }
            $pgs["list"]["limit"] = '';
            foreach ($company as $key => $value) {
                $pgs["list"][$key] = $value;
            }
            
            return $pgs;
        }
        public function selectRegister($act = array())
        {
            $visitants 	= "";
            $pgs        = [];
            if ($act["visitants"]) {
                $visitants 	= Visitant::listAll($act);
                $visitants 	= Visitant::convertDateToView($visitants);
                $visitants 	= Visitant::convertToInt($visitants);
            }
              
            if (isset($visitants[0]["pgs"]) && count($visitants) > 0 && $visitants != '') {
                $pgs 	= Visitant::countRegister($visitants[0]["pgs"], $act);
            }
          
            return [$visitants, $pgs];
        }
    }
?>
