<?php if(!class_exists('Rain\Tpl')){exit;}?><div class="content-wrapper">
  <!-- Content Header (Page header) -->
  <section class="content-header">
    <h1>
      Lista de Notas
    </h1>
    <ol class="breadcrumb">
      <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
      <li class="active"><a href="/notas">Notas</a></li>
    </ol>
  </section>
  <!-- Main content -->
  <section class="content">
    <div class="box box-primary">
      <div class="col form-control top">
        <div class="row">
          <div class="col col-md-4">
            <form action="/acoes/create" method="get">
              <input type="submit" name="compra" class="btn btn-success" value="Cadastrar Compra">
              <input type="text" name="notas" value="notas" hidden>
            </form>
          </div>
          
          <form action="/notas" method="get">
            <div class="col col-md-2"><label for="sgcompany">Sigla</label><input type="text" name="sgcompany" id="sgcompany" class="form-control"></div>
            <div class="col col-md-2"><label for="dtbuy">Data Inicio</label><input type="text" name="dtbuy" id="dtbuy" class="form-control" onChange="replaceSlash(dtbuy)"></div>
            <div class="col col-md-2"><label for="dtsell">Data Fim</label><input type="text" name="dtsell" id="dtsell" class="form-control" onChange="replaceSlash(dtsell)"></div>
            <div class="col col-md-1"><label for="limit">Data Fim</label>
              <select name="limit" id="limit" class="form-control">
                <option value="10" selected>10</option>
                <option value="15">15</option>
                <option value="20">20</option>
                <option value="25">25</option>
                <option value="30">30</option>
              </select>
            </div>
            <input type="submit" name="search" class="btn btn-primary" value="Search">
          </form>
        </div>
      </div>
    </div>
    <div class="box box-primary">
      <div class="row">
        <div class="col col-md-12">
          <nav aria-label="Page navigation">
            <ul class="pagination">
              <li>
                <a href="#" aria-label="Previous">
                  <span aria-hidden="true">&laquo;</span>
                </a>
              </li>
              <?php $i = 1; ?>
              <?php $counter1=-1;  if( isset($pgs) && ( is_array($pgs) || $pgs instanceof Traversable ) && sizeof($pgs) ) foreach( $pgs as $key1 => $value1 ){ $counter1++; ?>
              <li><a href="notas?pg=<?php echo htmlspecialchars( $i, ENT_COMPAT, 'UTF-8', FALSE ); ?><?php if( $pgs["list"]["sgcompany"] ){ ?>&sgcompany=<?php echo htmlspecialchars( $pgs["list"]["sgcompany"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["dtbuy"] ){ ?>&dtbuy=<?php echo htmlspecialchars( $pgs["list"]["dtbuy"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["dtsell"] ){ ?>&dtsell=<?php echo htmlspecialchars( $pgs["list"]["dtsell"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["search"] ){ ?>&search=<?php echo htmlspecialchars( $pgs["list"]["search"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["limit"] ){ ?>&limit=<?php echo htmlspecialchars( $pgs["list"]["limit"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>"><?php echo htmlspecialchars( $i++, ENT_COMPAT, 'UTF-8', FALSE ); ?></a></li>
              <?php } ?>
              <li>
                <a href="#" aria-label="Next">
                  <span aria-hidden="true">&raquo;</span>
                </a>
              </li>
            </ul>
          </nav>
        </div>
      </div>
    </div>
    <div class="box box-primary">
      <div class="box-body no-padding">
        <table class="table">
          <thead class="thead-dark">
            <tr>
              <th>Empresa</th>
              <th class="buy">DtCompra</th>
              <th class="buy">Qtde</th>
              <th class="buy">Valor Compra</th>
              <th class="buy">Valor Médio</th>
              <th class="sell">DtVenda</th>
              <th class="sell">Qtde</th>
              <th class="sell">Valor Venda</th>
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
              <td class="buy"><?php echo htmlspecialchars( $value1["iprcaverage"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td class="sell"><?php echo htmlspecialchars( $value1["dtsell"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td class="sell"><?php echo htmlspecialchars( $value1["qtdesell"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td class="sell"><?php echo htmlspecialchars( $value1["prcsell"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td><?php if( $value1["tipe"] == 1 ){ ?>Swing Trade<?php }else{ ?>Day Trade<?php } ?></td>
              <td>
                <a href="/notas/<?php echo htmlspecialchars( $value1["idinvestiment"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" class="btn btn-primary btn-xs"><i class="fa fa-edit"></i></a>
                <a href="/notas/<?php echo htmlspecialchars( $value1["idinvestiment"], ENT_COMPAT, 'UTF-8', FALSE ); ?>/delete" onclick="return confirm('Deseja realmente excluir este registro?')" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i></a>
              </td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </div>
    </div>
    <div class="box box-primary">
      <div class="row">
        <div class="col col-md-12">
          <nav aria-label="Page navigation">
            <ul class="pagination">
              <li>
                <a href="#" aria-label="Previous">
                  <span aria-hidden="true">&laquo;</span>
                </a>
              </li>
              <?php $i = 1; ?>
              <?php $counter1=-1;  if( isset($pgs) && ( is_array($pgs) || $pgs instanceof Traversable ) && sizeof($pgs) ) foreach( $pgs as $key1 => $value1 ){ $counter1++; ?>
              <li><a href="notas?pg=<?php echo htmlspecialchars( $i, ENT_COMPAT, 'UTF-8', FALSE ); ?><?php if( $pgs["list"]["sgcompany"] ){ ?>&sgcompany=<?php echo htmlspecialchars( $pgs["list"]["sgcompany"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["dtbuy"] ){ ?>&dtbuy=<?php echo htmlspecialchars( $pgs["list"]["dtbuy"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["dtsell"] ){ ?>&dtsell=<?php echo htmlspecialchars( $pgs["list"]["dtsell"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["search"] ){ ?>&search=<?php echo htmlspecialchars( $pgs["list"]["search"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["limit"] ){ ?>&limit=<?php echo htmlspecialchars( $pgs["list"]["limit"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>"><?php echo htmlspecialchars( $i++, ENT_COMPAT, 'UTF-8', FALSE ); ?></a></li>
              <?php } ?>
              <li>
                <a href="#" aria-label="Next">
                  <span aria-hidden="true">&raquo;</span>
                </a>
              </li>
            </ul>
          </nav>
        </div>
      </div>
    </div>
  </section>
</div>
