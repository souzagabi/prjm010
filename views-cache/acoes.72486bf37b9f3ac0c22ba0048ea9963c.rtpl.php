<?php if(!class_exists('Rain\Tpl')){exit;}?><div class="content-wrapper">
  <!-- Content Header (Page header) -->
  <section class="content-header">
    <h1>
      Lista de Ações
    </h1>
    <ol class="breadcrumb">
      <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
      <li class="active"><a href="/acoes">Ações</a></li>
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
              <input type="text" name="acoes" value="acoes" hidden>
            </form>
          </div>
          <form action="/acoes" method="get">
            <div class="col col-md-2"><label for="sgcompany">Sigla</label><input type="text" name="sgcompany" id="sgcompany" class="form-control"></div>
            <div class="col col-md-2"><label for="dtbuy">Data Inicio</label><input type="text" name="dtbuy" id="dtbuy" class="form-control" onChange="replaceSlash(dtbuy)"></div>
            <div class="col col-md-2"><label for="dtsell">Data Fim</label><input type="text" name="dtsell" id="dtsell" class="form-control" onChange="replaceSlash(dtsell)"></div>
            <div class="col col-md-1"><label for="limit">Limite</label>
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
              <li><a href="acoes?pg=<?php echo htmlspecialchars( $i, ENT_COMPAT, 'UTF-8', FALSE ); ?><?php if( $pgs["list"]["listacoes"] ){ ?>&listacoes=<?php echo htmlspecialchars( $pgs["list"]["listacoes"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["dtbuy"] ){ ?>&dtbuy=<?php echo htmlspecialchars( $pgs["list"]["dtbuy"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["dtsell"] ){ ?>&dtsell=<?php echo htmlspecialchars( $pgs["list"]["dtsell"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["search"] ){ ?>&search=<?php echo htmlspecialchars( $pgs["list"]["search"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>"><?php echo htmlspecialchars( $i++, ENT_COMPAT, 'UTF-8', FALSE ); ?></a></li>
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
        <table class="table table-striped">
          <thead class="thead-dark">
            <tr class="com-estoque">
              <th colspan="8">
                Ações com Estoque até a data  
                <?php if( (isset($acoes["0"]["dtbuy"])) && (isset($acoes["0"]["dtsell"])) ){ ?> 
                  entre <?php echo htmlspecialchars( $acoes["0"]["dtbuy"], ENT_COMPAT, 'UTF-8', FALSE ); ?> e <?php echo htmlspecialchars( $acoes["0"]["dtsell"], ENT_COMPAT, 'UTF-8', FALSE ); ?>.
                <?php }else{ ?>
                  <?php if( (isset($acoes["0"]["dtbuy"])) && (!isset($acoes["0"]["dtsell"])) ){ ?>
                    <?php echo htmlspecialchars( $acoes["0"]["dtbuy"], ENT_COMPAT, 'UTF-8', FALSE ); ?>.
                  <?php } ?>
                  <?php if( (!isset($acoes["0"]["dtbuy"])) && (isset($acoes["0"]["dtsell"])) ){ ?>
                    <?php echo htmlspecialchars( $acoes["0"]["dtsell"], ENT_COMPAT, 'UTF-8', FALSE ); ?>.
                  <?php } ?>
                  <?php if( (!isset($acoes["0"]["dtbuy"])) && (!isset($acoes["0"]["dtsell"])) ){ ?>
                    atual.
                  <?php } ?>
                <?php } ?>
              </th>
            </tr>
            <tr>
              <th>Empresa</th>
              <th>Sigla</th>
              <th>Qtde Estoque</th>
              <th>Valor Médio</th>
              <th>Valor Total</th>
            </tr>
          </thead>
          <tbody>
            <?php $counter1=-1;  if( isset($acoes) && ( is_array($acoes) || $acoes instanceof Traversable ) && sizeof($acoes) ) foreach( $acoes as $key1 => $value1 ){ $counter1++; ?>
            <?php if( $value1["qtdeestoque"] > 0 ){ ?><tr>
              <th><?php echo htmlspecialchars( $value1["desperson"], ENT_COMPAT, 'UTF-8', FALSE ); ?></th>
              <th><?php echo htmlspecialchars( $value1["sgecompany"], ENT_COMPAT, 'UTF-8', FALSE ); ?></th>
              <td><?php echo htmlspecialchars( $value1["qtdeestoque"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td><?php echo htmlspecialchars( $value1["prcaverage"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td><?php echo htmlspecialchars( $value1["prcaverage"] * $value1["qtdeestoque"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
            </tr><?php } ?>
            <?php } ?>
          </tbody>
        </table>
      </div>
    </div>
    <div class="box box-primary">
      <div class="box-body no-padding">
        <table class="table table-striped">
          <thead class="thead-dark">
            <tr class="sem-estoque">
              <th colspan="8">
                Ações com Estoque até a data  
                <?php if( (isset($acoes["0"]["dtbuy"])) && (isset($acoes["0"]["dtsell"])) ){ ?> 
                  entre <?php echo htmlspecialchars( $acoes["0"]["dtbuy"], ENT_COMPAT, 'UTF-8', FALSE ); ?> e <?php echo htmlspecialchars( $acoes["0"]["dtsell"], ENT_COMPAT, 'UTF-8', FALSE ); ?>.
                <?php }else{ ?>
                  <?php if( (isset($acoes["0"]["dtbuy"])) && (!isset($acoes["0"]["dtsell"])) ){ ?>
                    <?php echo htmlspecialchars( $acoes["0"]["dtbuy"], ENT_COMPAT, 'UTF-8', FALSE ); ?>.
                  <?php } ?>
                  <?php if( (!isset($acoes["0"]["dtbuy"])) && (isset($acoes["0"]["dtsell"])) ){ ?>
                    <?php echo htmlspecialchars( $acoes["0"]["dtsell"], ENT_COMPAT, 'UTF-8', FALSE ); ?>.
                  <?php } ?>
                  <?php if( (!isset($acoes["0"]["dtbuy"])) && (!isset($acoes["0"]["dtsell"])) ){ ?>
                    atual.
                  <?php } ?>
                <?php } ?>
              </th>
            </tr>
            <tr>
              <th>Empresa</th>
              <th>Sigla</th>
              <th>Qtde Estoque</th>
              <th>Valor Médio</th>
              <th>Valor Total</th>
            </tr>
          </thead>
          <tbody>
            <?php $counter1=-1;  if( isset($acoes) && ( is_array($acoes) || $acoes instanceof Traversable ) && sizeof($acoes) ) foreach( $acoes as $key1 => $value1 ){ $counter1++; ?>
            <?php if( $value1["qtdeestoque"] <= 0 ){ ?><tr>
              <th><?php echo htmlspecialchars( $value1["desperson"], ENT_COMPAT, 'UTF-8', FALSE ); ?></th>
              <th><?php echo htmlspecialchars( $value1["sgecompany"], ENT_COMPAT, 'UTF-8', FALSE ); ?></th>
              <td><?php echo htmlspecialchars( $value1["qtdeestoque"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td><?php echo htmlspecialchars( $value1["prcaverage"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td><?php echo htmlspecialchars( $value1["prcaverage"] * $value1["qtdeestoque"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
            </tr><?php } ?>
            <?php } ?>
          </tbody>
        </table>
      </div>
    </div>
  </section>
</div>