<?php
    namespace PRJM010;
    use Rain\Tpl;

    class Page{
        private $tpl;
        private $options = [];
        private $defaults = [
            "header"=> true,
            "footer"=> true,
            "data"=>[]
        ];
        public function __construct($opts = array(), $tpl_dir = "/views/")
        {
            $this->options = array_merge($this->defaults, $opts);

            $this->setConfig("/views/");

            if($this->options["header"] === true){ 
                $this->setTpl("header", $this->options["data"]);
            }
            
            $this->setConfig($tpl_dir);
        }
        
        private function setData($data = array())
        {
            foreach ($data as $key => $value) {
                $this->tpl->assign($key, $value);
            }
        }
        
        public function setTpl($name, $data = array(), $returnHTML = false)
        {
            $this->setData($data);
            return $this->tpl->draw($name, $returnHTML);
        }
        
        public function __destruct()
        {
            $this->setConfig("/views/");
             
            if($this->options["footer"] === true) 
            {
                $this->tpl->draw("footer");
            }
        }
        
        private function setConfig($tpl_dir)
        {
            //Configura o diretório raiz para carregar header,o footer e os contents
            $config = array(
                "tpl_dir"    => $_SERVER['DOCUMENT_ROOT'].$tpl_dir, 
                "cache_dir"  => $_SERVER['DOCUMENT_ROOT']."/views-cache/", 
                "debug"      => false           
             );
             
             Tpl::configure( $config );
 
             $this->tpl = new Tpl;
        }
    }
?>
