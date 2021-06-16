<?php if(!class_exists('Rain\Tpl')){exit;}?><div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Histórico do Ar Condicionado
      </h1>
      <ol class="breadcrumb">
        <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active"><a href="/airconditioning">Ar Condicionadoes</a></li>
      </ol>
    </section>
    <!-- Main content -->
    <section class="content">
      <div class="box box-primary">
        <div class="col form-control top">
          <div class="row">
            <div class="col col-md-4">
              <form action="/historicA/create" method="get">
                <input type="submit" name="btnairconditioning" class="btn btn-success" value="Cadastrar Histórico">
                <a href="/airconditioning?pg=1" class="btn btn-warning">Voltar</a>
                <input type="text" name="airconditioning_id" value="<?php if( $airconditionings != NULL ){ ?><?php echo htmlspecialchars( $airconditionings["0"]['airconditioning_id'], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>" hidden>
              </form>
            </div>
         
          </div>
        </div>
      </div>
      <div id="msg<?php if( $msg["state"] == 'SUCCESS' ){ ?>-success<?php }else{ ?>-danger<?php } ?>" 
            class="box box-<?php if( $msg["state"] == 'SUCCESS' ){ ?>-success<?php }else{ ?>danger<?php } ?>" 
            <?php if( $msg["state"] != 'SUCCESS' && $msg["state"] != 'ERROR' ){ ?>readonly hidden<?php } ?>>
        <div class="msg"><input type="text" class="form-control msg-<?php if( $msg["state"] == 'SUCCESS'  ){ ?>success alert-success<?php }else{ ?>danger alert-danger<?php } ?>" name="msg" value="<?php echo htmlspecialchars( $msg["msg"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" ></div>
      </div>
      <div class="box box-primary" <?php if( $airconditionings["0"]['historic_id'] == NULL ){ ?>hidden<?php } ?>>
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
                <li><a href="airconditioning?pg=<?php echo htmlspecialchars( $i, ENT_COMPAT, 'UTF-8', FALSE ); ?><?php if( $pgs["list"]["daydate"] ){ ?>&daydate=<?php echo htmlspecialchars( $pgs["list"]["daydate"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["limit"] ){ ?>&limit=<?php echo htmlspecialchars( $pgs["list"]["limit"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["search"] ){ ?>&search=<?php echo htmlspecialchars( $pgs["list"]["search"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>"><?php echo htmlspecialchars( $i++, ENT_COMPAT, 'UTF-8', FALSE ); ?></a></li>
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
      <div class="box box-primary" <?php if( $airconditionings["0"]['historic_id'] == NULL ){ ?>hidden<?php } ?>>
        <div class="box-body no-padding">
          <table class="table table-straped">
            <thead class="thead-dark">
              <tr class="alert-primary">
                <th>Sala/Local</th>
              </tr>
            </thead>
            <tbody>
              <?php if( $airconditionings["0"]['historic_id'] != NULL ){ ?>
              <tr>
                <td><?php echo htmlspecialchars( $airconditionings["0"]['location'], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              </tr>
              <?php } ?>
            </tbody>
          </table>
        </div>
      </div>
      <div class="box box-primary" <?php if( $airconditionings["0"]['historic_id'] == NULL ){ ?>hidden<?php } ?>>
        <div class="box-body no-padding">
          <table class="table table-straped">
            <thead class="thead-dark">
              <tr class="alert-warning">
                <th>Mês</th>
                <th>Data</th>
                <th>Ação</th>
              </tr>
            </thead>
            <tbody>
              <?php if( $airconditionings["0"]['historic_id'] != NULL ){ ?>
              <?php $counter1=-1;  if( isset($airconditionings) && ( is_array($airconditionings) || $airconditionings instanceof Traversable ) && sizeof($airconditionings) ) foreach( $airconditionings as $key1 => $value1 ){ $counter1++; ?>
              <tr>
                <td><?php echo htmlspecialchars( $value1["inmonth"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
                <td><?php echo htmlspecialchars( $value1["daydate"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
                <td>
                  <a href="/historicA/<?php if( $airconditionings["0"]['historic_id'] ){ ?><?php echo htmlspecialchars( $value1["historic_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>" class="btn btn-primary btn-xs" title="Editar Histórico"><i class="fa fa-edit"></i></a>
                  <a href="/historicA/<?php if( $airconditionings["0"]['historic_id'] ){ ?><?php echo htmlspecialchars( $value1["historic_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>/delete" onclick="return confirm('Deseja realmente excluir este registro?')" class="btn btn-danger btn-xs" title="Excluir Histórico"><i class="fa fa-trash"></i></a>
                </td>
              </tr>
              <?php } ?><?php } ?>
            </tbody>
          </table>
        </div>
      </div>
      <div class="box box-primary" <?php if( $airconditionings["0"]['historic_id'] == NULL ){ ?>hidden<?php } ?>>
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
                <li><a href="airconditioning?pg=<?php echo htmlspecialchars( $i, ENT_COMPAT, 'UTF-8', FALSE ); ?><?php if( $pgs["list"]["daydate"] ){ ?>&daydate=<?php echo htmlspecialchars( $pgs["list"]["daydate"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["limit"] ){ ?>&limit=<?php echo htmlspecialchars( $pgs["list"]["limit"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["search"] ){ ?>&search=<?php echo htmlspecialchars( $pgs["list"]["search"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>"><?php echo htmlspecialchars( $i++, ENT_COMPAT, 'UTF-8', FALSE ); ?></a></li>
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
  