<?php
    namespace PRJM010\Model;
    use \PRJM010\Model;
    use \PRJM010\Model\Residual;
    use \PRJM010\Model\Material;
    use \PRJM010\Model\Visistant;
    use \PRJM010\Model\FireExting;

    class Metodo extends Model {
        
        public function convertDateToView($object = array())
        {
            $i = 0;
            // echo '<pre>';
            // print_r($object);
            // echo '</pre>';
            // exit;
            if (isset($object["daydate"]) && $object["daydate"] != '') {
                foreach ($object as $key => $value) {
                    if ($value != '' && ($key == "daydate" || $key == "dt_save" || $key == "rechargedate")) {
                        $object[$key] =  Metodo::convertDateView($value);
                    }
                    $i++;
                }
            } else 
            {
                if (isset($object)) {
                    foreach ($object as $key => $values) {
                        foreach ($values as $key => $value) {
                            if ($value != '' && ($key == "daydate" || $key == "dt_save" || $key == "rechargedate")) {
                                $values[$key] =  Metodo::convertDateView($value);
                            }
                        }
                        $object[$i] = $values;
                        $i++;
                    }
                }
            }
        
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

        public function selectRegister($act = array(), $model)
        {
            $classModel = "";
            $pgs        = [];
            if ($model == "Residual") {
                $classModel = Residual::listAll($act);
            }
            if ($model == "Material") {
                $classModel = Material::listAll($act);
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
            if ($model == "FireExtingH") {
                $classModel = FireExting::listHistoric($act);
            }
            $classModel = Metodo::convertDateToView($classModel);
            $classModel = Metodo::convertToInt($classModel);
            if (isset($classModel[0]["pgs"]) && count($classModel) > 0 && $classModel != '') {
                $pgs 	= Metodo::countRegister($classModel[0]["pgs"], $act);
            }
                              
            return [$classModel, $pgs];
        }
    }
?>
