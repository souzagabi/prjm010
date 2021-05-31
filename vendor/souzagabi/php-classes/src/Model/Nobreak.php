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
            
            if ($list["start"] == 1) {
                $list["start"] = 0;
            }
            
            return  $sql->select("CALL prc_nobreak_sel(:name_person, :daydate, :date_fim, :start, :limit)", array(
                ":name_person"  => $list["name_person"],   
                ":daydate"      => $list["daydate"],
                ":date_fim"     => $list["date_fim"],
                ":start"        => $list["start"],
                ":limit"        => $list["limit"]
            ));
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
          
            $results = $sql->select("CALL prc_nobreak_save(:user_id,:person_id,:daydate,:dayhour,:name_person,:material,:location,:warehouse)", array(
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
            
            $results = $sql->select("CALL prc_nobreak_update(:nobreak_id,:user_id,:person_id,:daydate,:dayhour,:name_person,:material,:location,:warehouse,:situation)", array(
                ":nobreak_id"   => $this->getnobreak_id(),    
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
          
            $results = $sql->select("CALL prc_nobreak_delete(:nobreak_id, :user_id)", array(
                ":nobreak_id"  =>(int)$this->getnobreak_id(),
                ":user_id"      =>(int)$this->getuser_id()
            ));
        
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }
        
    }

?>
