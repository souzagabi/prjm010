<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="box box-success title" style="background-color: #d5f8da;">
        <h4>
          Cadastro de Histórico de Hidrante
        </h4>
      </div>
      <ol class="breadcrumb">
        <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="/historicH/<?php echo htmlspecialchars( $hydrant, ENT_COMPAT, 'UTF-8', FALSE ); ?>">Histórico</a></li>
        <li class="active"><a href="/historicH/create">Cadastrar</a></li>
      </ol>
    </section>
    
    <!-- Main content -->
    <section class="content">
    
      <div class="row">
          <div class="col-md-12">
            <div id="msg<?php if( $msg["state"] == 'SUCCESS' ){ ?>-success<?php }else{ ?>-danger<?php } ?>" 
                  class="box box-<?php if( $msg["state"] == 'SUCCESS' ){ ?>-success<?php }else{ ?>danger<?php } ?>" 
                  <?php if( $msg["state"] != 'SUCCESS' && $msg["state"] != 'ERROR' ){ ?>readonly hidden<?php } ?>>
              <div class="msg"><input type="text" class="form-control msg-<?php if( $msg["state"] == 'SUCCESS'  ){ ?>success alert-success<?php }else{ ?>danger alert-danger<?php } ?>" name="msg" value="<?php echo htmlspecialchars( $msg["msg"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" ></div>
            </div>
            <div class="box box-success">
            <!-- form start -->
            
            <form role="form" action="/historicH/create?<?php if( $hydrant != NULL ){ ?><?php echo htmlspecialchars( $hydrant, ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>" method="post" enctype="multipart/form-data">
              <input type="text" name="hydrant_id" value="<?php echo htmlspecialchars( $hydrant, ENT_COMPAT, 'UTF-8', FALSE ); ?>" hidden>
              <div class="box-body">
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="daydate">Data do Dia</label>
                    <?php $counter1=-1;  if( isset($date) && ( is_array($date) || $date instanceof Traversable ) && sizeof($date) ) foreach( $date as $key1 => $value1 ){ $counter1++; ?>
                    <input type="text" class="form-control" id="daydate" name="daydate" value="<?php echo htmlspecialchars( $date["date"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onChange="replaceSlash(daydate)" >
                    <?php } ?>
                  </div>
                </div>
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="idkey">Chave</label>
                    <select class="form-control" name="idkey" id="idkey">
                      <option value="0" selected>OK</option>
                      <option value="1">NÃO OK</option>
                    </select>
                  </div>
                </div>
                
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="hose">Mangueira</label>
                    <select class="form-control" name="hose" id="hose">
                      <option value="0" selected>OK</option>
                      <option value="1">NÃO OK</option>
                    </select>
                  </div>
                </div>
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="squirt">Esguicho</label>
                    <select class="form-control" name="squirt" id="squirt">
                      <option value="0" selected>OK</option>
                      <option value="1">NÃO OK</option>
                    </select>
                  </div>
                </div>
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="painting">Pintura</label>
                    <select class="form-control" name="painting" id="painting">
                      <option value="0" selected>OK</option>
                      <option value="1">NÃO OK</option>
                    </select>
                  </div>
                </div>
                <div class="col col-md-2">
                  <label for="alarmcentral">Alarme</label>
                    <select class="form-control" name="alarmcentral" id="alarmcentral">
                      <option value="0" selected>OK</option>
                      <option value="1">NÃO OK</option>
                    </select>
                </div>
              </div>
              <div class="box-body">
                <div class="col col-md-2">
                  <label for="glass">Vidro</label>
                    <select class="form-control" name="glass" id="glass">
                      <option value="0" selected>OK</option>
                      <option value="1">NÃO OK</option>
                    </select>
                </div>
                <div class="col col-md-2">
                  <label for="inlock">Trava</label>
                    <select class="form-control" name="inlock" id="inlock">
                      <option value="0" selected>OK</option>
                      <option value="1">NÃO OK</option>
                    </select>
                </div>
                <div class="col col-md-2">
                  <label for="record">Registro</label>
                    <select class="form-control" name="record" id="record">
                      <option value="0" selected>OK</option>
                      <option value="1">NÃO OK</option>
                    </select>
                </div>
                <div class="col col-md-2">
                  <label for="signaling">Sinalização</label>
                    <select class="form-control" name="signaling" id="signaling">
                      <option value="0" selected>OK</option>
                      <option value="1">NÃO OK</option>
                    </select>
                </div>
                <div class="col col-md-2">
                  <label for="obstruction">Obstrução</label>
                    <select class="form-control" name="obstruction" id="obstruction">
                      <option value="0" selected>OK</option>
                      <option value="1">NÃO OK</option>
                    </select>
                </div>
                
              </div>
              <div class="box-body">
                <div class="col col-md-12">
                  <div class="form-group">
                    <label for="observation">Observação</label>
                    <textarea class="form-control" maxlength="255" name="observation" id="observation"></textarea>
                  </div>
                </div>
              </div>
              <!-- /.box-body -->
              <div class="box-body">
                <div class="box-footer">
                  <input type="submit" id="hydrant" class="btn btn-success" value="Cadastrar Histórico">
                  
                  <a href="/historicH?hydrant_id=<?php echo htmlspecialchars( $hydrant, ENT_COMPAT, 'UTF-8', FALSE ); ?>&limit=10" class="btn btn-warning">Voltar</a>
                </div>
              </div>
            </form>
          </div>
          </div>
      </div>
    
    </section>
    <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    