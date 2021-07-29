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
  		<div id="msg-success" class="box box-success" style="display: none;">
        <div>
          <div id="msgSuccess" class="alert-success"></div>
        </div>
      </div>
  		<div id="msgDanger" name="msgDanger"  class="alert-danger box box-danger" style="display: none;">
        <div>
          <div id="msgError" name="msgError" class="msgError"></div>
        </div>
      </div>
  		<div class="box box-primary">
        <div class="box-header with-border">
          <h3 class="box-title">Editar Usuário</h3>
        </div>
        <!-- /.box-header -->
        <!-- form start -->
        
        <form role="form" action="/users/<?php echo htmlspecialchars( $user["person_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" method="post">
          <div class="box-body">
            <div class="box-body">
              <div class="col col-md-4">
                <div class="form-group">
                  <label for="name_person">Nome</label>
                  <input type="text" class="form-control" id="name_person" name="name_person" value="<?php echo htmlspecialchars( $user["name_person"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" placeholder="Digite o nome">
                </div>
              </div>
              <div class="col col-md-2">
                <div class="form-group">
                  <label for="rg_person">RG</label>
                  <input type="text" class="form-control" id="rg_person" name="rg_person" value="<?php echo htmlspecialchars( $user["rg_person"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" placeholder="Digite o CPF">
                </div>
              </div>
              <div class="col col-md-2">
                <div class="form-group">
                  <label for="cpf_person">CPF</label>
                  <input type="text" class="form-control" id="cpf_person" name="cpf_person" value="<?php echo htmlspecialchars( $user["cpf_person"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" placeholder="Digite o CPF">
                </div>
              </div>
              <div class="col col-md-4">
                <div class="form-group">
                  <label for="email">Email</label>
                  <input type="text" class="form-control" id="email" name="email" value="<?php echo htmlspecialchars( $user["email"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" placeholder="Digite o Email">
                </div>
              </div>
            </div>
            <div class="box-body">  
              <div class="col col-md-2">
                <div class="form-group">
                  <label for="phonenumber">Telefone</label>
                  <input type="text" class="form-control" id="phonenumber" name="phonenumber" value="<?php echo htmlspecialchars( $user["phonenumber"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" placeholder="Digite o telefone">
                </div>
              </div>
              <div class="col col-md-2">
                <div class="form-group">
                  <label for="login">Login</label>
                  <input type="text" class="form-control" id="login" name="login" value="<?php echo htmlspecialchars( $user["login"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" placeholder="Digite o login">
                </div>
              </div>
              <div class="col col-md-3">
                <div class="form-group">
                  <label for="pass">Senha</label>
                  <input type="password" class="form-control" id="pass" name="pass" placeholder="Digite a senha">
                </div>
              </div>
              <div class="col col-md-3">
                <div class="form-group">
                  <label for="confpassword">Confirma a Senha</label>
                  <input type="password" class="form-control" id="confpassword" onChange="verifyConfPassWord(pass,confpassword,msgDanger)" placeholder="Digite a senha novamente">
                </div>
              </div>
              <div class="col col-md-2">
                <div class="checkbox">
                  <label>
                    <input type="checkbox" name="inadmin" value="1" <?php if( $user["inadmin"] == 1 ){ ?>checked<?php } ?>> Acesso de Administrador
                  </label>
                </div>
              </div>
            </div>
            <div class="box-body">
              <div class="col col-md-2">
                <div class="form-group">
                  <label for="situation">Situação</label>
                  <select class="form-control" name="situation" id="situation">
                    <option value="0"<?php if( $user["situation"] == 0 ){ ?>selected<?php } ?>>ATIVO</option>
                    <option value="1"<?php if( $user["situation"] == 1 ){ ?>selected<?php } ?>>INATIVO</option>
                  </select>
                </div>
              </div>
            </div>
            <!-- /.box-body -->
            <div class="box-footer">
              <button type="submit" id="btnSubmit" class="btn btn-success" style="display: none;">Atualizar</button>
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
