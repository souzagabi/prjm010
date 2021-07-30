<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
<!-- Content Header (Page header) -->
<section class="content-header">
  <div class="box box-success title" style="background-color: #d5f8da;">
    <h4>
      Edição de Visita
    </h4>
  </div>
  <ol class="breadcrumb">
    <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="/residual">Resíduos</a></li>
    <li class="active"><a href="/residual/create">Cadastrar</a></li>
  </ol>
</section>

<!-- Main content -->
<section class="content">

  <div class="row">
  	<div class="col-md-12">
  		<div class="box box-success">
        <!-- form start -->
        
        <form role="form" action="/residual/<?php echo htmlspecialchars( $residual["person_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" method="post" enctype="multipart/form-data">
          
          <div class="box-body">
            <div class="col col-md-2">
              <div class="form-group">
                <label for="daydate">Data do Dia</label>
                <input type="text" class="form-control" id="daydate" name="daydate" value="<?php echo htmlspecialchars( $residual["daydate"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" readonly>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="dayhour">Hora do Dia</label>
                <input type="text" class="form-control" id="dayhour" name="dayhour" value="<?php echo htmlspecialchars( $residual["dayhour"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" readonly>
              </div>
            </div>
            <div class="col col-md-3">
              <div class="form-group">
                <label for="material">Material</label>
                <input type="text" class="form-control" name="material" id="material" value="<?php echo htmlspecialchars( $residual["material"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(material)" autofocus>
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
                <input type="text" class="form-control" name="warehouse" id="warehouse" value="<?php echo htmlspecialchars( $residual["warehouse"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(warehouse)">
              </div>
            </div>
            <div class="col col-md-4">
              <div class="form-group">
                <label for="name_person">Nome</label>
                <input type="text" class="form-control" name="name_person" id="name_person" onkeyup="convertLowToUpper(name_person)" value="<?php echo htmlspecialchars( $residual["name_person"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" required>
              </div>
            </div>
          </div>
          <!-- /.box-body -->
          <div class="box-footer">
            <input type="submit" id="compra" class="btn btn-success" value="Atualizar Visita">
            
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
