<?php if(!class_exists('Rain\Tpl')){exit;}?><div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Lista de Hidrantes
      </h1>
      <ol class="breadcrumb">
        <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active"><a href="/hydrant?pg=1">Hidrante</a></li>
      </ol>
    </section>
    <!-- Main content -->
    <section class="content">
      <div class="box box-primary">
        <div class="col form-control top">
          <div class="row">
            <div class="col col-md-4">
              <form action="/hydrant/create" method="get">
                <input type="submit" name="btnhydrant" class="btn btn-success" value="Cadastrar Hidrante">
                <input type="text" name="hydrant" value="hydrant" hidden>
              </form>
            </div>
            <form action="/hydrant" method="get" <?php if( !$hydrants ){ ?>hidden<?php } ?>>
              <div class="col col-md-2"><label for="deslocation">Localização</label><input type="text" name="deslocation" id="deslocation" class="form-control"></div>
              <div class="col col-md-2"><label for="tipe">Tipo</label><input type="text" name="tipe" id="tipe" class="form-control"></div>
              <div class="col col-md-2"><label for="idnumber">Número</label><input type="text" name="idnumber" id="idnumber" class="form-control"></div>
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
      <div class="box box-primary" <?php if( $hydrants["0"]['hydrant_id'] == NULL ){ ?>hidden<?php } ?>>
        <div class="box-body no-padding">
          <table class="table table-straped">
            <thead class="thead-dark">
              <tr class="alert-warning">
                <th>Localização</th>
                <th>Local</th>
                <th>Tipo</th>
                <th>Número</th>
                <th>Observação</th>
                <th>Ação</th>
              </tr>
            </thead>
            <tbody>
              <?php $counter1=-1;  if( isset($hydrants) && ( is_array($hydrants) || $hydrants instanceof Traversable ) && sizeof($hydrants) ) foreach( $hydrants as $key1 => $value1 ){ $counter1++; ?>
              <tr>
                <td><?php echo htmlspecialchars( $value1["deslocation"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
                <td><?php echo htmlspecialchars( $value1["deslocal"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
                <td><?php echo htmlspecialchars( $value1["tipe"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
                <td><?php echo htmlspecialchars( $value1["idnumber"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
                <td><?php echo htmlspecialchars( $value1["observation"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
                <td>
                  <a href="/hydrant/<?php echo htmlspecialchars( $value1["hydrant_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" class="btn btn-primary btn-xs" title="Editar Extintor"><i class="fa fa-edit"></i></a>
                  <a href="/historicH?hydrant_id=<?php echo htmlspecialchars( $value1["hydrant_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" class="btn btn-success btn-xs" title="Cadastrar Histórico"><i class="fa fa-save"></i></a>
                  <a href="/hydrant/<?php echo htmlspecialchars( $value1["hydrant_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>/delete" onclick="return confirm('Deseja realmente excluir este registro?')" class="btn btn-danger btn-xs" title="Excluir Extintor"><i class="fa fa-trash"></i></a>
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
  