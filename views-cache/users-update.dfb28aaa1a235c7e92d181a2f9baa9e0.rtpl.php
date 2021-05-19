<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Editar de Usuários
  </h1>
</section>

<!-- Main content -->
<section class="content">

  <div class="row">
  	<div class="col-md-12">
  		<div class="box box-primary">
        <div class="box-header with-border">
          <h3 class="box-title">Editar Usuário</h3>
        </div>
        <!-- /.box-header -->
        <!-- form start -->
        <form role="form" action="/users/<?php echo htmlspecialchars( $user["user_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" method="post">
          <div class="box-body">
            <div class="box-body">
              <div class="form-group">
                <label for="name_person">Nome</label>
                <input type="text" class="form-control" id="name_person" name="name_person" value="<?php echo htmlspecialchars( $user["name_person"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" placeholder="Digite o nome">
              </div>
              <div class="form-group">
                <label for="sgcompany">Sigla</label>
                <input type="text" class="form-control" id="sgcompany" name="sgcompany" value="<?php echo htmlspecialchars( $user["cpf_person"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" placeholder="Digite o login">
              </div>
              <div class="form-group">
                <label for="cpf_person">CPF/CNPJ</label>
                <input type="text" class="form-control" id="cpf_person" name="cpf_person" value="<?php echo htmlspecialchars( $user["cpf_person"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" placeholder="Digite o login">
              </div>
              <div class="form-group">
                <label for="login">Login</label>
                <input type="text" class="form-control" id="login" name="login" value="<?php echo htmlspecialchars( $user["login"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" placeholder="Digite o login">
              </div>
              <div class="checkbox">
                <label>
                  <input type="checkbox" name="inadmin" value="1" <?php if( $user["inadmin"] == 1 ){ ?>checked<?php } ?>> Acesso de Administrador
                </label>
              </div>
            </div>
            <!-- /.box-body -->
            <div class="box-footer">
              <button type="submit" class="btn btn-success">Cadastrar</button>
              <a href="/users?limit=10" class="btn btn-warning">Voltar</a>

            </div>
        </form>
      </div>
  	</div>
  </div>

</section>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->
