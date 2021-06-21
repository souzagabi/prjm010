<?php if(!class_exists('Rain\Tpl')){exit;}?><!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Manutenção</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="../../config/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
  <!-- jvectormap -->
  <link rel="stylesheet" href="../../config/plugins/jvectormap/jquery-jvectormap-1.2.2.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../config/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. We have chosen the skin-blue for this starter
        page. However, you can choose any other skin. Make sure you
        apply the skin class to the body tag so the changes take effect.
  -->
  <link rel="stylesheet" href="../../config/css/skins/skin-blue.min.css">
  <link rel="stylesheet" href="../../config/css/index.css">
  <link rel="shortcut icon" href="../../img/favicon.jpg" type="image/x-icon">
  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
</head>
<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

  <!-- Main Header -->
  <header class="main-header">

    <!-- Logo -->
    <a href="../../config/index2.html" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>M</b>NT</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>Manutenção</b> - MNT</span>
    </a>

    <!-- Header Navbar -->
    <nav class="navbar navbar-static-top" role="navigation">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>
      <!-- Navbar Right Menu -->
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <!-- Messages: style can be found in dropdown.less-->
          <li class="dropdown messages-menu">
            <!-- Menu toggle button -->
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-envelope-o"></i>
              <span class="label label-success">4</span>
            </a>
            <ul class="dropdown-menu">
              <li class="header">You have 4 messages</li>
              <li>
                <!-- inner menu: contains the messages -->
                <ul class="menu">
                  <li><!-- start message -->
                    <a href="#">
                      <div class="pull-left">
                        <!-- User Image -->
                        <img class="img-circle" src="../../image/<?php if( $_SESSION['User']["photo"] == 0 ){ ?>admin.jpg<?php }else{ ?><?php echo htmlspecialchars( $_SESSION['User']["user_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>.jpg<?php } ?>">
                      </div>
                      <!-- Message title and timestamp -->
                      <h4>
                        Support Team
                        <small><i class="fa fa-clock-o"></i> 5 mins</small>
                      </h4>
                      <!-- The message -->
                      <p>Why not buy a new awesome theme?</p>
                    </a>
                  </li>
                  <!-- end message -->
                </ul>
                <!-- /.menu -->
              </li>
              <li class="footer"><a href="#">See All Messages</a></li>
            </ul>
          </li>
          <!-- /.messages-menu -->

          <!-- Notifications Menu -->
          <li class="dropdown notifications-menu">
            <!-- Menu toggle button -->
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-bell-o"></i>
              <span class="label label-warning">10</span>
            </a>
            <ul class="dropdown-menu">
              <li class="header">You have 10 notifications</li>
              <li>
                <!-- Inner Menu: contains the notifications -->
                <ul class="menu">
                  <li><!-- start notification -->
                    <a href="#">
                      <i class="fa fa-users text-aqua"></i> 5 new members joined today
                    </a>
                  </li>
                  <!-- end notification -->
                </ul>
              </li>
              <li class="footer"><a href="#">View all</a></li>
            </ul>
          </li>
          <!-- Tasks Menu -->
          <li class="dropdown tasks-menu">
            <!-- Menu Toggle Button -->
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-flag-o"></i>
              <span class="label label-danger">9</span>
            </a>
            <ul class="dropdown-menu">
              <li class="header">You have 9 tasks</li>
              <li>
                <!-- Inner menu: contains the tasks -->
                <ul class="menu">
                  <li><!-- Task item -->
                    <a href="#">
                      <!-- Task title and progress text -->
                      <h3>
                        Design some buttons
                        <small class="pull-right">20%</small>
                      </h3>
                      <!-- The progress bar -->
                      <div class="progress xs">
                        <!-- Change the css width attribute to simulate progress -->
                        <div class="progress-bar progress-bar-aqua" style="width: 20%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                          <span class="sr-only">20% Complete</span>
                        </div>
                      </div>
                    </a>
                  </li>
                  <!-- end task item -->
                </ul>
              </li>
              <li class="footer">
                <a href="#">View all tasks</a>
              </li>
            </ul>
          </li>
          <!-- User Account Menu -->
          <li class="dropdown user user-menu">
            <!-- Menu Toggle Button -->
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <!-- The user image in the navbar-->
              <img class="user-image" src="../../image/<?php if( $_SESSION['User']["photo"] == 0 ){ ?>admin.jpg<?php }else{ ?><?php echo htmlspecialchars( $_SESSION['User']["user_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>.jpg<?php } ?>">
              <!-- hidden-xs hides the username on small devices so only the image appears. -->
              
              <span class="hidden-xs"><?php echo htmlspecialchars( $_SESSION['User']["name_person"], ENT_COMPAT, 'UTF-8', FALSE ); ?></span>
              
            </a>
            <ul class="dropdown-menu">
              <!-- The user image in the menu -->
              
              <li class="user-header">
                <img class="user-image" src="../../image/<?php if( $_SESSION['User']["photo"] == 0 ){ ?>admin.jpg<?php }else{ ?><?php echo htmlspecialchars( $_SESSION['User']["user_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>.jpg<?php } ?>">
                <p>
                  <?php echo htmlspecialchars( $_SESSION['User']["name_person"], ENT_COMPAT, 'UTF-8', FALSE ); ?>
                </p>
              </li>
              <!-- Menu Footer-->
              <li class="user-footer">
                <div class="pull-left" hidden>
                  <a href="#" class="btn btn-info btn-flat">Perfil</a>
                </div>
                <div class="pull-right">
                  <a href="/admin/logout" class="btn btn-danger btn-flat">Sair</a>
                </div>
              </li>
            </ul>
          </li>
          <!-- Control Sidebar Toggle Button -->
          <li>
            <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
          </li>
        </ul>
      </div>
    </nav>
  </header>
  <!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">

  <!-- sidebar: style can be found in sidebar.less -->
  <section class="sidebar">
    <!-- Sidebar user panel (optional) -->
    <div class="user-panel">
      <div class="pull-left image">
        <img class="user-image" src="../../image/<?php if( $_SESSION['User']["photo"] == 0 ){ ?>admin.jpg<?php }else{ ?><?php echo htmlspecialchars( $_SESSION['User']["user_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>.jpg<?php } ?>">
      </div>
      <div class="pull-left info">
        <p><?php echo htmlspecialchars( $_SESSION['User']["name_person"], ENT_COMPAT, 'UTF-8', FALSE ); ?></p>
        <!-- Status -->
        <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
      </div>
    </div>

    <!-- Sidebar Menu -->
    <ul class="sidebar-menu">
      <li><a href="<?php if( $_SESSION['User']["inadmin"] != '' ){ ?>/visitant?pg=1<?php } ?>"><i class="fa fa-users"></i> <span>Controle Visitas</span></a></li>
      <!-- <li class="active"><a href="/acoes?pg=1&limit=10"><i class="fa fa-envelope"></i> <span>Ações</span></a></li>
        <li><a href="/notas?pg=1&limit=10"><i class="fa fa-envelope"></i> <span>Notas Compra</span></a></li>
        <li><a href="/acoes-estoque?search"><i class="fa fa-envelope"></i> <span>Estoque</span></a></li> -->
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Grupo de Resíduos</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
        <ul class="treeview-menu">
          <li><a href="<?php if( $_SESSION['User']["inadmin"] != '' ){ ?>/residual?pg=1<?php } ?>"><i class="fa fa-trash"></i> <span>Controle Resíduos</span></a></li>
          <li <?php if( $_SESSION['User']["inadmin"] == 0 ){ ?> hidden<?php } ?>><a href="<?php if( $_SESSION['User']["inadmin"] == 1 ){ ?>/material?pg=1<?php } ?>"><i class="fa fa-shopping-basket"></i> <span>Controle Material</span></a></li>
        </ul>
      </li>
      <li class="treeview">
        <a href="#"><i class="fa fa-link"></i> <span>Grupo de Produtos</span>
          <span class="pull-right-container">
            <i class="fa fa-angle-left pull-right"></i>
          </span>
        </a>
        <ul class="treeview-menu">
          <li <?php if( $_SESSION['User']["inadmin"] == 0 ){ ?> hidden<?php } ?>><a href="<?php if( $_SESSION['User']["inadmin"] == 1 ){ ?>/goods?pg=1<?php } ?>"><i class="fa fa-shopping-cart"></i> <span>Controle Mercadorias</span></a></li>
          <li <?php if( $_SESSION['User']["inadmin"] == 0 ){ ?> hidden<?php } ?>><a href="<?php if( $_SESSION['User']["inadmin"] == 1 ){ ?>/clothing?pg=1<?php } ?>"><i class="fa fa-flag"></i> <span>Controle Roupa</span></a></li>
        </ul>
      </li>
      <li class="treeview">
        <a href="#"><i class="fa fa-link"></i> <span>Grupo de Equipamentos</span>
          <span class="pull-right-container">
            <i class="fa fa-angle-left pull-right"></i>
          </span>
        </a>
        <ul class="treeview-menu">
          <li <?php if( $_SESSION['User']["inadmin"] == 0 ){ ?> hidden<?php } ?>><a href="<?php if( $_SESSION['User']["inadmin"] == 1 ){ ?>/nobreak?pg=1<?php } ?>"><i class="fa fa-bolt"></i> <span>Controle NoBreak</span></a></li>
          <li <?php if( $_SESSION['User']["inadmin"] == 0 ){ ?> hidden<?php } ?>><a href="<?php if( $_SESSION['User']["inadmin"] == 1 ){ ?>/purifier?pg=1<?php } ?>"><i class="fa fa-flask"></i> <span>Controle Purificador</span></a></li>
          <li <?php if( $_SESSION['User']["inadmin"] == 0 ){ ?> hidden<?php } ?>><a href="<?php if( $_SESSION['User']["inadmin"] == 1 ){ ?>/airconditioning?pg=1<?php } ?>"><i class="fa fa-tint"></i> <span>Controle Ar Condicionado</span></a></li>
          <li <?php if( $_SESSION['User']["inadmin"] == 0 ){ ?> hidden<?php } ?>><a href="<?php if( $_SESSION['User']["inadmin"] == 1 ){ ?>/hydrant?pg=1<?php } ?>"><i class="fa fa-fire"></i> <span>Controle Hidrante</span></a></li>
          <li <?php if( $_SESSION['User']["inadmin"] == 0 ){ ?> hidden<?php } ?>><a href="<?php if( $_SESSION['User']["inadmin"] == 1 ){ ?>/fireexting?pg=1<?php } ?>"><i class="fa fa-fire-extinguisher"></i> <span>Controle Extintor</span></a></li>
          <li <?php if( $_SESSION['User']["inadmin"] == 0 ){ ?> hidden<?php } ?>><a href="<?php if( $_SESSION['User']["inadmin"] == 1 ){ ?>/anualplan?pg=1<?php } ?>"><i class="fa fa-gears"></i> <span>Manutenção Preventiva</span></a></li>
        </ul>
      </li>
    </ul>
    <!-- /.sidebar-menu -->
  </section>
  <!-- /.sidebar -->
</aside>
