<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    
    class Material extends Model {


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
            
            return  $sql->select("CALL prc_material_sel(:receiver, :daydate, :date_fim, :start, :limit)", array(
                ":receiver"     => $list["receiver"],   
                ":daydate"      => $list["daydate"],
                ":date_fim"     => $list["date_fim"],
                ":start"        => $list["start"],
                ":limit"        => $list["limit"]
            ));
        }

        public function getById($material_id) 
        {
            $sql = new Sql();
            $results = $sql->select("CALL prc_material_sel_byid(:material_id)", array(
                ":material_id"=>(int)$material_id
            ));
            
            $results[0] = Metodo::convertDateToView($results[0]);
            $this->setData($results[0]);
                     
        }

        public function save()
        {
            $sql = new Sql();
          
            $results = $sql->select("CALL prc_material_save(:user_id,:person_id,:daydate,:dayhour,:material,:qtde,:packing,:receiver,:deliveryman)", array(
                ":user_id"          => $this->getuser_id(),
                ":person_id"        => $this->getperson_id(),
                ":daydate"          => $this->getdaydate(),
                ":dayhour"          => $this->getdayhour(),
                ":material"         => $this->getmaterial(),
                ":qtde"             => $this->getqtde(),
                ":packing"          => $this->getpacking(),
                ":receiver"         => $this->getreceiver(),
                ":deliveryman"      => $this->getdeliveryman()
            ));
            
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }

        public function update()
        {
            
            $sql = new Sql();
            
            
            $results = $sql->select("CALL prc_material_update(:material_id,:user_id,:person_id,:daydate,:dayhour,:material,:qtde,:packing,:receiver,:deliveryman,:situation)", array(
                ":material_id"      => $this->getmaterial_id(),
                ":user_id"          => $this->getuser_id(),
                ":person_id"        => $this->getperson_id(),
                ":daydate"          => $this->getdaydate(),
                ":dayhour"          => $this->getdayhour(),
                ":material"         => $this->getmaterial(),
                ":qtde"             => $this->getqtde(),
                ":packing"          => $this->getpacking(),
                ":receiver"         => $this->getreceiver(),
                ":deliveryman"      => $this->getdeliveryman(),
                ":situation"        => $this->getsituation()
            ));

            $this->setData($results);
            
            return $results[0]["MESSAGE"];
            
        }

        public function delete()
        {
            $sql = new Sql();
          
            $results = $sql->select("CALL prc_material_delete(:material_id, :user_id)", array(
                ":material_id"  =>(int)$this->getmaterial_id(),
                ":user_id"      =>(int)$this->getuser_id()
            ));
        
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }

    }

?>
