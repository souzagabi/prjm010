<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Lista de Usuários
  </h1>
  <ol class="breadcrumb">
    <li><a href="/admin"><i class="fa fa-dashboard"></i> Home</a></li>
    <li class="active"><a href="/admin/users">Usuários</a></li>
  </ol>
</section>

<!-- Main content -->
<section class="content">

  <div class="row">
  	<div class="col-md-12">
      <form action="/users/create" method="get">
        <div class="box box-primary">
          <div class="col form-control">
            <input type="submit" name="users" class="btn btn-success" value="Cadastrar Usuário">
          </div>
        </div>
      </form>
      <div id="msg<?php if( $msg["state"] == 'SUCCESS'  ){ ?>-success<?php } ?>" class="box box-success" <?php if( $msg["state"] != 'SUCCESS'  ){ ?>readonly hidden<?php } ?>>
        <div class="msg"><input type="text" class="form-control <?php if( $msg["state"] == 'SUCCESS'  ){ ?>msg-success alert-success<?php }else{ ?>alert-danger<?php } ?>" name="msg" value="<?php if( $msg["state"] == 'SUCCESS'  ){ ?><?php echo htmlspecialchars( $msg["msg"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>" ></div>
      </div>
  		<div class="box box-primary">
        <div class="box-body no-padding">
          <table class="table table-striped">
            <thead>
              <tr>
                <th style="width: 10px">#</th>
                <th>Nome</th>
                <th>RG</th>
                <th>CPF</th>
                <th>Telefone</th>
                <th>Login</th>
                <th style="width: 60px">Admin</th>
                <th style="width: 140px">&nbsp;</th>
              </tr>
            </thead>
            <tbody>
              <?php $counter1=-1;  if( isset($users) && ( is_array($users) || $users instanceof Traversable ) && sizeof($users) ) foreach( $users as $key1 => $value1 ){ $counter1++; ?>
              <tr>
                <td><?php echo htmlspecialchars( $value1["user_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
                <td><?php echo htmlspecialchars( $value1["name_person"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
                <td><?php echo htmlspecialchars( $value1["rg_person"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
                <td><?php echo htmlspecialchars( $value1["cpf_person"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
                <td><?php echo htmlspecialchars( $value1["phonenumber"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
                <td><?php echo htmlspecialchars( $value1["login"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td/>
                <td><?php if( $value1["inadmin"] == 1 ){ ?>Sim<?php }else{ ?>Não<?php } ?></td>
                <td>
                  <a href="/users/<?php echo htmlspecialchars( $value1["person_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" class="btn btn-primary btn-xs"><i class="fa fa-edit"></i></a>
                  <a href="/users/<?php echo htmlspecialchars( $value1["person_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>/delete" onclick="return confirm('Deseja realmente excluir este registro?')" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i></a>
                </td>
              </tr>
              <?php } ?>
            </tbody>
          </table>
        </div>
        <!-- /.box-body -->
      </div>
  	</div>
  </div>

</section>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->
