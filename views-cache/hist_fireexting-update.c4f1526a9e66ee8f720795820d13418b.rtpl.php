<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="box box-success title" style="background-color: #d5f8da;">
        <h4>
          Edição de Histórico de Extintor
        </h4>
      </div>
      <ol class="breadcrumb">
        <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="/fireextingH/<?php echo htmlspecialchars( $historic["fireexting_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">Histórico</a></li>
        <li class="active"><a href="/fireextingU/<?php echo htmlspecialchars( $historic["historic_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">Edição</a></li>
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
            
            <form role="form" action="/fireextingU/<?php echo htmlspecialchars( $historic["historic_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" method="post" enctype="multipart/form-data"></form>
              <input type="text" name="fireexting_id" value="<?php echo htmlspecialchars( $historic["fireexting_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" hidden>
              <div class="box-body">
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="daydate">Data do Dia</label>
                    <input type="text" class="form-control" id="daydate" name="daydate" value="<?php echo htmlspecialchars( $historic["daydate"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onChange="replaceSlash(daydate)" >
                  </div>
                </div>
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="htrigger">Gatilho</label>
                    <select class="form-control" name="htrigger" id="htrigger">
                      <option value="0" <?php if( $historic["htrigger"] ){ ?> selected<?php } ?>>OK</option>
                      <option value="1" <?php if( $historic["htrigger"] ){ ?> selected<?php } ?>>NÃO OK</option>
                    </select>
                  </div>
                </div>
                
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="hose">Mangote</label>
                    <select class="form-control" name="hose" id="hose">
                      <option value="0" <?php if( $historic["hose"] ){ ?> selected<?php } ?>>OK</option>
                      <option value="1" <?php if( $historic["hose"] ){ ?> selected<?php } ?>>NÃO OK</option>
                    </select>
                  </div>
                </div>
                <div class="col col-md-2">
                  <label for="diffuser">Difusor</label>
                    <select class="form-control" name="diffuser" id="diffuser">
                      <option value="0" <?php if( $historic["diffuser"] ){ ?> selected<?php } ?>>OK</option>
                      <option value="1" <?php if( $historic["diffuser"] ){ ?> selected<?php } ?>>NÃO OK</option>
                    </select>
                </div>
              
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="painting">Pintura</label>
                    <select class="form-control" name="painting" id="painting">
                      <option value="0" <?php if( $historic["painting"] ){ ?> selected<?php } ?>>OK</option>
                      <option value="1" <?php if( $historic["painting"] ){ ?> selected<?php } ?>>NÃO OK</option>
                    </select>
                  </div>
                </div>
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="hydrostatic">Teste Hidrostático</label>
                    <select class="form-control" name="hydrostatic" id="hydrostatic">
                      <option value="0" <?php if( $historic["hydrostatic"] ){ ?> selected<?php } ?>>OK</option>
                      <option value="1" <?php if( $historic["hydrostatic"] ){ ?> selected<?php } ?>>NÃO OK</option>
                    </select>
                  </div>
                </div>
              </div>
              <div class="box-body">
                <div class="col col-md-4">
                  <div class="form-group">
                    <label for="hothers">Outros</label>
                    <input type="text" class="form-control" name="hothers" id="hothers" value="<?php echo htmlspecialchars( $historic["hothers"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(hothers)" required>
                  </div>
                </div>
                               
              </div>
              <!-- /.box-body -->
              <div class="box-footer">
                <input type="submit" id="fireexting" class="btn btn-success" value="Aualizar Histórico">
                <a href="/fireextingH/<?php echo htmlspecialchars( $historic["fireexting_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>?limit=10" class="btn btn-warning">Voltar</a>
              </div>
            </form>
          </div>
          </div>
      </div>
    
    </section>
    <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    