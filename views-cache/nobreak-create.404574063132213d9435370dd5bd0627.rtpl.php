<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
<!-- Content Header (Page header) -->
<section class="content-header">
  <div class="box box-success title" style="background-color: #d5f8da;">
    <h4>
      Cadastro de Nobreak
    </h4>
  </div>
  <ol class="breadcrumb">
    <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="/nobreak">NoBreak</a></li>
    <li class="active"><a href="/nobreak/create">Cadastrar</a></li>
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
        
        <form role="form" action="/nobreak/create" method="post" enctype="multipart/form-data">
         
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
                <label for="dayhour">Hora do Dia</label>
                <?php $counter1=-1;  if( isset($hour) && ( is_array($hour) || $hour instanceof Traversable ) && sizeof($hour) ) foreach( $hour as $key1 => $value1 ){ $counter1++; ?>
                <input type="text" class="form-control" id="dayhour" name="dayhour" value="<?php echo htmlspecialchars( $hour["hour"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">
                <?php } ?>
              </div>
            </div>
            
            <div class="col col-md-2">
              <div class="form-group">
                <label for="location">Localização</label>
                <select class="form-control" name="location" id="location" required>
                  <?php $counter1=-1;  if( isset($locations) && ( is_array($locations) || $locations instanceof Traversable ) && sizeof($locations) ) foreach( $locations as $key1 => $value1 ){ $counter1++; ?>
                  <option value="<?php echo htmlspecialchars( $value1["location"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" ><?php echo htmlspecialchars( $value1["deslocation"], ENT_COMPAT, 'UTF-8', FALSE ); ?></option>
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
            <div class="col col-md-3">
              <div class="form-group">
                <label for="nobreakmodel">Modelo do NoBreak</label>
                <input type="text" class="form-control" name="nobreakmodel" id="nobreakmodel" onKeyUp="convertLowToUpper(nobreakmodel)" required>
              </div>
            </div>
          </div>
          <div class="box-body">
            <div class="col col-md-2">
              <div class="form-group">
                <label for="resulttest">Resultado Teste</label>
                <select class="form-control" name="resulttest" id="resulttest">
                  <option value="0" selected>OK</option>
                  <option value="1">NÃO OK</option>
                </select>
              </div>
            </div>
            <div class="col col-md-4">
              <div class="form-group">
                <label for="observation">Observação</label>
                <input type="text" class="form-control" name="observation" id="observation" required >
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="serialnumber">Número de Série</label>
                <input type="text" class="form-control" name="serialnumber" id="serialnumber" required >
              </div>
            </div>
            <div class="col col-md-4">
              <div class="form-group">
                <label for="name_person">Responsável</label>
                <input type="text" class="form-control" name="name_person" id="name_person" value="<?php echo htmlspecialchars( $nobreak["name_person"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" required readonly>
              </div>
            </div>
           
          </div>
          <!-- /.box-body -->
          <div class="box-footer">
            <input type="submit" id="nobreak" class="btn btn-success" value="Cadastrar Nobreak">
            
            <a href="/nobreak?limit=10" class="btn btn-warning">Voltar</a>
            
          </div>
        </form>
      </div>
  	</div>
  </div>

</section>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->
