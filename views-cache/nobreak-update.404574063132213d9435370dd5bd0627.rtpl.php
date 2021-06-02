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
            
            <div class="col col-md-4">
              <div class="form-group">
                <label for="location">Localização</label>
                <input type="text" class="form-control" name="location" id="location" onKeyUp="convertLowToUpper(location)" value="<?php echo htmlspecialchars( $nobreak["location"], ENT_COMPAT, 'UTF-8', FALSE ); ?>"required>
              </div>
            </div>
            <div class="col col-md-4">
              <div class="form-group">
                <label for="nobreakmodel">Modelo do NoBreak</label>
                <input type="text" class="form-control" name="nobreakmodel" id="nobreakmodel" onKeyUp="convertLowToUpper(nobreakmodel)" value="<?php echo htmlspecialchars( $nobreak["nobreakmodel"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" required>
              </div>
            </div>
          </div>
          <div class="box-body">
            <div class="col col-md-2">
              <div class="form-group">
                <label for="resulttest">Embalagem</label>
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
                <input type="text" class="form-control" name="serialnumber" id="serialnumber" value="<?php echo htmlspecialchars( $nobreak["serialnumber"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" required >
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
