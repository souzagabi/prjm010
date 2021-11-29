<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    
    class Residual extends Model {

        public static function listAll($list)
        {
            $sql = new Sql();
           
            return  $sql->select("CALL prc_residual_sel(:deslocation,:residual, :daydate, :date_fim, :start, :limit)", array(
                ":deslocation"  => $list["deslocation"],   
                ":residual"     => $list["residual"],   
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
            
            $results = Metodo::convertDateToView($results);
            $this->setData($results[0]);
                     
        }

        public function save()
        {
            $sql = new Sql();
            
            $results = $sql->select("CALL prc_residual_save(:person_id,:daydate,:dayhour,:material,:location_id,:local_id,:warehouse)", array(
                ":person_id"        => $this->getperson_id(),    
                ":daydate"          => $this->getdaydate(),
                ":dayhour"          => $this->getdayhour(),
                ":material"         => $this->getmaterial(),
                ":location_id"      => $this->getlocation_id(),
                ":local_id"         => $this->getlocal_id(),    
                ":warehouse"        => $this->getwarehouse()
            ));
            
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }

        public function update()
        {
            
            $sql = new Sql();
         
            $results = $sql->select("CALL prc_residual_update(:residual_id,:person_id,:daydate,:dayhour,:material,:location_id,:local_id,:warehouse,:situation)", array(
                ":residual_id"  => $this->getresidual_id(),    
                ":person_id"    => $this->getperson_id(),    
                ":daydate"      => $this->getdaydate(),    
                ":dayhour"      => $this->getdayhour(),    
                ":material"     => $this->getmaterial(),
                ":location_id"  => $this->getlocation_id(),
                ":local_id"     => $this->getlocal_id(),    
                ":warehouse"    => $this->getwarehouse(),    
                ":situation"    => $this->getsituation()
            ));

            $this->setData($results);
            
            return $results[0]["MESSAGE"];
            
        }

        public function delete()
        {
            $sql = new Sql();
          
            $results = $sql->select("CALL prc_residual_delete(:residual_id)", array(
                ":residual_id"  =>(int)$this->getresidual_id()
            ));
        
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }
        
    }

?>
