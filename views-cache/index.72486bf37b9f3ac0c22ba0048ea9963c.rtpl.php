<?php if(!class_exists('Rain\Tpl')){exit;}?>  <div class="col form-control">
    <a href="/acoes" class="btn btn-outline-success">Cadastrar Compra</a>
  </div>
  <table class="table  table-striped">
      <thead class="thead-dark">
        <tr>
          <th scope="col">Empresa</th>
          <th scope="col">DtCompra</th>
          <th scope="col">Qtde</th>
          <th scope="col">Valor</th>
          <th scope="col">DtVenda</th>
          <th scope="col">Qtde</th>
          <th scope="col">Valor</th>
          <th scope="col">Tipo</th>
          <th scope="col">Ação</th>
        </tr>
      </thead>
      <tbody>
        <?php $counter1=-1;  if( isset($acoes) && ( is_array($acoes) || $acoes instanceof Traversable ) && sizeof($acoes) ) foreach( $acoes as $key1 => $value1 ){ $counter1++; ?>
        <tr>
          <th scope="row"><?php echo htmlspecialchars( $value1["sgcompany"], ENT_COMPAT, 'UTF-8', FALSE ); ?></th>
          <td><?php echo htmlspecialchars( $value1["dtbuy"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
          <td><?php echo htmlspecialchars( $value1["qtdebuy"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
          <td><?php echo htmlspecialchars( $value1["prcbuy"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
          <td><?php echo htmlspecialchars( $value1["dtsell"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
          <td><?php echo htmlspecialchars( $value1["qtdesell"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
          <td><?php echo htmlspecialchars( $value1["prcsell"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
          <td><?php if( $value1["type"] == 1 ){ ?>Swing Trade<?php }else{ ?>Day Trade<?php } ?></td>
          <td>
            <a href="/acoes/<?php echo htmlspecialchars( $value1["iduser"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" class="btn btn-primary btn-xs"><i class="fa fa-edit"></i></a>
            <a href="/acoes/<?php echo htmlspecialchars( $value1["iduser"], ENT_COMPAT, 'UTF-8', FALSE ); ?>/delete1" onclick="return confirm('Deseja realmente excluir este registro?')" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i></a>
          </td>
        </tr>
        <?php } ?>
      </tbody>
    </table>