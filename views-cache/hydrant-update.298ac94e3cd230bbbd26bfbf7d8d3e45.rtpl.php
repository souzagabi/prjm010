<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="box box-success title" style="background-color: #d5f8da;">
        <h4>
          Editção de Hidrante
        </h4>
      </div>
      <ol class="breadcrumb">
        <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="/hydrant">Hidrantes</a></li>
        <li class="active"><a href="/hydrant/create">Cadastrar</a></li>
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
            
            <form role="form" action="/hydrant/<?php echo htmlspecialchars( $hydrant["hydrant_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" method="post" enctype="multipart/form-data">
             
              <div class="box-body">
                <div class="col col-md-4">
                  <div class="form-group">
                    <label for="location">Local</label>
                    <input type="text" class="form-control" name="location" id="location" value="<?php echo htmlspecialchars( $hydrant["location"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(location)" autofocus="autofocus" required>
                  </div>
                </div>
                <div class="col col-md-4">
                  <div class="form-group">
                    <label for="tipe">Tipo</label>
                    <input type="text" class="form-control" name="tipe" maxlength="20" id="tipe" value="<?php echo htmlspecialchars( $hydrant["tipe"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(tipe)" required>
                  </div>
                </div>
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="idnumber">Número</label>
                    <input type="text" class="form-control" name="idnumber" maxlength="10" id="idnumber" value="<?php echo htmlspecialchars( $hydrant["idnumber"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(idnumber)" required>
                  </div>
                </div>
              </div>
              <div class="box-body">
                <div class="col col-md-12">
                  <div class="form-group">
                    <label for="observation">Observação</label>
                    <textarea class="form-control" maxlength="255" name="observation" id="observation"><?php echo htmlspecialchars( $hydrant["observation"], ENT_COMPAT, 'UTF-8', FALSE ); ?></textarea>
                  </div>
                </div>
              </div>
              <!-- /.box-body -->
              <div class="box-body">
                  <div class="box-footer">
                    <input type="submit" id="hydrant" class="btn btn-success" value="Atualizar Hidrante">
                    
                    <a href="/hydrant?limit=10" class="btn btn-warning">Voltar</a>
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
    