<?php
    namespace PRJM010;

    class PagePurifier extends Page
    {
        public function __construct($opts = array(), $tpl_dir = "/views/purifier/")
        {
            parent::__construct($opts, $tpl_dir);
        }
    }
?>
