<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    
    class Clothing extends Model {

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
    
            return  $sql->select("CALL prc_clothing_sel(:dateout, :datein,:start, :limit)", array(
                ":dateout"      => $list["dateout"],
                ":datein"       => $list["datein"],
                ":start"        => $list["start"],
                ":limit"        => $list["limit"]
            ));
        }

        public function getById($clothing_id) 
        {
            $sql = new Sql();
            $results = $sql->select("CALL prc_clothing_sel_byid(:clothing_id)", array(
                ":clothing_id"=>(int)$clothing_id
            ));
            $results[0] = Metodo::convertDateToView($results[0]);
      
            $this->setData($results[0]);
                     
        }

        public function save()
        {
            $sql = new Sql();
           
            $results = $sql->select("CALL prc_clothing_save(:person_id,:dateout,:qtdeout,:signout,:datein,:qtdein,:signin)", array(
                ":person_id"        => $this->getperson_id(),
                ":dateout"          => $this->getdateout(),
                ":qtdeout"          => $this->getqtdeout(),
                ":signout"          => $this->getsignout(),
                ":datein"           => $this->getdatein(),
                ":qtdein"           => $this->getqtdein(),
                ":signin"           => $this->getsignin()
            ));
            
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }

        public function update()
        {
            
            $sql = new Sql();

            $results = $sql->select("CALL prc_clothing_update(:clothing_id,:person_id,:dateout,:qtdeout,:signout,:datein,:qtdein,:signin)", array(
                ":clothing_id"      => $this->getclothing_id(),
                ":person_id"        => $this->getperson_id(),
                ":dateout"          => $this->getdateout(),
                ":qtdeout"          => $this->getqtdeout(),
                ":signout"          => $this->getsignout(),
                ":datein"           => $this->getdatein(),
                ":qtdein"           => $this->getqtdein(),
                ":signin"           => $this->getsignin()
            ));

            $this->setData($results);
            
            return $results[0]["MESSAGE"];
            
        }

        public function delete()
        {
            $sql = new Sql();
          
            $results = $sql->select("CALL prc_clothing_delete(:clothing_id, :user_id)", array(
                ":clothing_id"  =>(int)$this->getclothing_id(),
                ":user_id"      =>(int)$this->getuser_id()
            ));
        
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }

    }
?>
