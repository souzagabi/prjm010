<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="box box-success title" style="background-color: #d5f8da;">
        <h4>
          Cadastro de Roupa
        </h4>
      </div>
      <ol class="breadcrumb">
        <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="/clothing">Roupa</a></li>
        <li class="active"><a href="/clothing/create">Cadastrar</a></li>
      </ol>
    </section>
    
    <!-- Main content -->
    <section class="content">
    
      <div class="row">
          <div class="col-md-12">
            <div id="msg<?php if( $msg["state"] == 'SUCCESS' ){ ?>-success<?php }else{ ?>-danger<?php } ?>" 
                  class="box box-<?php if( $msg["state"] == 'SUCCESS' ){ ?>-success<?php }else{ ?>danger<?php } ?>" 
                  <?php if( $msg["state"] != 'SUCCESS' && $msg["state"] != 'ERROR' ){ ?>readonly hidden<?php } ?>>
              <div class="msg"><input type="text" class="form-control msg-<?php if( $msg["state"] == 'SUCCESS'  ){ ?>success alert-success<?php }else{ ?>danger alert-danger<?php } ?>" name="msg" value="<?php echo htmlspecialchars( $msg["msg"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" ></div>
            </div>
            <div class="box box-success">
            <!-- form start -->
            
              <form role="form" action="/clothing/create" method="post" enctype="multipart/form-data">
              
                <div class="box-body">
                  <div class="col col-md-2">
                    <div class="form-group">
                      <label for="dateout">Data da Retirada</label>
                      <?php $counter1=-1;  if( isset($date) && ( is_array($date) || $date instanceof Traversable ) && sizeof($date) ) foreach( $date as $key1 => $value1 ){ $counter1++; ?>
                      <input type="text" class="form-control" id="dateout" name="dateout" value="<?php echo htmlspecialchars( $date["dateout"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onChange="replaceSlash(dateout)" >
                      <?php } ?>
                    </div>
                  </div>
                  <div class="col col-md-2">
                    <div class="form-group">
                      <label for="qtdeout">Qtde de Saída</label>
                      <input type="text" class="form-control" id="qtdeout" name="qtdeout" autofocus>
                    </div>
                  </div>
                  <div class="col col-md-8">
                    <div class="form-group">
                      <label for="signout">Assinatura da Empresa</label>
                      <input type="text" class="form-control" id="signout" name="signout" onKeyUp="convertLowToUpper(signout)">
                    </div>
                  </div>
                </div>
                <div class="box-body">
                  <div class="col col-md-2">
                    <div class="form-group">
                      <label for="datein">Data de Entrada</label>
                      <input type="text" class="form-control" id="datein" name="datein" onChange="replaceSlash(datein)">
                    </div>
                  </div>
                  
                  <div class="col col-md-2">
                      <div class="form-group">
                        <label for="qtdein">Qtde de Entrada</label>
                        <input type="text" class="form-control" id="qtdein" name="qtdein">
                      </div>
                    </div>
                    <div class="col col-md-8">
                      <div class="form-group">
                        <label for="signin">Assinatura da Empresa</label>
                        <input type="text" class="form-control" id="signin" name="signin" onKeyUp="convertLowToUpper(signin)">
                      </div>
                    </div>
                
                </div>
                <!-- /.box-body -->
                <div class="box-body">
                  <div class="box-footer">
                    <input type="submit" id="clothing" class="btn btn-success" value="Cadastrar Roupa">
                    
                    <a href="/clothing?limit=10" class="btn btn-warning">Voltar</a>
                    
                  </div>
                </div>
              </form>
            </div>
          </div>
      </div>
    
    </section>
    <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    