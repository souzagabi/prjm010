<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    
    class Local extends Model {

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
            $results =  $sql->select("CALL prc_local_sel(:start, :limit)", array(
                ":start"        => $list["start"],
                ":limit"        => $list["limit"]
            ));
            
            return $results;
        }

        public function getById($local_id) 
        {
            $sql = new Sql();
            $results = $sql->select("CALL prc_local_sel_byid(:local_id)", array(
                ":local_id"=>(int)$local_id
            ));
            
            $this->setData($results[0]);
                     
        }

        public function save()
        {
            $sql = new Sql();
           
            $results = $sql->select("CALL prc_local_save(:deslocal)", array(
                ":deslocal"      => $this->getdeslocal()
            ));
            
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }

        public function update()
        {
            
            $sql = new Sql();

            $results = $sql->select("CALL prc_local_update(:local_id,:deslocal)", array(
                ":local_id"      => $this->getlocal_id(),
                ":deslocal"      => $this->getdeslocal()
            ));

            $this->setData($results);
            //var_dump($results[0]);exit;
            return $results[0]["MESSAGE"];
            
        }

        public function delete()
        {
            $sql = new Sql();
          
            $results = $sql->select("CALL prc_local_delete(:local_id,:user_id)", array(
                ":local_id"  =>(int)$this->getlocal_id(),
                ":user_id"  =>(int)$this->getuser_id()
            ));
        
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }

    }

?>
