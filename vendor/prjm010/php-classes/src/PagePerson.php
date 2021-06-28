<?php
    namespace PRJM010;

    class PagePerson extends Page
    {
        public function __construct($opts = array(), $tpl_dir = "/views/persons/")
        {
            parent::__construct($opts, $tpl_dir);
        }
    }
?>
