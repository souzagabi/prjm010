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
          
            $results = $sql->select("CALL prc_residual_save(:person_id,:daydate,:dayhour,:name_person,:material,:location,:warehouse)", array(
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
            
            $results = $sql->select("CALL prc_residual_update(:residual_id,:person_id,:daydate,:dayhour,:name_person,:material,:location,:warehouse,:situation)", array(
                ":residual_id"  => $this->getresidual_id(),    
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
        
    }

?>
