<?php
    namespace PRJM010;

    class PageLocal extends Page
    {
        public function __construct($opts = array(), $tpl_dir = "/views/local/")
        {
            parent::__construct($opts, $tpl_dir);
        }
    }
?>
