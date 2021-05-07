<?php if(!class_exists('Rain\Tpl')){exit;}?><div class="content-wrapper">
  <!-- Content Header (Page header) -->
  <section class="content-header">
    <h1>
      Lista de Ações
    </h1>
    <ol class="breadcrumb">
      <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
      <li class="active"><a href="/acoes">Ações Search</a></li>
    </ol>
  </section>
  <!-- Main content -->
  <section class="content">
    <div class="box box-primary">
      <div class="col form-control">
        <div class="row">
          <div class="col col-md-6">
            <form action="/acoes/create" method="get">
              <input type="submit" name="compra" class="btn btn-success" value="Cadastrar Compra">
              <input type="submit" name="venda" class="btn btn-success" value="Cadastrar Venda">
              <input type="text" name="acoes" value="acoes" hidden>
            </form>
          </div>
          <form action="/acoes" method="get">
            <div class="col col-md-2"><input type="text" name="dtbuy" id="dtbuy" class="form-control" onChange="replaceSlash(dtbuy)"></div>
            <div class="col col-md-2"><input type="text" name="dtsell" id="dtsell" class="form-control" onChange="replaceSlash(dtsell)"></div>
            <input type="submit" name="search" class="btn btn-primary" value="Search">
          </form>
        </div>
      </div>
    </div>
    <div class="box box-primary">
      <div class="box-body no-padding">
    
        <table class="table table-striped">
          <thead class="thead-dark">
            <tr>
              <th>Empresa</th>
              <th class="buy">DtCompra</th>
              <th class="buy">Qtde</th>
              <th class="buy">Valor</th>
              <th class="sell">DtVenda</th>
              <th class="sell">Qtde</th>
              <th class="sell">Valor</th>
              <th>Tipo</th>
              <th>Ação</th>
            </tr>
          </thead>
          <tbody>
            <?php $counter1=-1;  if( isset($acoes) && ( is_array($acoes) || $acoes instanceof Traversable ) && sizeof($acoes) ) foreach( $acoes as $key1 => $value1 ){ $counter1++; ?>
            <tr>
              <th><?php echo htmlspecialchars( $value1["sgcompany"], ENT_COMPAT, 'UTF-8', FALSE ); ?></th>
              <td class="buy"><?php echo htmlspecialchars( $value1["dtbuy"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td class="buy"><?php echo htmlspecialchars( $value1["qtdebuy"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td class="buy"><?php echo htmlspecialchars( $value1["prcbuy"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td class="sell"><?php echo htmlspecialchars( $value1["dtsell"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td class="sell"><?php echo htmlspecialchars( $value1["qtdesell"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td class="sell"><?php echo htmlspecialchars( $value1["prcsell"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td><?php if( $value1["tipe"] == 1 ){ ?>Swing Trade<?php }else{ ?>Day Trade<?php } ?></td>
              <td>
                <a href="/acoes/<?php echo htmlspecialchars( $value1["idinvestiment"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" class="btn btn-primary btn-xs"><i class="fa fa-edit"></i></a>
                <a href="/acoes/<?php echo htmlspecialchars( $value1["idinvestiment"], ENT_COMPAT, 'UTF-8', FALSE ); ?>/delete" onclick="return confirm('Deseja realmente excluir este registro?')" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i></a>
              </td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </div>
    </div>
  </section>
</div>