<?php
    namespace PRJM010;
    use Rain\Tpl;

    class Page{
        private $tpl;
        private $options = [];
        private $defaults = [
            "header"=> true,
            "teste"=>"Teste2",
            "footer"=> true,
            "data"=>[]
        ];
        public function __construct($opts = array(), $tpl_dir = "/views/")
        {
            $this->options = array_merge($this->defaults, $opts);

            //Configura o diretório raiz para desenhar o header e o footer
            $config = array(
               "tpl_dir"    => $_SERVER['DOCUMENT_ROOT']."/views/", 
               "cache_dir"  => $_SERVER['DOCUMENT_ROOT']."/views-cache/", 
               "debug"      => false           
            );
            
            Tpl::configure( $config );

            $this->tpl = new Tpl;

            if($this->options["header"] === true){ 
                $this->setTpl("header", $this->options["data"]);
            }
            
            //Configura o diretório de cada componente para desenhar o content
            $config = array(
                "tpl_dir"    => $_SERVER['DOCUMENT_ROOT'].$tpl_dir, 
                "cache_dir"  => $_SERVER['DOCUMENT_ROOT']."/views-cache/", 
                "debug"      => false           
             );
             
             Tpl::configure( $config );
 
             $this->tpl = new Tpl;
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
            //Configura o diretório raiz para desenhar o header e o footer
            $config = array(
                "tpl_dir"    => $_SERVER['DOCUMENT_ROOT']."/views/", 
                "cache_dir"  => $_SERVER['DOCUMENT_ROOT']."/views-cache/", 
                "debug"      => false           
             );
             
             Tpl::configure( $config );
 
             $this->tpl = new Tpl;
             
            if($this->options["footer"] === true) 
            {
                $this->tpl->draw("footer");
            }
        }
    }
?>
