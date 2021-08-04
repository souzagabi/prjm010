<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
<!-- Content Header (Page header) -->
<section class="content-header">
  <div class="box box-success title" style="background-color: #d5f8da;">
    <h4>
      Cadastro de Resíduo
    </h4>
  </div>
  <ol class="breadcrumb">
    <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="/residual">Resíduo</a></li>
    <li class="active"><a href="/residual/create">Cadastrar</a></li>
  </ol>
</section>

<!-- Main content -->
<section class="content">

  <div class="row">
  	<div class="col-md-12">
      <div id="<?php if( $msg["state"] == 'SUCCESS'  ){ ?>msg-success<?php } ?>" class="box box-success" <?php if( $msg["state"] != 'SUCCESS'  ){ ?>readonly hidden<?php } ?>>
        <div class="msg"><input type="text" class="form-control <?php if( $msg["state"] == 'SUCCESS'  ){ ?>alert-success<?php }else{ ?>alert-danger<?php } ?>" name="msg" id="msg" value="<?php if( $msg["state"] == 'SUCCESS'  ){ ?><?php echo htmlspecialchars( $msg["msg"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>" ></div>
      </div>
  		<div class="box box-success">
        <!-- form start -->
        
        <form role="form" action="/residual/create" method="post" enctype="multipart/form-data">
         
          <div class="box-body">
            <div class="col col-md-2">
              <div class="form-group">
                <label for="daydate">Data do Dia</label>
                <?php $counter1=-1;  if( isset($date) && ( is_array($date) || $date instanceof Traversable ) && sizeof($date) ) foreach( $date as $key1 => $value1 ){ $counter1++; ?>
                <input type="text" class="form-control" id="daydate" name="daydate" value="<?php echo htmlspecialchars( $date["date"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">
                <?php } ?>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="dayhour">Hora do Dia</label>
                <?php $counter1=-1;  if( isset($hour) && ( is_array($hour) || $hour instanceof Traversable ) && sizeof($hour) ) foreach( $hour as $key1 => $value1 ){ $counter1++; ?>
                <input type="text" class="form-control" id="dayhour" name="dayhour" value="<?php echo htmlspecialchars( $hour["hour"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">
                <?php } ?>
              </div>
            </div>
            
            <div class="col col-md-3">
              <div class="form-group">
                <label for="material">Material</label>
                <input type="text" class="form-control" name="material" id="material" onKeyUp="convertLowToUpper(material)" autofocus="autofocus" required>
              </div>
            </div>
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
          </div>
          <div class="box-body">
            <div class="col col-md-4">
              <div class="form-group">
                <label for="warehouse">Depósito</label>
                <input type="text" class="form-control" name="warehouse" id="warehouse" onKeyUp="convertLowToUpper(warehouse)" required>
              </div>
            </div>
            <div class="col col-md-3">
              <div class="form-group">
                  <label for="person_id">Responsável</label>
                  <select class="form-control" name="person_id" id="person_id" required>
                  <option value=""></option>
                  <?php $counter1=-1;  if( isset($responsables) && ( is_array($responsables) || $responsables instanceof Traversable ) && sizeof($responsables) ) foreach( $responsables as $key1 => $value1 ){ $counter1++; ?>
                  <option value="<?php echo htmlspecialchars( $value1["person_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>"><?php echo htmlspecialchars( $value1["responsable"], ENT_COMPAT, 'UTF-8', FALSE ); ?></option>
                  <?php } ?>
                  </select>
              </div>
          </div>
           
          </div>
          <!-- /.box-body -->
          <div class="box-footer">
            <input type="submit" id="residual" class="btn btn-success" value="Cadastrar Resíduo">
            
            <a href="/residual?limit=10" class="btn btn-warning">Voltar</a>
            
          </div>
        </form>
      </div>
  	</div>
  </div>

</section>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->
