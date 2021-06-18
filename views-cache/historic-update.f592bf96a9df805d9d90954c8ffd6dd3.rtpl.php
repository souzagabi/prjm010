<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="box box-success title" style="background-color: #d5f8da;">
        <h4>
          Edição de Histórico de Hidrante
        </h4>
      </div>
      <ol class="breadcrumb">
        <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="/historicH/<?php echo htmlspecialchars( $historic["hydrant_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">Histórico</a></li>
        <li class="active"><a href="/historicHU/<?php echo htmlspecialchars( $historic["historic_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">Edição</a></li>
      </ol>
    </section>
    
    <!-- Main content -->
    <section class="content">
    
      <div class="row">
          <div class="col-md-12">
            <div class="box box-success">
            <!-- form start -->
            
            <form role="form" action="/historicH/<?php echo htmlspecialchars( $historic["historic_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" method="post" enctype="multipart/form-data">
              <input type="text" name="hydrant_id" value="<?php echo htmlspecialchars( $historic["hydrant_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" hidden>
              <div class="box-body">
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="daydate">Data do Dia</label>
                    <input type="text" class="form-control" id="daydate" name="daydate" value="<?php echo htmlspecialchars( $historic["daydate"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onChange="replaceSlash(daydate)" >
                  </div>
                </div>
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="idkey">Chave</label>
                    <select class="form-control" name="idkey" id="idkey" value="<?php echo htmlspecialchars( $historic["idkey"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">
                      <option value="0" <?php if( $historic["idkey"] == 0 ){ ?>selected<?php } ?>>OK</option>
                      <option value="1" <?php if( $historic["idkey"] == 1 ){ ?>selected<?php } ?>>NÃO OK</option>
                    </select>
                  </div>
                </div>
                
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="hose">Mangueira</label>
                    <select class="form-control" name="hose" id="hose" value="<?php echo htmlspecialchars( $historic["hose"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">
                      <option value="0" <?php if( $historic["hose"] == 0 ){ ?>selected<?php } ?>>OK</option>
                      <option value="1" <?php if( $historic["hose"] == 1 ){ ?>selected<?php } ?>>NÃO OK</option>
                    </select>
                  </div>
                </div>
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="squirt">Esguicho</label>
                    <select class="form-control" name="squirt" id="squirt" value="<?php echo htmlspecialchars( $historic["squirt"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">
                      <option value="0" <?php if( $historic["squirt"] == 0 ){ ?>selected<?php } ?>>OK</option>
                      <option value="1" <?php if( $historic["squirt"] == 1 ){ ?>selected<?php } ?>>NÃO OK</option>
                    </select>
                  </div>
                </div>
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="painting">Pintura</label>
                    <select class="form-control" name="painting" id="painting" value="<?php echo htmlspecialchars( $historic["painting"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">
                      <option value="0" <?php if( $historic["painting"] == 0 ){ ?>selected<?php } ?>>OK</option>
                      <option value="1" <?php if( $historic["painting"] == 1 ){ ?>selected<?php } ?>>NÃO OK</option>
                    </select>
                  </div>
                </div>
                <div class="col col-md-2">
                  <label for="alarmcentral">Alarme</label>
                    <select class="form-control" name="alarmcentral" id="alarmcentral" value="<?php echo htmlspecialchars( $historic["alarmcentral"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">
                      <option value="0" <?php if( $historic["alarmcentral"] == 0 ){ ?>selected<?php } ?>>OK</option>
                      <option value="1" <?php if( $historic["alarmcentral"] == 1 ){ ?>selected<?php } ?>>NÃO OK</option>
                    </select>
                </div>
              </div>
              <div class="box-body">
                <div class="col col-md-2">
                  <label for="glass">Vidro</label>
                    <select class="form-control" name="glass" id="glass" value="<?php echo htmlspecialchars( $historic["glass"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">
                      <option value="0" <?php if( $historic["glass"]== 0 ){ ?>selected<?php } ?>>OK</option>
                      <option value="1" <?php if( $historic["glass"]== 1 ){ ?>selected<?php } ?>>NÃO OK</option>
                    </select>
                </div>
                <div class="col col-md-2">
                  <label for="inlock">Trava</label>
                    <select class="form-control" name="inlock" id="inlock" value="<?php echo htmlspecialchars( $historic["inlock"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">
                      <option value="0" <?php if( $historic["inlock"]== 0 ){ ?>selected<?php } ?>>OK</option>
                      <option value="1" <?php if( $historic["inlock"]== 1 ){ ?>selected<?php } ?>>NÃO OK</option>
                    </select>
                </div>
                <div class="col col-md-2">
                  <label for="record">Registro</label>
                    <select class="form-control" name="record" id="record" value="<?php echo htmlspecialchars( $historic["record"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">
                      <option value="0" <?php if( $historic["record"]== 0 ){ ?>selected<?php } ?>>OK</option>
                      <option value="1" <?php if( $historic["record"]== 1 ){ ?>selected<?php } ?>>NÃO OK</option>
                    </select>
                </div>
                <div class="col col-md-2">
                  <label for="signaling">Sinalização</label>
                    <select class="form-control" name="signaling" id="signaling" value="<?php echo htmlspecialchars( $historic["signaling"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">
                      <option value="0" <?php if( $historic["signaling"]== 0 ){ ?>selected<?php } ?>>OK</option>
                      <option value="1" <?php if( $historic["signaling"]== 1 ){ ?>selected<?php } ?>>NÃO OK</option>
                    </select>
                </div>
                <div class="col col-md-2">
                  <label for="obstruction">Obstrução</label>
                    <select class="form-control" name="obstruction" id="obstruction" value="<?php echo htmlspecialchars( $historic["obstruction"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">
                      <option value="0" <?php if( $historic["obstruction"]== 0 ){ ?>selected<?php } ?>>OK</option>
                      <option value="1" <?php if( $historic["obstruction"]== 1 ){ ?>selected<?php } ?>>NÃO OK</option>
                    </select>
                </div>
                
              </div>
              <div class="box-body">
                <div class="col col-md-12">
                  <div class="form-group">
                    <label for="observation">Observação</label>
                    <textarea class="form-control" maxlength="255" name="observation" id="observation"><?php echo htmlspecialchars( $historic["observation"], ENT_COMPAT, 'UTF-8', FALSE ); ?></textarea>
                  </div>
                </div>
              </div>
              <!-- /.box-body -->
              <div class="box-body">
                <div class="box-footer">
                  <input type="submit" id="historic" class="btn btn-success" value="Aualizar Histórico">
                 <a href="/historicH?hydrant_id=<?php echo htmlspecialchars( $historic["hydrant_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>&limit=10" class="btn btn-warning">Voltar</a>
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
    