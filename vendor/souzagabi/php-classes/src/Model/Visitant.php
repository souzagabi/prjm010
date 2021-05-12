<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    
    class Visitant extends Model {

        // public static function listAllIds()
        // {
        //     $sql = new Sql();
        //     return $sql->select("CALL sp_acoes_list_all_id()");
        // }
        // public static function listAllAction($list)
        // {
        //     $sql = new Sql();
        //     $list["start"] = 1;
        //     $pg = isset($_GET["pg"]) ? $_GET["pg"] : 1;
            
        //     $list["limit"] = (isset($list["limit"]) && $list["limit"] != '') ? $list["limit"] : 10;
           
        //     $list["start"] = ($pg - 1) * $list["limit"];
           
        //     foreach ($list as $key => $value) 
        //     {
        //         if ($value != '') {
        //             $l[$key] = $value;
        //         }else {
        //             $l[$key] = '';
        //         }
        //     }
            
        //     if(isset($list["listacoes"]) && $list["listacoes"] === "listacoes")
        //     {
        //         return $sql->select("CALL sp_acoes_list(:start, :limit)", array(
        //             ":start"=> $l["start"],
        //             ":limit"=> $l["limit"],
        //         ));
        //     }
        // }
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
            }
           
            return $sql->select("CALL prc_visitant_sel(:name_person, :date_save, :date_fim, :start, :limit)", array(
                ":name_person"  => $list["name_person"],   
                ":date_save"    => $list["date_save"],
                ":date_fim"     => $list["date_fim"],
                ":start"        => $list["start"],
                ":limit"        => $list["limit"]
            ));
         
        }

        public static function listClassification()
        {
            $sql = new Sql();
            return $sql->select("Call prc_classification_sel()");
        }
        // public static function listAllEstoque($list)
        // {
        //     $sql = new Sql();
        //     $list["start"] = 0;
        //     $pg = isset($_GET["pg"]) ? $_GET["pg"] : 1;
            
        //     $list["limit"] = (isset($list["limit"]) && $list["limit"] != '') ? $list["limit"] : 10;
        //     $list["start"] = ($pg - 1) * $list["limit"];
        //     foreach ($list as $key => $value) 
        //     {
        //         if ($value != '') {
        //             $l[$key] = $value;
        //         }else {
        //             $l[$key] = '';
        //         }
        //     }
            
        //     if (isset($list) && $list != '') {
                
        //         if (count($list) >= 3) {
                   
        //             return $sql->select("CALL sp_acoes_select_estoque(:sgcompany, :dtbuy, :dtsell, :start, :limit)", array(
        //                 ":sgcompany"    => $l["sgcompany"],    
        //                 ":dtbuy"        => $l["dtbuy"],
        //                 ":dtsell"       => $l["dtsell"],
        //                 ":start"        => $l["start"],
        //                 ":limit"        => $l["limit"]
        //             ));
        //         } else if ($data[0] === "sgcompany") {
        //             return $sql->select("CALL sp_acoes_select_estoque(:sgcompany, :dtbuy, :dtsell, :start, :limit)", array(
        //                 ":sgcompany"    => $l["sgcompany"],    
        //                 ":dtbuy"        => $l["dtbuy"],
        //                 ":dtsell"       => $l["dtsell"],
        //                 ":start"        => $l["start"],
        //                 ":limit"        => $l["limit"]
        //             ));
                
        //         } else {
        //             return $sql->select("CALL sp_acoes_select_estoque(:sgcompany, :dtbuy, :dtsell, :start, :limit)", array(
        //                 ":sgcompany"    => $l["sgcompany"],    
        //                 ":dtbuy"        => $l["dtbuy"],
        //                 ":dtsell"       => $l["dtsell"],
        //                 ":start"        => $l["start"],
        //                 ":limit"        => $l["limit"]
        //             ));
        //         }
        //     } else{ // (isset($listestoque) && $listestoque != '')
        //         return $sql->select("CALL sp_acoes_select_estoque(:sgcompany, :dtbuy, :dtsell, :start, :limit)", array(
        //             ":sgcompany"    => $l["sgcompany"],    
        //             ":dtbuy"        => $l["dtbuy"],
        //             ":dtsell"       => $l["dtsell"],
        //             ":start"        => $l["start"],
        //             ":limit"        => $l["limit"]
        //         ));
        //     }
        // }

        // //não está sendo usada
        // public function getByPerson($idperson) 
        // {
        //     $sql = new Sql();
            
        //     $results = $sql->select("CALL sp_acoes_person(:idperson)", array(
        //     ":idperson"=>$idperson
        //     ));
            
        //     if (isset($results[0]["tax"])) {
        //         $results[0]["tax"] = $results[0]["tax"]." %";
        //     }
        //     if (isset($results[0]["dtbuy"])) {
        //         $results[0]["dtbuy"] = $this->convertDateView($results[0]["dtbuy"]);
        //     }
        //     if (isset($results[0]["dtsell"])) {
        //         $results[0]["dtsell"] = $this->convertDateView($results[0]["dtsell"]);
        //     }
        //     $data = $results[0];
            
        //     $this->setData($data);
        // }

        // public function getByBuy($idinvestiment) 
        // {
        //     $sql = new Sql();
                        
        //     $results = $sql->select("CALL sp_acoes_select_buy(:idinvestiment)", array(
        //         ":idinvestiment"=>(int)$idinvestiment
        //     ));
            
        //     if (isset($results[0]["tax"]) && $results[0]["tax"] > 0) {
        //         $results[0]["tax"] = $results[0]["tax"]." %";
        //     }
        //     $results[0]["unit"] = "unit";
                 
        //     $results[0] = Acao::convertDateToView($results[0]);
            
        //     $this->setData($results[0]);
        // }

        public function save()
        {
            $sql = new Sql();
            // echo '<pre>';
            // print_r($this);
            // echo '</pre>';
            // exit;
          
            $results = $sql->select("CALL prc_visitant_save(:name_person,:rg_person,:phonenumber,:company,:reason,:badge,:auth,:sign,:daydate,:dayhour,:user_id,:classification)", array(
                ":name_person"      => $this->getname_person(),    
                ":rg_person"        => $this->getrg_person(),    
                ":phonenumber"      => $this->getphonenumber(),    
                ":company"          => $this->getcompany(),    
                ":reason"           => $this->getreason(),
                ":badge"            => $this->getbadge(),
                ":auth"             => $this->getauth(),
                ":sign"             => $this->getsign(),
                ":daydate"          => $this->getdaydate(),
                ":dayhour"          => $this->getdayhour(),
                ":user_id"          => $this->getuser_id(),
                ":classification"   => $this->getclassification()
            ));
            
            $this->setData($results);
        }
        
        // public function update()
        // {
        //     $sql = new Sql();
        //     $qtdeTotal = ["qtdetotal"=>$this->getqtdetotal() + $this->getqtdebuy() - $this->getqtdesell()];
           
        //     $this->setData($qtdeTotal);
            
        //     $results = $sql->select("CALL sp_acoes_update_save(:idinvestiment, :iduser, :idperson, :desperson, :sgcompany, :descpfcnpj, :dtbuy, :qtdebuy, :prcbuy, :tlbuy, :bprcaverage, :btptransaction, :btipe, :dtsell, :qtdesell, :prcsell, :tlsell, :sprcaverage, :stptransaction, :btipe, :tax, :lucre, :idestoque, :sgecompany, :qtdeestoque)", array(
        //                         ":idinvestiment"    => $this->getidinvestiment(),
        //                         ":iduser"           => $this->getiduser(),   
        //                         ":idperson"         => $this->getidperson(),
        //                         ":desperson"        => $this->getdesperson(),    
        //                         ":sgcompany"        => $this->getsgcompany(),    
        //                         ":descpfcnpj"       => $this->getdescpfcnpj(),    
        //                         ":dtbuy"            => $this->getdtbuy(),
        //                         ":qtdebuy"          => $this->getqtdebuy(),
        //                         ":prcbuy"           => $this->getprcbuy(),
        //                         ":tlbuy"            => $this->gettlbuy(),
        //                         ":bprcaverage"      => $this->getbprcaverage(),
        //                         ":btptransaction"   => "C",
        //                         ":btipe"            => $this->getbtipe(),
        //                         ":dtsell"           => $this->getdtsell(),
        //                         ":qtdesell"         => $this->getqtdesell(),
        //                         ":prcsell"          => $this->getprcsell(),
        //                         ":tlsell"           => $this->gettlsell(),
        //                         ":sprcaverage"      => $this->getsprcaverage(),
        //                         ":stptransaction"   => "V",
        //                         ":stipe"            => $this->getbtipe(),
        //                         ":tax"              => $this->gettax(),
        //                         ":lucre"            => $this->getlucre(),
        //                         ":idestoque"        => $this->getidestoque(),
        //                         ":sgecompany"       => $this->getsgecompany(),
        //                         ":qtdeestoque"      => $this->getqtdetotal()
                        
        //     ));
           
        //     $this->setData($results);
        //     return $results[0]["MESSAGE"];
        // }

        // public function delete()
        // {
        //     $sql = new Sql();
            
        //     $sql->query("CALL sp_acoes_delete(:idinvestiment, :idestoque, :qtdetotal)", array(
        //         ":idinvestiment"    =>$this->getidinvestiment(),
        //         ":idestoque"        =>$this->getidestoque(),
        //         ":qtdetotal"        =>$this->getqtdetotal()
        //     ));
        // }
        
        public function convertDateToView($object = array())
        {
            for ($i=0; $i < count($object); $i++) { 
                if (isset($object["daydate"]) && $object["daydate"] != '') {
                    $object["daydate"] =  Visitant::convertDateView($object["daydate"]);
                }
            }
            return $object;
        }
        
        public function convertDateToDataBase($object = array())
        {
            for ($i=0; $i < count($object); $i++) { 
                foreach ($object as $key => $value) {
                    if (isset($object[$key]) && $object[$key] !='') {
                        $object[$key] =  Visitant::convertDateDataBase($object[$key]);
                    }
                }
            }
            return $object;
           
        }

        public function convertDateView($date)
        {
            return $data = date("d-m-Y", strToTime($date));
        }

        public function convertDateDataBase($date)
        {
            return $data = date("Y-m-d", strToTime($date));
        }
        
        public function convertToInt($object = array())
        {
            if (isset($object[0]["pgs"])) {
                for ($i=0; $i < count($object); $i++) { 
                    $object[$i]["pgs"] = ceil($object[$i]["pgs"]);
                }
                return $object;
            }
            return $object;
        }

        public function countRegister($qtdeRegister, $company)
        {
            $pgs = [];
            for ($j=0; $j < $qtdeRegister - 1; $j++) { 
                $pgs[$j]    = $j;
            }
            $pgs["list"]["limit"] = '';
            foreach ($company as $key => $value) {
                $pgs["list"][$key] = $value;
            }
            
            return $pgs;
        }
        public function selectRegister($act = array())
        {
            $visitants 	= "";
            $pgs        = [];
            if ($act["visitants"]) {
                $visitants 	    = Visitant::listAll($act);
                // echo '<pre>';
                // print_r($visitants);
                // echo '</pre>';
                // exit;
                $visitants[0] 	= Visitant::convertDateToView($visitants[0]);
                $visitants 	    = Visitant::convertToInt($visitants);
            }
              
            if (isset($visitants[0]["pgs"]) && count($visitants) > 0 && $visitants != '') {
                $pgs 	= Visitant::countRegister($visitants[0]["pgs"], $act);
            }
          
            return [$visitants, $pgs];
        }
    }
?>
