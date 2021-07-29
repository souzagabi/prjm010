<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="box box-success title" style="background-color: #d5f8da;">
        <h4>
          Cadastro de Hidrante
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
            
            <form role="form" action="/hydrant/create" method="post" enctype="multipart/form-data">
             
              <div class="box-body">
                <div class="col col-md-2">
                  <div class="form-group">
                      <label for="location_id">Localização</label>
                      <select class="form-control" name="location_id" id="location_id" required>
                        <?php $counter1=-1;  if( isset($locations) && ( is_array($locations) || $locations instanceof Traversable ) && sizeof($locations) ) foreach( $locations as $key1 => $value1 ){ $counter1++; ?>
                        <option value="<?php echo htmlspecialchars( $value1["location_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" ><?php echo htmlspecialchars( $value1["deslocation"], ENT_COMPAT, 'UTF-8', FALSE ); ?></option>
                        <?php } ?>
                      </select>
                  </div>
                </div>
                <div class="col col-md-3">
                    <div class="form-group">
                        <label for="local_id">Local</label>
                        <select class="form-control" name="local_id" id="local_id" required>
                          <?php $counter1=-1;  if( isset($locais) && ( is_array($locais) || $locais instanceof Traversable ) && sizeof($locais) ) foreach( $locais as $key1 => $value1 ){ $counter1++; ?>
                          <option value="<?php echo htmlspecialchars( $value1["local_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" ><?php echo htmlspecialchars( $value1["deslocal"], ENT_COMPAT, 'UTF-8', FALSE ); ?></option>
                          <?php } ?>
                        </select>
                    </div>
                </div>
                <div class="col col-md-4">
                  <div class="form-group">
                    <label for="tipe">Tipo</label>
                    <input type="text" class="form-control" name="tipe" id="tipe" onKeyUp="convertLowToUpper(tipe)">
                  </div>
                </div>
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="idnumber">Número</label>
                    <input type="text" class="form-control" name="idnumber" id="idnumber" idkey>
                  </div>
                </div>
              </div>
              <div class="box-body">
                <div class="col col-md-12">
                  <div class="form-group">
                    <label for="observation">Observação</label>
                    <textarea class="form-control" maxlength="255" name="observation" id="observation"></textarea>
                  </div>
                </div>
              </div>
              <!-- /.box-body -->
              <div class="box-body">

                <div class="box-footer">
                  <input type="submit" id="hydrant" class="btn btn-success" value="Cadastrar Hidrante">
                  
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
    