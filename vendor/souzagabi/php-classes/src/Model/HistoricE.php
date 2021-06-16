<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    
    class HistoricE extends Model {

        public static function listAll($list)
        {
            $sql = new Sql();
            
            $pg = isset($_GET["pg"]) ? $_GET["pg"] : 1;
          
            $list["limit"] = (isset($list["limit"]) && $list["limit"] != '') ? $list["limit"] : 10;
            $list["start"] = ($pg - 1) * $list["limit"];
            
            $results =  $sql->select("CALL prc_historicE_sel(:fireexting_id,:daydate, :date_fim, :start, :limit)", array(
                ":fireexting_id"    => $list["fireexting_id"],
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
            $results = $sql->select("CALL prc_historicE_sel_byid(:historic_id)", array(
                ":historic_id"=>(int)$historic_id
            ));
           
            $results[0] = Metodo::convertDateToView($results[0]);
            $this->setData($results[0]);
                     
        }

        public function save()
        {
            $sql = new Sql();
           
            $results = $sql->select("CALL prc_historicE_save(:fireexting_id,:daydate,:htrigger,:hose,:diffuser,:painting,:hydrostatic,:hothers)", array(
                ":fireexting_id" => $this->getfireexting_id(),
                ":daydate"       => $this->getdaydate(),
                ":htrigger"      => $this->gethtrigger(),
                ":hose"          => $this->gethose(),
                ":diffuser"      => $this->getdiffuser(),
                ":painting"      => $this->getpainting(),
                ":hydrostatic"   => $this->gethydrostatic(),
                ":hothers"       => $this->gethothers()
            ));
           
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }

        public function update()
        {
            
            $sql = new Sql();
                        
            $results = $sql->select("CALL prc_historicE_update(:historic_id,:fireexting_id,:daydate,:htrigger,:hose,:diffuser,:painting,:hydrostatic,:hothers)", array(
                ":historic_id"    => $this->gethistoric_id(),
                ":fireexting_id"  => $this->getfireexting_id(),
                ":daydate"        => $this->getdaydate(),
                ":htrigger"       => $this->gethtrigger(),
                ":hose"           => $this->gethose(),
                ":diffuser"       => $this->getdiffuser(),
                ":painting"       => $this->getpainting(),
                ":hydrostatic"    => $this->gethydrostatic(),
                ":hothers"        => $this->gethothers()
            ));

            $this->setData($results);
            
            return $results[0]["MESSAGE"];
            
        }

        public function delete()
        {
            $sql = new Sql();
          
            $results = $sql->select("CALL prc_historicE_delete(:historic_id, :user_id)", array(
                ":historic_id"  =>(int)$this->gethistoric_id(),
                ":user_id"      =>(int)$this->getuser_id()
            ));
        
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }
    }

?>
