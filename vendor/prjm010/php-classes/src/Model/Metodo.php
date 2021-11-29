<?php
    namespace PRJM010\Model;
    use \PRJM010\Model;
    use \PRJM010\Model\Residual;
    use \PRJM010\Model\Goods;
    use \PRJM010\Model\Visistant;
    use \PRJM010\Model\FireExting;
    use \PRJM010\Model\HistoricE;
    use \PRJM010\Model\Purifier;
    use \PRJM010\Model\HistoricP;
    use \PRJM010\Model\Clothing;
    use \PRJM010\Model\HistoricH;
    use \PRJM010\Model\AirConditioning;
    use \PRJM010\Model\HistoricA;
    use \PRJM010\Model\AnualPlan;

    class Metodo extends Model {
        
        public function convertDateToView($object = array())
        {
            $i = 0;
            
            //if ((isset($object["daydate"]) && $object["daydate"] != '') || (isset($object["dateout"]) && $object["dateout"] != '')  || (isset($object["datein"]) && $object["datein"] != '') || (isset($object["dtprevision"]) && $object["dtprevision"] != '')) {
                // foreach ($object as $key => $value) {
                //     $d = date_create_from_format('Y-m-d', $value);
                //     if($d && $d->format('Y-m-d') == $value){
                //         $values[$key] =  Metodo::convertDateView($value);
                //     }
                //     // if ($value != '' && ($key == "daydate" || $key == "dt_save" || $key == "rechargedate" || $key == "nextmanager") || $key == "dateout"  || $key == "datein" || $key == "dtprevision") {
                //     //     $object[$key] =  Metodo::convertDateView($value);
                //     // }
                //     $i++;
                // }
            // } else 
            // {
                if (isset($object)) {
                    foreach ($object as $key => $values) {
                        
                        foreach ($values as $key => $value) {
                            $d = date_create_from_format('Y-m-d', $value);
                            if($d && $d->format('Y-m-d') == $value){
                                $values[$key] =  Metodo::convertDateView($value);
                            }
                            // if ($value != '' && ($key == "daydate" || $key == "dt_save" || $key == "rechargedate" || $key == "nextmanager" || $key == "dateout"  || $key == "datein" || $key == "dtprevision")) {
                            //     $values[$key] =  Metodo::convertDateView($value);
                            // }
                        }
                        $object[$i] = $values;
                        $i++;
                    }
                  
                }
            // }
        
            return $object;
        }
        
        public function convertDateToDataBase($object = array())
        {
            
            foreach ($object as $key => $value) {
                if (isset($value) && $value !='') {
                    $object[$key] =  Metodo::convertDateDataBase($object[$key]);
                }
            }
            return $object;
            
        }

        public function convertDateView($date)
        {
            $data = date("d-m-Y", strToTime($date));
            if ($data == '31-12-1969')
            {
                $data = '';
            }   
            return  $data;
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

        public function selectRegister($act = array(), $model)
        {
            $classModel = "";
            $pgs        = [];
//====================================================================================================\\
//                     Início de verificar limite do filtro e período do filtro                       \\
//====================================================================================================\\
            $pg = isset($_GET["pg"]) ? $_GET["pg"] : 1;
            
            $act["limit"] = (isset($act["limit"]) && $act["limit"] != '') ? $act["limit"] : 20;
            
            if (!isset($act["start"]) || $act["start"] == "") {
                $act["start"] = ($pg - 1) * $act["limit"];
            }
      
            $dataInicio = Date('Y')."-".Date('m')."-"."01";
            $dataFim    = Date('Y')."-".Date('m')."-".Date('t');
   
            if ((isset($act["daydate"]) && $act["daydate"] == "") || !isset($act["daydate"])) {
                $act["daydate"] = $dataInicio;
            }
            
            if ((isset($act["date_fim"]) && $act["date_fim"] == "") || !isset($act["date_fim"])) {
                $act["date_fim"] = $dataFim;
            }
           
//====================================================================================================\\            
//                        Fim de verificar limite do filtro e período do filtro                       \\
//====================================================================================================\\
            



            if ($model == "Residual") {
                $classModel = Residual::listAll($act);
            }
            if ($model == "Goods") {
                $classModel = Goods::listAll($act);
            }
            if ($model == "Visitant") {
                $classModel = Visitant::listAll($act);
            }
            if ($model == "Nobreak") {
                $classModel = Nobreak::listAll($act);
            }
            if ($model == "FireExting") {
                $classModel = FireExting::listAll($act);
            }
            
            if ($model == "HistoricE") {
                $classModel = HistoricE::listAll($act);
            }
            if ($model == "Purifier") {
                $classModel = Purifier::listAll($act);
            }
            if ($model == "HistoricP") {
                $classModel = HistoricP::listAll($act);
            }
            if ($model == "Clothing") {
                $classModel = Clothing::listAll($act);
            }
            if ($model == "Material") {
                $classModel = Material::listAll($act);
            }
            if ($model == "Hydrant") {
                $classModel = Hydrant::listAll($act);
            }
            if ($model == "HistoricH") {
                $classModel = HistoricH::listAll($act);
            }
            if ($model == "AirConditioning") {
                $classModel = AirConditioning::listAll($act);
            }
            if ($model == "HistoricA") {
                $classModel = HistoricA::listAll($act);
            }
            if ($model == "Equipament") {
                $classModel = AnualPlan::listEquipamentAll($act);
            }
            if ($model == "Location") {
                $classModel = Location::listAll($act);
            }
            if ($model == "Local") {
                $classModel = Local::listAll($act);
            }
            if ($model == "Responsable") {
                $classModel = AnualPlan::listResponsableAll($act);
            }
            if ($model == "AnualPlan") {
                $classModel = AnualPlan::listAnualPlanAll($act);
            }
            if ($model == "GeneralControl") {
                $classModel = GeneralControl::listGeneralControlAll($act);
            }
            
            $classModel = Metodo::convertDateToView($classModel);
            $classModel = Metodo::convertToInt($classModel);
            if (isset($classModel[0]["pgs"]) && count($classModel) > 0 && $classModel != '') {
                $pgs 	= Metodo::countRegister($classModel[0]["pgs"], $act);
            }
            return [$classModel, $pgs];
        }
        
        public function divideMessage($msg){
    
            $m = explode(':',$msg);
            $ms = ["state"=>$m[0], "msg"=> $m[1], "err"=>""];
            
            return $ms;
        }
    }

?>
