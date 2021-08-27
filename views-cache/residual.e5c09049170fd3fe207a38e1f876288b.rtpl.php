<?php if(!class_exists('Rain\Tpl')){exit;}?><div class="content-wrapper">
  <!-- Content Header (Page header) -->
  <section class="content-header">
    <h1>
      Lista de Resíduos
    </h1>
    <ol class="breadcrumb">
      <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
      <li class="active"><a href="/residual">Resíduos</a></li>
    </ol>
  </section>
  <!-- Main content -->
  <section class="content">
    <div class="box box-primary">
      <div class="col form-control top">
        <div class="row">
          <div class="col col-md-2">
            <form action="/residual/create" method="get">
              <input type="submit" name="btnresidual" class="btn btn-success" value="Cadastrar Resíduos">
              <input type="text" name="residual" value="residual" hidden>
            </form>
          </div>
          
          <form action="/residual" method="get" <?php if( !$residuals ){ ?>hidden<?php } ?>>
            <div class="col col-md-2"><label for="material">Material</label><input type="text" name="material" id="material" class="form-control"></div>
            <div class="col col-md-2"><label for="deslocation">Localização</label><input type="text" name="deslocation" id="deslocation" class="form-control"></div>
            <div class="col col-md-2"><label for="daydate">Data Inicio</label><input type="text" name="daydate" id="daydate" class="form-control" onChange="replaceSlash(daydate)"></div>
            <div class="col col-md-2"><label for="date_fim">Data Fim</label><input type="text" name="date_fim" id="date_fim" class="form-control" onChange="replaceSlash(date_fim)"></div>
            <div class="col col-md-1"><label for="limit">Qtde</label>
              <select name="limit" id="limit" class="form-control">
                <option value="10" selected>10</option>
                <option value="15">15</option>
                <option value="20">20</option>
                <option value="25">25</option>
                <option value="30">30</option>
              </select>
            </div>
            <input type="submit" name="search" class="btn btn-primary" value="Pesquisar">
          </form>
        </div>
      </div>
    </div>
    <div id="msg<?php if( $msg["state"] == 'SUCCESS' ){ ?>-success<?php }else{ ?>-danger<?php } ?>" 
          class="box box-<?php if( $msg["state"] == 'SUCCESS' ){ ?>-success<?php }else{ ?>danger<?php } ?>" 
          <?php if( $msg["state"] != 'SUCCESS' && $msg["state"] != 'ERROR' ){ ?>readonly hidden<?php } ?>>
      <div class="msg"><input type="text" class="form-control msg-<?php if( $msg["state"] == 'SUCCESS'  ){ ?>success alert-success<?php }else{ ?>danger alert-danger<?php } ?>" name="msg" value="<?php echo htmlspecialchars( $msg["msg"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" ></div>
      <div class="msg"><textarea class="form-control" name="err" id="err" rows="3" <?php if( $msg["err"] != NULL ){ ?>hidden<?php } ?> readonly><?php echo htmlspecialchars( $msg["err"], ENT_COMPAT, 'UTF-8', FALSE ); ?></textarea></div>
    </div>
    <div class="box box-primary" <?php if( !$pgs ){ ?>hidden<?php } ?>>
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
              <li><a href="residual?pg=<?php echo htmlspecialchars( $i, ENT_COMPAT, 'UTF-8', FALSE ); ?><?php if( $pgs["list"]["deslocation"] ){ ?>&deslocation=<?php echo htmlspecialchars( $pgs["list"]["deslocation"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["material"] ){ ?>&material=<?php echo htmlspecialchars( $pgs["list"]["material"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["daydate"] ){ ?>&daydate=<?php echo htmlspecialchars( $pgs["list"]["daydate"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["date_fim"] ){ ?>&date_fim=<?php echo htmlspecialchars( $pgs["list"]["date_fim"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["limit"] ){ ?>&limit=<?php echo htmlspecialchars( $pgs["list"]["limit"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["search"] ){ ?>&search=<?php echo htmlspecialchars( $pgs["list"]["search"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>"><?php echo htmlspecialchars( $i++, ENT_COMPAT, 'UTF-8', FALSE ); ?></a></li>
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
    <div class="box box-primary" <?php if( $residuals["0"]['residual_id'] == NULL ){ ?>hidden<?php } ?>>
      <div class="box-body no-padding">
        <table class="table table-straped">
          <thead class="thead-dark">
            <tr class="alert-warning">
              <th>Data</th>
              <th>Hora</th>
              <th>Material</th>
              <th>Localização</th>
              <th>Local</th>
              <th>Depósito</th>
              <th>Responsável</th>
              <th>Ação</th>
            </tr>
          </thead>
          <tbody>
            <?php $counter1=-1;  if( isset($residuals) && ( is_array($residuals) || $residuals instanceof Traversable ) && sizeof($residuals) ) foreach( $residuals as $key1 => $value1 ){ $counter1++; ?>
            <tr>
              <td><?php echo htmlspecialchars( $value1["daydate"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td><?php echo htmlspecialchars( $value1["dayhour"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td><?php echo htmlspecialchars( $value1["material"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td><?php echo htmlspecialchars( $value1["deslocation"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td><?php echo htmlspecialchars( $value1["deslocal"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td><?php echo htmlspecialchars( $value1["warehouse"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td><?php echo htmlspecialchars( $value1["name_person"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td>
                <a href="/residual/<?php echo htmlspecialchars( $value1["residual_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" class="btn btn-primary btn-xs"><i class="fa fa-edit"></i></a>
                <a href="/residual/<?php echo htmlspecialchars( $value1["residual_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>/delete" onclick="return confirm('Deseja realmente excluir este registro?')" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i></a>
              </td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </div>
    </div>
    <div class="box box-primary" <?php if( !$pgs ){ ?>hidden<?php } ?>>
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
              <li><a href="residual?pg=<?php echo htmlspecialchars( $i, ENT_COMPAT, 'UTF-8', FALSE ); ?><?php if( $pgs["list"]["deslocation"] ){ ?>&deslocation=<?php echo htmlspecialchars( $pgs["list"]["deslocation"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php if( $pgs["list"]["material"] ){ ?>&material=<?php echo htmlspecialchars( $pgs["list"]["material"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php } ?><?php if( $pgs["list"]["daydate"] ){ ?>&daydate=<?php echo htmlspecialchars( $pgs["list"]["daydate"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["date_fim"] ){ ?>&date_fim=<?php echo htmlspecialchars( $pgs["list"]["date_fim"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["limit"] ){ ?>&limit=<?php echo htmlspecialchars( $pgs["list"]["limit"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["search"] ){ ?>&search=<?php echo htmlspecialchars( $pgs["list"]["search"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>"><?php echo htmlspecialchars( $i++, ENT_COMPAT, 'UTF-8', FALSE ); ?></a></li>
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
