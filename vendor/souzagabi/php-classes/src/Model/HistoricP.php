<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    
    class HistoricP extends Model {

        public static function listAll($list)
        {
            $sql = new Sql();
            
            $pg = isset($_GET["pg"]) ? $_GET["pg"] : 1;
          
            $list["limit"] = (isset($list["limit"]) && $list["limit"] != '') ? $list["limit"] : 10;
            $list["start"] = ($pg - 1) * $list["limit"];
            
            $results =  $sql->select("CALL prc_historicP_sel(:purifier_id,:daydate, :date_fim, :start, :limit)", array(
                ":purifier_id"      => $list["purifier_id"],
                ":daydate"          => $list["daydate"],
                ":date_fim"         => $list["date_fim"],
                ":start"            => $list["start"],
                ":limit"            => $list["limit"]
            ));
            
            return $results;
        }

        public function getById($historic_id) 
        {
            $sql = new Sql();
            $results = $sql->select("CALL prc_historicP_sel_byid(:historic_id)", array(
                ":historic_id"=> $historic_id
            ));
            
            $results[0] = Metodo::convertDateToView($results[0]);
            $this->setData($results[0]);
                     
        }

        public function save()
        {
            $sql = new Sql();
          
            $results = $sql->select("CALL prc_historicP_save(:purifier_id,:daydate,:serialnumber)", array(
                ":purifier_id"   => $this->getpurifier_id(),
                ":daydate"       => $this->getdaydate(),
                ":serialnumber"  => $this->getserialnumber()
            ));
           
            $this->setData($results);
           
            return $results[0]["MESSAGE"];
        }

        public function update()
        {
            
            $sql = new Sql();
            
            $results = $sql->select("CALL prc_historicP_update(:historic_id,:purifier_id,:daydate,:serialnumber)", array(
                ":historic_id"    => $this->gethistoric_id(),
                ":purifier_id"    => $this->getpurifier_id(),
                ":daydate"        => $this->getdaydate(),
                ":serialnumber"   => $this->getserialnumber()
                
            ));

            $this->setData($results);
            
            return $results[0]["MESSAGE"];
            
        }

        public function delete()
        {
            $sql = new Sql();
          
            $results = $sql->select("CALL prc_historicP_delete(:historic_id, :user_id)", array(
                ":historic_id"  => $this->gethistoric_id(),
                ":user_id"      => $this->getuser_id()
            ));
        
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }
    }

?>
