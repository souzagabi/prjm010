<?php if(!class_exists('Rain\Tpl')){exit;}?><div class="content-wrapper">
  <!-- Content Header (Page header) -->
  <section class="content-header">
    <h1>
      Lista de Pessoas
    </h1>
    <ol class="breadcrumb">
      <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
      <li class="active"><a href="/persons">Pessoas</a></li>
    </ol>
  </section>
  <!-- Main content -->
  <section class="content">
    <form action="/persons/create" method="get">
      <div class="box box-primary">
        <div class="col form-control">
          <input type="submit" name="compra" class="btn btn-success" value="Cadastrar Pessoa">
          <input type="text" name="persons" value="persons" hidden>
        </div>
      </div>
    </form>
    <div class="box box-primary">
      <div class="box-body no-padding">
    
        <table class="table table-striped">
          <thead class="thead-dark">
            <tr>
              <th>Código</th>
              <th>Nome</th>
              <th>CPF/CNPJ</th>
              <th>Ação</th>
            </tr>
          </thead>
          <tbody>
            <?php $counter1=-1;  if( isset($persons) && ( is_array($persons) || $persons instanceof Traversable ) && sizeof($persons) ) foreach( $persons as $key1 => $value1 ){ $counter1++; ?>
            <tr>
              <th><?php echo htmlspecialchars( $value1["idperson"], ENT_COMPAT, 'UTF-8', FALSE ); ?></th>
              <td><?php echo htmlspecialchars( $value1["desperson"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td><?php echo htmlspecialchars( $value1["descpfcnpj"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td>
                <a href="/persons/<?php echo htmlspecialchars( $value1["idperson"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" class="btn btn-primary btn-xs"><i class="fa fa-edit"></i></a>
                <a href="/persons/<?php echo htmlspecialchars( $value1["idperson"], ENT_COMPAT, 'UTF-8', FALSE ); ?>/delete" onclick="return confirm('Deseja realmente excluir este registro?')" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i></a>
              </td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </div>
    </div>
  </section>
</div>