<?php
    namespace PRJM010\Model;
    use \PRJM010\DB\Sql;
    use \PRJM010\Model;
    
    class Visitant extends Model {

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
            
            $results =  $sql->select("CALL prc_visitant_sel(:name_person, :date_save, :date_fim, :start, :limit)", array(
                ":name_person"  => $list["name_person"],   
                ":date_save"    => $list["date_save"],
                ":date_fim"     => $list["date_fim"],
                ":start"        => $list["start"],
                ":limit"        => $list["limit"]
            ));

            return $results;
        }

        public static function listClassification()
        {
            $sql = new Sql();
            return $sql->select("CALL prc_classification_sel()");
        }
   
        public function getById($visitant_id) 
        {
            $sql = new Sql();
                     
            $results = $sql->select("CALL prc_visitant_sel_byid(:visitant_id)", array(
                ":visitant_id"=>(int)$visitant_id
            ));
            $results = Metodo::convertDateToView($results);
            
            $this->setData($results[0]);
        }

        public function save()
        {
            $sql = new Sql();
            
            $results = $sql->select("CALL prc_visitant_save(:name_person,:rg_person,:cpf_person,:email,:phonenumber,:photo,:company,:reason,:badge,:auth,:sign,:daydate,:dayhour,:classification_id)", array(
                ":name_person"      => $this->getname_person(),    
                ":rg_person"        => $this->getrg_person(),    
                ":cpf_person"       => $this->getcpf_person(),    
                ":email"            => $this->getemail(),    
                ":phonenumber"      => $this->getphonenumber(),    
                ":photo"            => $this->getphoto(),    
                ":company"          => $this->getcompany(),    
                ":reason"           => $this->getreason(),
                ":badge"            => $this->getbadge(),
                ":auth"             => $this->getauth(),
                ":sign"             => $this->getsign(),
                ":daydate"          => $this->getdaydate(),
                ":dayhour"          => $this->getdayhour(),
                ":classification_id"=> $this->getclassification_id()
            ));
            
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
        }
    
        public function update()
        {
            
            $sql = new Sql();
                            
            $results = $sql->select("CALL prc_visitant_update(:seq_person_id,:seq_classp_id,:visitant_id,:person_id,:name_person,:rg_person,:cpf_person,:email,:phonenumber,:photo,:company,:reason,:badge,:auth,:sign,:daydate,:dayhour,:classification_id,:situation)", array(
                ":seq_person_id"    => $this->getseq_person_id(),    
                ":seq_classp_id"    => $this->getseq_classp_id(),    
                ":visitant_id"      => $this->getvisitant_id(),    
                ":person_id"        => $this->getperson_id(),    
                ":name_person"      => $this->getname_person(),    
                ":rg_person"        => $this->getrg_person(),    
                ":cpf_person"       => $this->getcpf_person(),    
                ":email"            => $this->getemail(),    
                ":phonenumber"      => $this->getphonenumber(),    
                ":photo"            => $this->getphoto(),    
                ":company"          => $this->getcompany(),    
                ":reason"           => $this->getreason(),
                ":badge"            => $this->getbadge(),
                ":auth"             => $this->getauth(),
                ":sign"             => $this->getsign(),
                ":daydate"          => $this->getdaydate(),
                ":dayhour"          => $this->getdayhour(),
                ":classification_id"=> $this->getclassification_id(),
                ":situation"        => $this->getsituation()
            ));
            $this->setData($results);
            
            return $results[0]["MESSAGE"];
            
        }

        public function delete()
        {
            $sql = new Sql();
          
            $results = $sql->select("CALL prc_visitant_delete(:visitant_id)", array(
                ":visitant_id"  =>(int)$this->getvisitant_id()
            ));
            
            $this->setData($results);
            return $results[0]["MESSAGE"];
        }
    }
?>
