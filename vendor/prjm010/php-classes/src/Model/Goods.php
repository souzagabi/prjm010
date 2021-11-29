<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    
    class Goods extends Model {

        public static function listAll($list)
        {
            $sql = new Sql();
         
            return  $sql->select("CALL prc_goods_sel(:goods, :daydate, :date_fim, :start, :limit)", array(
                ":goods"        => $list["goods"],   
                ":daydate"      => $list["daydate"],
                ":date_fim"     => $list["date_fim"],
                ":start"        => $list["start"],
                ":limit"        => $list["limit"]
            ));
        }

        public function getById($goods_id) 
        {
            $sql = new Sql();
            $results = $sql->select("CALL prc_goods_sel_byid(:goods_id)", array(
                ":goods_id"=>(int)$goods_id
            ));
           
            $results = Metodo::convertDateToView($results);
            $this->setData($results[0]);
                     
        }

        public function save()
        {
            $sql = new Sql();
            
            $results = $sql->select("CALL prc_goods_save(:person_id,:daydate,:dayhour,:goods,:qtde,:packing,:receiver,:deliveryman)", array(
                ":person_id"        => $this->getperson_id(),
                ":daydate"          => $this->getdaydate(),
                ":dayhour"          => $this->getdayhour(),
                ":goods"            => $this->getgoods(),
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
             
            $results = $sql->select("CALL prc_goods_update(:goods_id,:person_id,:daydate,:dayhour,:goods,:qtde,:packing,:receiver,:deliveryman,:situation)", array(
                ":goods_id"         => $this->getgoods_id(),
                ":person_id"        => $this->getperson_id(),
                ":daydate"          => $this->getdaydate(),
                ":dayhour"          => $this->getdayhour(),
                ":goods"            => $this->getgoods(),
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
          
            $results = $sql->select("CALL prc_goods_delete(:goods_id)", array(
                ":goods_id"  =>(int)$this->getgoods_id()
            ));
        
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }

    }

?>
