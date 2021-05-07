<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
<!-- Content Header (Page header) -->
<section class="content-header">
  <div class="box box-primary">
    <div class="box-header with-border">
      <h3 class="box-title">
        Editar Pessoa
      </h3>
    </div>
  </div>
</section>

<!-- Main content -->
<section class="content">

  <div class="row">
  	<div class="col-md-12">
  		<div class="box box-primary">
        <!-- /.box-header -->
        <!-- form start -->
        <form role="form" action="/persons/<?php echo htmlspecialchars( $persons["idperson"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" method="post">
          <div class="box-body">
            <div class="box-body">
              <div class="col col-md-2">
                <div class="form-group">
                  <label for="idperson">Código</label>
                  <input type="text" class="form-control" name="idperson" id="idperson" value="<?php echo htmlspecialchars( $persons["idperson"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" readonly>
                </div>
              </div>
              <div class="col col-md-2">
                <div class="form-group">
                  <label for="desperson">Nome</label>
                  <input type="text" class="form-control" name="desperson" id="desperson" value="<?php echo htmlspecialchars( $persons["desperson"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" required>
                </div>
              </div>
              <div class="col col-md-2">
                <div class="form-group">
                  <label for="descpfcnpj">CPF/CNPJ</label>
                  <input type="text" class="form-control" name="descpfcnpj" id="descpfcnpj" value="<?php echo htmlspecialchars( $persons["descpfcnpj"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">
                </div>
              </div>
            </div>
            
            <!-- /.box-body -->
            <div class="box-footer">
              <button type="submit" class="btn btn-primary">Alualizar</button>
              <a href="/persons" class="btn btn-warning">Voltar</a>
            </div>
        </form>
      </div>
  	</div>
  </div>

</section>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->