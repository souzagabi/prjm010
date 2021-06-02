<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="box box-success title" style="background-color: #d5f8da;">
        <h4>
          Editção de Extintor
        </h4>
      </div>
      <ol class="breadcrumb">
        <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="/fireexting">Extintores</a></li>
        <li class="active"><a href="/fireexting/create">Cadastrar</a></li>
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
            
            <form role="form" action="/fireexting/<?php echo htmlspecialchars( $fireexting["fireexting_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" method="post" enctype="multipart/form-data">
             
              <div class="box-body">
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="daydate">Data do Dia</label>
                    <input type="text" class="form-control" id="daydate" name="daydate" value="<?php echo htmlspecialchars( $fireexting["daydate"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onChange="replaceSlash(daydate)" >
                  </div>
                </div>
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="dayhour">Hora do Dia</label>
                    <input type="text" class="form-control" id="dayhour" name="dayhour" value="<?php echo htmlspecialchars( $fireexting["dayhour"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">
                  </div>
                </div>
                
                <div class="col col-md-4">
                  <div class="form-group">
                    <label for="location">Local</label>
                    <input type="text" class="form-control" name="location" id="location" value="<?php echo htmlspecialchars( $fireexting["location"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(location)" autofocus="autofocus" required>
                  </div>
                </div>
                <div class="col col-md-4">
                  <div class="form-group">
                    <label for="tipe">Tipo</label>
                    <input type="text" class="form-control" name="tipe" maxlength="20" id="tipe" value="<?php echo htmlspecialchars( $fireexting["tipe"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(tipe)" required>
                  </div>
                </div>
              </div>
              <div class="box-body">
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="weight">Peso</label>
                    <input type="text" class="form-control" name="weight" maxlength="10" id="weight" value="<?php echo htmlspecialchars( $fireexting["weight"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(weight)" required>
                  </div>
                </div>
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="capacity">Capacidade</label>
                    <input type="text" class="form-control" name="capacity" maxlength="10" id="capacity" value="<?php echo htmlspecialchars( $fireexting["capacity"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(capacity)" required>
                  </div>
                </div>
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="rechargedate">Data de Recarga</label>
                    <input type="text" class="form-control" name="rechargedate" id="rechargedate" value="<?php echo htmlspecialchars( $fireexting["rechargedate"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onChange="replaceSlash(rechargedate)" required>
                  </div>
                </div>
               
              </div>
              <!-- /.box-body -->
              <div class="box-footer">
                <input type="submit" id="fireexting" class="btn btn-success" value="Atualizar Extintor">
                
                <a href="/fireexting?limit=10" class="btn btn-warning">Voltar</a>
                
              </div>
            </form>
          </div>
          </div>
      </div>
    
    </section>
    <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    