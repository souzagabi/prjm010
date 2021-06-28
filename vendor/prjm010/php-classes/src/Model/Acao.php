<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    
    class Acao extends Model {

        public static function listAllIds()
        {
            $sql = new Sql();
            return $sql->select("CALL sp_acoes_list_all_id()");
        }
        public static function listAllAction($list)
        {
            $sql = new Sql();
            $list["start"] = 1;
            $pg = isset($_GET["pg"]) ? $_GET["pg"] : 1;
            
            $list["limit"] = (isset($list["limit"]) && $list["limit"] != '') ? $list["limit"] : 10;
           
            $list["start"] = ($pg - 1) * $list["limit"];
           
            foreach ($list as $key => $value) 
            {
                if ($value != '') {
                    $l[$key] = $value;
                }else {
                    $l[$key] = '';
                }
            }
            
            if(isset($list["listacoes"]) && $list["listacoes"] === "listacoes")
            {
                return $sql->select("CALL sp_acoes_list(:start, :limit)", array(
                    ":start"=> $l["start"],
                    ":limit"=> $l["limit"],
                ));
            }
        }
        public static function listAll($list)
        {
            $sql = new Sql();
            
            $list["start"] = 1;
            $pg = isset($_GET["pg"]) ? $_GET["pg"] : 1;
            $list["limit"] = (isset($list["limit"]) && $list["limit"] != '') ? $list["limit"] : 10;
            if (($pg - 1) * $list["limit"] > 0) {
                $list["start"] = ($pg - 1) * $list["limit"];
            }
            
            foreach ($list as $key => $value) 
            {
                if (isset($value) && ($value != '' || $value != NULL)) {
                    $l[$key] = $value;
                }else if (!isset($value) || ($value == '' || $value == NULL)){
                    $l[$key] = '';
                }
            }
            if ($l["start"] == 1) {
                $l["start"] = 0;
                // echo '</pre>';
                // print_r($l);
                // echo '<pre>';
            }
            
            
            // exit;
            return $sql->select("CALL sp_acoes_select_inv_buy_sell(:sgcompany, :dtbuy, :dtsell, :start, :limit)", array(
                ":sgcompany" => $list["sgcompany"],   
                ":dtbuy"     => $list["dtbuy"],
                ":dtsell"    => $list["dtsell"],
                ":start"     => $list["start"],
                ":limit"     => $list["limit"]
            ));
         
        }

        public static function listAllEstoque($list)
        {
            $sql = new Sql();
            $list["start"] = 0;
            $pg = isset($_GET["pg"]) ? $_GET["pg"] : 1;
            
            $list["limit"] = (isset($list["limit"]) && $list["limit"] != '') ? $list["limit"] : 10;
            $list["start"] = ($pg - 1) * $list["limit"];
            foreach ($list as $key => $value) 
            {
                if ($value != '') {
                    $l[$key] = $value;
                }else {
                    $l[$key] = '';
                }
            }
            
            if (isset($list) && $list != '') {
                
                if (count($list) >= 3) {
                   
                    return $sql->select("CALL sp_acoes_select_estoque(:sgcompany, :dtbuy, :dtsell, :start, :limit)", array(
                        ":sgcompany"    => $l["sgcompany"],    
                        ":dtbuy"        => $l["dtbuy"],
                        ":dtsell"       => $l["dtsell"],
                        ":start"        => $l["start"],
                        ":limit"        => $l["limit"]
                    ));
                } else if ($data[0] === "sgcompany") {
                    return $sql->select("CALL sp_acoes_select_estoque(:sgcompany, :dtbuy, :dtsell, :start, :limit)", array(
                        ":sgcompany"    => $l["sgcompany"],    
                        ":dtbuy"        => $l["dtbuy"],
                        ":dtsell"       => $l["dtsell"],
                        ":start"        => $l["start"],
                        ":limit"        => $l["limit"]
                    ));
                
                } else {
                    return $sql->select("CALL sp_acoes_select_estoque(:sgcompany, :dtbuy, :dtsell, :start, :limit)", array(
                        ":sgcompany"    => $l["sgcompany"],    
                        ":dtbuy"        => $l["dtbuy"],
                        ":dtsell"       => $l["dtsell"],
                        ":start"        => $l["start"],
                        ":limit"        => $l["limit"]
                    ));
                }
            } else{ // (isset($listestoque) && $listestoque != '')
                return $sql->select("CALL sp_acoes_select_estoque(:sgcompany, :dtbuy, :dtsell, :start, :limit)", array(
                    ":sgcompany"    => $l["sgcompany"],    
                    ":dtbuy"        => $l["dtbuy"],
                    ":dtsell"       => $l["dtsell"],
                    ":start"        => $l["start"],
                    ":limit"        => $l["limit"]
                ));
            }
        }

        //não está sendo usada
        public function getByPerson($idperson) 
        {
            $sql = new Sql();
            
            $results = $sql->select("CALL sp_acoes_person(:idperson)", array(
            ":idperson"=>$idperson
            ));
            
            if (isset($results[0]["tax"])) {
                $results[0]["tax"] = $results[0]["tax"]." %";
            }
            if (isset($results[0]["dtbuy"])) {
                $results[0]["dtbuy"] = $this->convertDateView($results[0]["dtbuy"]);
            }
            if (isset($results[0]["dtsell"])) {
                $results[0]["dtsell"] = $this->convertDateView($results[0]["dtsell"]);
            }
            $data = $results[0];
            
            $this->setData($data);
        }

        public function getByBuy($idinvestiment) 
        {
            $sql = new Sql();
                        
            $results = $sql->select("CALL sp_acoes_select_buy(:idinvestiment)", array(
                ":idinvestiment"=>(int)$idinvestiment
            ));
            
            if (isset($results[0]["tax"]) && $results[0]["tax"] > 0) {
                $results[0]["tax"] = $results[0]["tax"]." %";
            }
            $results[0]["unit"] = "unit";
                 
            $results[0] = Acao::convertDateToView($results[0]);
            
            $this->setData($results[0]);
        }

        public function save()
        {
            $sql = new Sql();
          
            $results = $sql->select("CALL sp_acoes_save_buy(:iduser, :desperson, :sgcompany, :descnpj, :dtbuy, :qtdebuy, :prcbuy, :tlbuy, :tptransaction, :btipe, :bprcaverage)", array(
                ":iduser"           => $this->getiduser(),    
                ":desperson"        => $this->getdesperson(),    
                ":sgcompany"        => $this->getsgcompany(),    
                ":descnpj"          => $this->getdescnpj(),    
                ":dtbuy"            => $this->getdtbuy(),
                ":qtdebuy"          => $this->getqtdebuy(),
                ":prcbuy"           => $this->getprcbuy(),
                ":tlbuy"            => $this->gettlbuy(),
                ":tptransaction"    => $this->gettptransaction(),
                ":btipe"            => $this->getbtipe(),
                ":bprcaverage"      => $this->getbprcaverage()
            ));
            
            $this->setData($results);
        }
        
        public function update()
        {
            $sql = new Sql();
            $qtdeTotal = ["qtdetotal"=>$this->getqtdetotal() + $this->getqtdebuy() - $this->getqtdesell()];
           
            $this->setData($qtdeTotal);
            
            $results = $sql->select("CALL sp_acoes_update_save(:idinvestiment, :iduser, :idperson, :desperson, :sgcompany, :descpfcnpj, :dtbuy, :qtdebuy, :prcbuy, :tlbuy, :bprcaverage, :btptransaction, :btipe, :dtsell, :qtdesell, :prcsell, :tlsell, :sprcaverage, :stptransaction, :btipe, :tax, :lucre, :idestoque, :sgecompany, :qtdeestoque)", array(
                                ":idinvestiment"    => $this->getidinvestiment(),
                                ":iduser"           => $this->getiduser(),   
                                ":idperson"         => $this->getidperson(),
                                ":desperson"        => $this->getdesperson(),    
                                ":sgcompany"        => $this->getsgcompany(),    
                                ":descpfcnpj"       => $this->getdescpfcnpj(),    
                                ":dtbuy"            => $this->getdtbuy(),
                                ":qtdebuy"          => $this->getqtdebuy(),
                                ":prcbuy"           => $this->getprcbuy(),
                                ":tlbuy"            => $this->gettlbuy(),
                                ":bprcaverage"      => $this->getbprcaverage(),
                                ":btptransaction"   => "C",
                                ":btipe"            => $this->getbtipe(),
                                ":dtsell"           => $this->getdtsell(),
                                ":qtdesell"         => $this->getqtdesell(),
                                ":prcsell"          => $this->getprcsell(),
                                ":tlsell"           => $this->gettlsell(),
                                ":sprcaverage"      => $this->getsprcaverage(),
                                ":stptransaction"   => "V",
                                ":stipe"            => $this->getbtipe(),
                                ":tax"              => $this->gettax(),
                                ":lucre"            => $this->getlucre(),
                                ":idestoque"        => $this->getidestoque(),
                                ":sgecompany"       => $this->getsgecompany(),
                                ":qtdeestoque"      => $this->getqtdetotal()
                        
            ));
           
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }

        public function delete()
        {
            $sql = new Sql();
            
            $sql->query("CALL sp_acoes_delete(:idinvestiment, :idestoque, :qtdetotal)", array(
                ":idinvestiment"    =>$this->getidinvestiment(),
                ":idestoque"        =>$this->getidestoque(),
                ":qtdetotal"        =>$this->getqtdetotal()
            ));
        }
        
    }
?>
