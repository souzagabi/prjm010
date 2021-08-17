<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
<!-- Content Header (Page header) -->
<section class="content-header">
  <div class="box box-success title" style="background-color: #d5f8da;">
    <h4>
      Edição de NoBreak
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
        <div class="msg"><input type="text" class="form-control msg-<?php if( $msg["state"] == 'SUCCESS'  ){ ?>success alert-success<?php }else{ ?>danger alert-danger<?php } ?>" name="msg" value="<?php echo htmlspecialchars( $msg["msg"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" readonly ></div>
        <div class="msg"><textarea class="form-control" name="err" id="err" rows="3" <?php if( $msg["err"] != NULL ){ ?>hidden<?php } ?> readonly><?php echo htmlspecialchars( $msg["err"], ENT_COMPAT, 'UTF-8', FALSE ); ?></textarea></div>
      </div>
  		<div class="box box-success">
        <!-- form start -->
        
        <form role="form" action="/nobreak/<?php echo htmlspecialchars( $nobreak["nobreak_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" method="post" enctype="multipart/form-data">
          
          <div class="box-body">
            <div class="col col-md-2">
              <div class="form-group">
                <label for="daydate">Data do Dia</label>
                <input type="text" class="form-control" id="daydate" name="daydate" value="<?php echo htmlspecialchars( $nobreak["daydate"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onChange="replaceSlash(daydate)" >
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="dayhour">Hora do Dia</label>
                <input type="text" class="form-control" id="dayhour" name="dayhour" value="<?php echo htmlspecialchars( $nobreak["dayhour"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">
              </div>
            </div>
            
            <div class="col col-md-2">
              <div class="form-group">
                <label for="location_id">Localização</label>
                <select class="form-control" name="location_id" id="location_id" required>
                  <?php $counter1=-1;  if( isset($locations) && ( is_array($locations) || $locations instanceof Traversable ) && sizeof($locations) ) foreach( $locations as $key1 => $value1 ){ $counter1++; ?>
                  <option value="<?php echo htmlspecialchars( $value1["location_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" <?php if( $value1["location_id"] == $nobreak["location_id"]  ){ ?>selected<?php } ?> ><?php echo htmlspecialchars( $value1["deslocation"], ENT_COMPAT, 'UTF-8', FALSE ); ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="col col-md-3">
              <div class="form-group">
                <label for="local_id">Local</label>
                  <select class="form-control" name="local_id" id="local_id" required>
                    <?php $counter1=-1;  if( isset($locais) && ( is_array($locais) || $locais instanceof Traversable ) && sizeof($locais) ) foreach( $locais as $key1 => $value1 ){ $counter1++; ?>
                    <option value="<?php echo htmlspecialchars( $value1["local_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" <?php if( $value1["local_id"] == $nobreak["local_id"]  ){ ?>selected<?php } ?> ><?php echo htmlspecialchars( $value1["deslocal"], ENT_COMPAT, 'UTF-8', FALSE ); ?></option>
                    <?php } ?>
                  </select>
              </div>
            </div>
            <div class="col col-md-3">
              <div class="form-group">
                <label for="nobreakmodel">Modelo do NoBreak</label>
                <input type="text" class="form-control" name="nobreakmodel" id="nobreakmodel" onKeyUp="convertLowToUpper(nobreakmodel)" value="<?php echo htmlspecialchars( $nobreak["nobreakmodel"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" required>
              </div>
            </div>
          </div>
          <div class="box-body">
            <div class="col col-md-2">
              <div class="form-group">
                <label for="resulttest">Resultado Teste</label>
                <select class="form-control" name="resulttest" id="resulttest">
                  <option value="0" <?php if( $nobreak["resulttest"] == 0 ){ ?>selected<?php } ?>>OK</option>
                  <option value="1" <?php if( $nobreak["resulttest"] == 1 ){ ?>selected<?php } ?>>NÃO OK</option>
                </select>
              </div>
            </div>
            <div class="col col-md-4">
              <div class="form-group">
                <label for="observation">Observação</label>
                <input type="text" class="form-control" name="observation" id="observation" value="<?php echo htmlspecialchars( $nobreak["observation"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" required >
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="serialnumber">Número de Série</label>
                <input type="text" class="form-control" name="serialnumber" id="serialnumber" value="<?php echo htmlspecialchars( $nobreak["serialnumber"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onkeyup="convertLowToUpper(serialnumber)" required >
              </div>
            </div>
            <div class="col col-md-3">
              <div class="form-group">
                <label for="person_id">Responsável</label>
                <select class="form-control" name="person_id" id="person_id" required>
                  <option value=""></option>
                  <?php $counter1=-1;  if( isset($responsables) && ( is_array($responsables) || $responsables instanceof Traversable ) && sizeof($responsables) ) foreach( $responsables as $key1 => $value1 ){ $counter1++; ?>
                  <option value="<?php echo htmlspecialchars( $value1["person_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>"<?php if( $value1["person_id"] == $nobreak["person_id"] ){ ?>selected<?php } ?>><?php echo htmlspecialchars( $value1["responsable"], ENT_COMPAT, 'UTF-8', FALSE ); ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
          </div>
          <!-- /.box-body -->
          <div class="box-footer">
            <input type="submit" id="compra" class="btn btn-success" value="Atualizar NoBreak">
            
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
