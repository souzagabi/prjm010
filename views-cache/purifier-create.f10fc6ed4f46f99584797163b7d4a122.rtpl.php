<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="box box-success title" style="background-color: #d5f8da;">
        <h4>
          Cadastro de Purificador
        </h4>
      </div>
      <ol class="breadcrumb">
        <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="/purifier">Purificadores</a></li>
        <li class="active"><a href="/purifier/create">Cadastrar</a></li>
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
              <div class="msg"><textarea class="form-control" name="err" id="err" rows="3" <?php if( $msg["err"] != NULL ){ ?>hidden<?php } ?> readonly><?php echo htmlspecialchars( $msg["err"], ENT_COMPAT, 'UTF-8', FALSE ); ?></textarea></div>
            </div>
            <div class="box box-success">
            <!-- form start -->
            
            <form role="form" action="/purifier/create" method="post" enctype="multipart/form-data">
             
              <div class="box-body">
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="daydate">Data do Dia</label>
                    <?php $counter1=-1;  if( isset($date) && ( is_array($date) || $date instanceof Traversable ) && sizeof($date) ) foreach( $date as $key1 => $value1 ){ $counter1++; ?>
                    <input type="text" class="form-control" id="daydate" name="daydate" value="<?php echo htmlspecialchars( $date["date"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onChange="replaceSlash(daydate)" >
                    <?php } ?>
                  </div>
                </div>
                
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="serialnumber">Nº Sério</label>
                    <input type="text" class="form-control" name="serialnumber" id="serialnumber" onKeyUp="convertLowToUpper(serialnumber)" autofocus="autofocus" required>
                  </div>
                </div>
                <div class="col col-md-3">
                  <div class="form-group">
                    <label for="location_id">Localização</label>
                    <select class="form-control" name="location_id" id="location_id" required>
                      <?php $counter1=-1;  if( isset($locations) && ( is_array($locations) || $locations instanceof Traversable ) && sizeof($locations) ) foreach( $locations as $key1 => $value1 ){ $counter1++; ?>
                      <option value="<?php echo htmlspecialchars( $value1["location_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>"><?php echo htmlspecialchars( $value1["deslocation"], ENT_COMPAT, 'UTF-8', FALSE ); ?></option>
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
              </div>
              <div class="box-body">
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="nextmanager">Data de Recarga</label>
                    <input type="text" class="form-control" name="nextmanager" id="nextmanager" onChange="replaceSlash(nextmanager)" required>
                  </div>
                </div>
                <div class="col col-md-4">
                  <div class="form-group">
                    <label for="responsable">Responsável</label>
                    <input type="text" class="form-control" name="responsable" id="responsable" onKeyUp="convertLowToUpper(responsable)" value="<?php echo htmlspecialchars( $purifier["name_person"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" required readonly>
                  </div>
                </div>
              </div>
              <!-- /.box-body -->
              <div class="box-footer">
                <input type="submit" id="purifier" class="btn btn-success" value="Cadastrar Purificador">
                
                <a href="/purifier?limit=10" class="btn btn-warning">Voltar</a>
                
              </div>
            </form>
          </div>
          </div>
      </div>
    
    </section>
    <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    