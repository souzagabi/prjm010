<?php if(!class_exists('Rain\Tpl')){exit;}?><div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Histórico do Hidrante <?php if( $hydrants["0"]['hydrant_id'] != NULL ){ ?> <?php echo htmlspecialchars( $hydrants["0"]['tipe'], ENT_COMPAT, 'UTF-8', FALSE ); ?> - <?php echo htmlspecialchars( $hydrants["0"]['idnumber'], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active"><a href="/hydrant">Hidrantes</a></li>
      </ol>
    </section>
    <!-- Main content -->
    <section class="content">
      <div class="box box-primary">
        <div class="col form-control top">
          <div class="row">
            <div class="col col-md-4">
              <form action="/historicH/create" method="get">
                <input type="submit" name="btnhydrant" class="btn btn-success" value="Cadastrar Histórico">
                <a href="/hydrant?pg=1" class="btn btn-warning">Voltar</a>
                <input type="text" name="hydrant_id" value="<?php if( $hydrants != NULL ){ ?><?php echo htmlspecialchars( $hydrants["0"]['hydrant_id'], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>" hidden>
              </form>
            </div>
            <form action="/historicH" method="get" <?php if( !$hydrants ){ ?>hidden<?php } ?>>
              <div class="col col-md-2"></div>
              <input type="text" name="hydrant_id" value="<?php if( $hydrants != NULL ){ ?><?php echo htmlspecialchars( $hydrants["0"]['hydrant_id'], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>" hidden>
              <input type="text" name="idnumber"   value="<?php if( $hydrants != NULL ){ ?><?php echo htmlspecialchars( $hydrants["0"]['idnumber'], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>" hidden>
              <input type="text" name="tipe"       value="<?php if( $hydrants != NULL ){ ?><?php echo htmlspecialchars( $hydrants["0"]['tipe'], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>" hidden>
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
        <div class="msg"><input type="text" class="form-control msg-<?php if( $msg["state"] == 'SUCCESS'  ){ ?>success alert-success<?php }else{ ?>danger alert-danger<?php } ?>" name="msg" value="<?php echo htmlspecialchars( $msg["msg"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" readonly ></div>
        <div class="msg"><textarea class="form-control" name="err" id="err" rows="3" <?php if( $msg["err"] != NULL ){ ?>hidden<?php } ?> readonly><?php echo htmlspecialchars( $msg["err"], ENT_COMPAT, 'UTF-8', FALSE ); ?></textarea></div>
      </div>
      <div class="box box-primary" <?php if( $hydrants["0"]['historic_id'] == NULL ){ ?>hidden<?php } ?>>
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
                <li><a href="hydrant?pg=<?php echo htmlspecialchars( $i, ENT_COMPAT, 'UTF-8', FALSE ); ?><?php if( $pgs["list"]["limit"] ){ ?>&limit=<?php echo htmlspecialchars( $pgs["list"]["limit"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["search"] ){ ?>&search=<?php echo htmlspecialchars( $pgs["list"]["search"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>"><?php echo htmlspecialchars( $i++, ENT_COMPAT, 'UTF-8', FALSE ); ?></a></li>
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
      <div class="box box-primary" <?php if( $hydrants["0"]['historic_id'] == NULL ){ ?>hidden<?php } ?>>
        <div class="box-body no-padding">
          <table class="table table-straped">
            <thead class="thead-dark">
              <tr class="alert-primary">
                <th>Localização</th>
                <th>Local</th>
                <th>Tipo</th>
                <th>Número</th>
              </tr>
            </thead>
            <tbody>
              <?php if( $hydrants["0"]['historic_id'] != NULL ){ ?>
              <tr>
                <td><?php echo htmlspecialchars( $hydrants["0"]['deslocation'], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
                <td><?php echo htmlspecialchars( $hydrants["0"]['deslocal'], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
                <td><?php echo htmlspecialchars( $hydrants["0"]['tipe'], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
                <td><?php echo htmlspecialchars( $hydrants["0"]['idnumber'], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              </tr>
              <?php } ?>
            </tbody>
          </table>
        </div>
      </div>
      <div class="box box-primary" <?php if( $hydrants["0"]['historic_id'] == NULL ){ ?>hidden<?php } ?>>
        <div class="box-body no-padding">
          <table class="table table-straped">
            <thead class="thead-dark">
              <tr class="alert-warning">
                <th>Data</th>
                <th>Chave</th>
                <th>Mangeuira</th>
                <th>Esguicho</th>
                <th>Pintura</th>
                <th>Alarme</th>
                <th>Vidro</th>
                <th>Trava</th>
                <th>Registro</th>
                <th>Sinalização</th>
                <th>Obstrução</th>
                <th>Ação</th>
              </tr>
            </thead>
            <tbody>
              <?php if( $hydrants["0"]['historic_id'] != NULL ){ ?>
              <?php $counter1=-1;  if( isset($hydrants) && ( is_array($hydrants) || $hydrants instanceof Traversable ) && sizeof($hydrants) ) foreach( $hydrants as $key1 => $value1 ){ $counter1++; ?>
              <tr>
                <td><?php echo htmlspecialchars( $value1["daydate"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
                <td><?php if( $value1["idkey"] == 0 ){ ?>OK<?php }else{ ?>NÃO OK<?php } ?></td>
                <td><?php if( $value1["hose"] == 0 ){ ?>OK<?php }else{ ?>NÃO OK<?php } ?></td>
                <td><?php if( $value1["squirt"] == 0 ){ ?>OK<?php }else{ ?>NÃO OK<?php } ?></td>
                <td><?php if( $value1["painting"] == 0 ){ ?>OK<?php }else{ ?>NÃO OK<?php } ?></td>
                <td><?php if( $value1["alarmcentral"] == 0 ){ ?>OK<?php }else{ ?>NÃO OK<?php } ?></td>
                <td><?php if( $value1["glass"] == 0 ){ ?>OK<?php }else{ ?>NÃO OK<?php } ?></td>
                <td><?php if( $value1["inlock"] == 0 ){ ?>OK<?php }else{ ?>NÃO OK<?php } ?></td>
                <td><?php if( $value1["record"] == 0 ){ ?>OK<?php }else{ ?>NÃO OK<?php } ?></td>
                <td><?php if( $value1["signaling"] == 0 ){ ?>OK<?php }else{ ?>NÃO OK<?php } ?></td>
                <td><?php if( $value1["obstruction"] == 0 ){ ?>OK<?php }else{ ?>NÃO OK<?php } ?></td>
                <td>
                  <a href="/historicH/<?php if( $hydrants["0"]['historic_id'] ){ ?><?php echo htmlspecialchars( $value1["historic_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>" class="btn btn-primary btn-xs" title="Editar Histórico"><i class="fa fa-edit"></i></a>
                  <a href="/historicH/<?php if( $hydrants["0"]['historic_id'] ){ ?><?php echo htmlspecialchars( $value1["historic_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>/delete" onclick="return confirm('Deseja realmente excluir este registro?')" class="btn btn-danger btn-xs" title="Excluir Histórico"><i class="fa fa-trash"></i></a>
                </td>
              </tr>
              <?php } ?><?php } ?>
            </tbody>
          </table>
        </div>
      </div>
      <div class="box box-primary" <?php if( $hydrants["0"]['historic_id'] == NULL ){ ?>hidden<?php } ?>>
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
                <li><a href="hydrant?pg=<?php echo htmlspecialchars( $i, ENT_COMPAT, 'UTF-8', FALSE ); ?><?php if( $pgs["list"]["limit"] ){ ?>&limit=<?php echo htmlspecialchars( $pgs["list"]["limit"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["search"] ){ ?>&search=<?php echo htmlspecialchars( $pgs["list"]["search"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>"><?php echo htmlspecialchars( $i++, ENT_COMPAT, 'UTF-8', FALSE ); ?></a></li>
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
  