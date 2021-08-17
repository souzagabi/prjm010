<?php if(!class_exists('Rain\Tpl')){exit;}?><div class="content-wrapper">
  <!-- Content Header (Page header) -->
  <section class="content-header">
    <h1>
      Lista de Manutenção Preventiva
    </h1>
    <ol class="breadcrumb">
      <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
      <li class="active">Manutenção Preventiva</li>
    </ol>
  </section>
  <!-- Main content -->
  <section class="content">
    <div class="box box-warning">
      <div class="form-control col alert-warning" style="color:#f60606 !important; font-size: 16px;">
        Para cadastrar o plano anual de manutenção 
                        é necessário estar cadastro "Equipamento", "Localização", "Local", "Responsável".
      </div>
    </div>
    <div class="box box-primary">
      <div class="alert-primary" style="text-align: center;">Botões de Cadastro</div>
      <div class="col form-control top">
        <div class="col col-md-2">
          <form action="/equipament" method="get">
            <label for="btnequipament" class="alert-warning">1</label>
            <input type="submit" name="btnequipament" class="btn btn-success" value="Equipuipamento">
          </form>
        </div>
        <div class="col col-md-2">
          <form action="/location" method="get">
            <label for="btnlocation" class="alert-warning">2</label>
            <input type="submit" name="btnlocation" class="btn btn-success" value="Localização">
          </form>
        </div>
        <div class="col col-md-2">
          <form action="/local" method="get">
            <label for="btnlocal" class="alert-warning">3</label>
            <input type="submit" name="btnlocal" class="btn btn-success" value="Local">
          </form>
        </div>
        <div class="col col-md-2">
          <form action="/responsable" method="get">
            <label for="btnresponsable" class="alert-warning">4</label>
            <input type="submit" name="btnresponsable" class="btn btn-success" value="Responsável">
          </form>
        </div>
        <div class="col col-md-2">
        </div>
        <div class="col col-md-2">
          <form action="/anualplan/create" method="get">
            <label for="btnanualplan" class="alert-warning">5</label>
            <input type="submit" name="btnanualplan" class="btn btn-primary" value="Plano Anual">
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
              <li><a href="anualplan?pg=<?php echo htmlspecialchars( $i, ENT_COMPAT, 'UTF-8', FALSE ); ?><?php if( $pgs["list"]["daydate"] ){ ?>&daydate=<?php echo htmlspecialchars( $pgs["list"]["daydate"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["limit"] ){ ?>&limit=<?php echo htmlspecialchars( $pgs["list"]["limit"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["search"] ){ ?>&search=<?php echo htmlspecialchars( $pgs["list"]["search"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>"><?php echo htmlspecialchars( $i++, ENT_COMPAT, 'UTF-8', FALSE ); ?></a></li>
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
    <div class="box box-primary" <?php if( $anualplans["0"]['anualplan_id'] == NULL ){ ?>hidden<?php } ?>>
      <div class="box-body no-padding">
        <table class="table table-straped">
          <thead class="thead-dark">
            <tr class="alert-warning">
              <th>Ano</th>
              <th>Equipamento</th>
              <th>Localização</th>
              <th>Local</th>
              <th>Responsável</th>
              <th>Prev. Manutenção</th>
              <th>Ação</th>
            </tr>
          </thead>
          <tbody>
            <?php $counter1=-1;  if( isset($anualplans) && ( is_array($anualplans) || $anualplans instanceof Traversable ) && sizeof($anualplans) ) foreach( $anualplans as $key1 => $value1 ){ $counter1++; ?>
            <tr>
              <td><?php echo htmlspecialchars( $value1["yyear"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td><?php echo htmlspecialchars( $value1["desequipament"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td><?php echo htmlspecialchars( $value1["deslocation"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td><?php echo htmlspecialchars( $value1["deslocal"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td><?php echo htmlspecialchars( $value1["responsable"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td><?php echo htmlspecialchars( $value1["dtprevision"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
              <td>
                <a href="/anualplan/<?php echo htmlspecialchars( $value1["anualplan_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" class="btn btn-primary btn-xs"><i class="fa fa-edit"></i></a>
                <a href="/anualplan/<?php echo htmlspecialchars( $value1["anualplan_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>/delete" onclick="return confirm('Deseja realmente excluir este registro?')" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i></a>
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
              <li><a href="anualplan?pg=<?php echo htmlspecialchars( $i, ENT_COMPAT, 'UTF-8', FALSE ); ?><?php if( $pgs["list"]["daydate"] ){ ?>&daydate=<?php echo htmlspecialchars( $pgs["list"]["daydate"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["limit"] ){ ?>&limit=<?php echo htmlspecialchars( $pgs["list"]["limit"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?><?php if( $pgs["list"]["search"] ){ ?>&search=<?php echo htmlspecialchars( $pgs["list"]["search"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>"><?php echo htmlspecialchars( $i++, ENT_COMPAT, 'UTF-8', FALSE ); ?></a></li>
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
