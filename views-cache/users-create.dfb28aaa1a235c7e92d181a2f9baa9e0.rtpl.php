<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Lista de Usuários
  </h1>
  <ol class="breadcrumb">
    <li><a href="/admin"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="/admin/users">Usuários</a></li>
    <li class="active"><a href="/admin/users/create">Cadastrar</a></li>
  </ol>
</section>

<!-- Main content -->
<section class="content">

  <div class="row">
  	<div class="col-md-12">
  		<div class="box box-success">
        <div class="box-header with-border">
          <h3 class="box-title">Novo Usuário</h3>
        </div>
        <!-- /.box-header -->
        <!-- form start -->
        <form role="form" action="/users/create" method="post">
          <div class="box-body">
            <div class="col col-md-4">
              <div class="form-group">
                <label for="name_person">Nome</label>
                <input type="text" class="form-control" name="name_person" id="name_person" onkeyup="convertLowToUpper(name_person)" autofocus="autofocus" required>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="rg_person">RG</label>
                <input type="text" class="form-control" name="rg_person" id="rg_person" onKeyUp="convertLowToUpper(rg_person)" required>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="cpf_person">CPF</label>
                <input type="text" class="form-control" name="cpf_person" id="cpf_person" onKeyUp="convertLowToUpper(cpf_person)" required>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="phonenumber">Telefone</label>
                <input type="text" class="form-control" name="phonenumber" id="phonenumber">
              </div>
            </div>
          </div>
          <div class="box-body">
            <div class="col col-md-2">
              <div class="form-group">
                <label for="deslogin">Login</label>
                <input type="text" class="form-control" id="deslogin" name="deslogin" placeholder="Digite o login">
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="despassword">Senha</label>
                <input type="password" class="form-control" id="despassword" name="despassword" placeholder="Digite a senha">
              </div>
            </div>
            <div class="col col-md-2">
              <div class="checkbox">
                <label>
                  <input type="checkbox" name="inadmin" value="1"> Acesso de Administrador
                </label>
              </div>
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
