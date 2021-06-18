<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    
    class HistoricH extends Model {

        public static function listAll($list)
        {
            $sql = new Sql();
            
            $pg = isset($_GET["pg"]) ? $_GET["pg"] : 1;
          
            $list["limit"] = (isset($list["limit"]) && $list["limit"] != '') ? $list["limit"] : 10;
            $list["start"] = ($pg - 1) * $list["limit"];
            
            $results =  $sql->select("CALL prc_historicH_sel(:hydrant_id,:daydate, :date_fim, :start, :limit)", array(
                ":hydrant_id"       => $list["hydrant_id"],
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
            $results = $sql->select("CALL prc_historicH_sel_byid(:historic_id)", array(
                ":historic_id"=>(int)$historic_id
            ));
           
            $results[0] = Metodo::convertDateToView($results[0]);
            $this->setData($results[0]);
                     
        }

        public function save()
        {
            $sql = new Sql();
            
            $results = $sql->select("CALL prc_historicH_save(:hydrant_id,:daydate,:idkey,:hose,:squirt,:painting,:alarmcentral,:glass,:inlock,:record,:signaling,:obstruction,:observation)", array(
                ":hydrant_id"    => $this->gethydrant_id(),
                ":daydate"       => $this->getdaydate(),
                ":idkey"         => $this->getidkey(),
                ":hose"          => $this->gethose(),
                ":squirt"        => $this->getsquirt(),
                ":painting"      => $this->getpainting(),
                ":alarmcentral"  => $this->getalarmcentral(),
                ":glass"         => $this->getglass(),
                ":inlock"         => $this->getinlock(),
                ":record"        => $this->getrecord(),
                ":signaling"     => $this->getsignaling(),
                ":obstruction"   => $this->getobstruction(),
                ":observation"   => $this->getobservation()
            ));
           
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }

        public function update()
        {
            $sql = new Sql();
            
            $results = $sql->select("CALL prc_historicH_update(:historic_id,:hydrant_id,:daydate,:idkey,:hose,:squirt,:painting,:alarmcentral,:glass,:inlock,:record,:signaling,:obstruction,:observation)", array(
                ":historic_id"   => $this->gethistoric_id(),
                ":hydrant_id"    => $this->gethydrant_id(),
                ":daydate"       => $this->getdaydate(),
                ":idkey"         => $this->getidkey(),
                ":hose"          => $this->gethose(),
                ":squirt"        => $this->getsquirt(),
                ":painting"      => $this->getpainting(),
                ":alarmcentral"  => $this->getalarmcentral(),
                ":glass"         => $this->getglass(),
                ":inlock"        => $this->getinlock(),
                ":record"        => $this->getrecord(),
                ":signaling"     => $this->getsignaling(),
                ":obstruction"   => $this->getobstruction(),
                ":observation"   => $this->getobservation()
            ));

            $this->setData($results);
            
            return $results[0]["MESSAGE"];
            
        }

        public function delete()
        {
            $sql = new Sql();
          
            $results = $sql->select("CALL prc_historicH_delete(:historic_id, :user_id)", array(
                ":historic_id"  =>(int)$this->gethistoric_id(),
                ":user_id"      =>(int)$this->getuser_id()
            ));
        
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }
    }

?>
