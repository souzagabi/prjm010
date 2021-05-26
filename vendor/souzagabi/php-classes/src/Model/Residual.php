<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    
    class Residual extends Model {



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
            
            return  $sql->select("CALL prc_residual_sel(:name_person, :daydate, :date_fim, :start, :limit)", array(
                ":name_person"  => $list["name_person"],   
                ":daydate"      => $list["daydate"],
                ":date_fim"     => $list["date_fim"],
                ":start"        => $list["start"],
                ":limit"        => $list["limit"]
            ));
        }

        public function getById($residual_id) 
        {
            $sql = new Sql();
            $results = $sql->select("CALL prc_residual_sel_byid(:residual_id)", array(
                ":residual_id"=>(int)$residual_id
            ));
            
            $results[0] = Residual::convertDateToView($results[0]);
            $this->setData($results[0]);
                     
        }

        public function save()
        {
            $sql = new Sql();
          
            $results = $sql->select("CALL prc_residual_save(:user_id,:person_id,:daydate,:dayhour,:name_person,:material,:location,:warehouse)", array(
                ":user_id"          => $this->getuser_id(),
                ":person_id"        => $this->getperson_id(),    
                ":daydate"          => $this->getdaydate(),
                ":dayhour"          => $this->getdayhour(),
                ":name_person"      => $this->getname_person(),    
                ":material"         => $this->getmaterial(),   
                ":location"         => $this->getlocation(),    
                ":warehouse"        => $this->getwarehouse()
            ));
            
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }

        public function update()
        {
            
            $sql = new Sql();
            
            $results = $sql->select("CALL prc_residual_update(:residual_id,:user_id,:person_id,:daydate,:dayhour,:name_person,:material,:location,:warehouse,:situation)", array(
                ":residual_id"  => $this->getresidual_id(),    
                ":user_id"      => $this->getuser_id(),    
                ":person_id"    => $this->getperson_id(),    
                ":daydate"      => $this->getdaydate(),    
                ":dayhour"      => $this->getdayhour(),    
                ":name_person"  => $this->getname_person(),    
                ":material"     => $this->getmaterial(),    
                ":location"     => $this->getlocation(),    
                ":warehouse"    => $this->getwarehouse(),    
                ":situation"    => $this->getsituation()
            ));

            $this->setData($results);
            
            return $results[0]["MESSAGE"];
            
        }

        public function delete()
        {
            $sql = new Sql();
          
            $results = $sql->select("CALL prc_residual_delete(:residual_id, :user_id)", array(
                ":residual_id"  =>(int)$this->getresidual_id(),
                ":user_id"      =>(int)$this->getuser_id()
            ));
        
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }

        public function convertDateToView($object = array())
        {
           $i = 0;
           if (isset($object["daydate"]) && $object["daydate"] != '') {
               foreach ($object as $key => $value) {
                   if ($key == "daydate" || $key == "dt_save") {
                       $object[$key] =  Visitant::convertDateView($value);
                    }
                    $i++;
                }
            } else 
            {
                foreach ($object as $key => $values) {
                    foreach ($values as $key => $value) {
                        if ($key == "daydate" || $key == "dt_save") {
                            $values[$key] =  Visitant::convertDateView($value);
                        }
                    }
                    $object[$i] = $values;
                    $i++;
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
            $residuals 	= "";
            $pgs        = [];
            $residuals 	= Residual::listAll($act);
            $residuals 	= Residual::convertDateToView($residuals);
            $residuals 	= Residual::convertToInt($residuals);
            if (isset($residuals[0]["pgs"]) && count($residuals) > 0 && $residuals != '') {
                $pgs 	= Residual::countRegister($residuals[0]["pgs"], $act);
            }
                              
            return [$residuals, $pgs];
        }
    }

?>
