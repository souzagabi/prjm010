<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="box box-success title" style="background-color: #d5f8da;">
        <h4>
          Cadastro de Histórico de Extintor
        </h4>
      </div>
      <ol class="breadcrumb">
        <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="/historicE/<?php echo htmlspecialchars( $fireexting, ENT_COMPAT, 'UTF-8', FALSE ); ?>">Histórico</a></li>
        <li class="active"><a href="/historicE/create">Cadastrar</a></li>
      </ol>
    </section>
    
    <!-- Main content -->
    <section class="content">
    
      <div class="row">
          <div class="col-md-12">
            <div id="msg<?php if( $msg["state"] == 'SUCCESS' ){ ?>-success<?php }else{ ?>-danger<?php } ?>" 
                  class="box box-<?php if( $msg["state"] == 'SUCCESS' ){ ?>-success<?php }else{ ?>danger<?php } ?>" 
                  <?php if( $msg["state"] != 'SUCCESS' && $msg["state"] != 'ERROR' ){ ?>readonly hidden<?php } ?>>
              <div class="msg"><input type="text" class="form-control msg-<?php if( $msg["state"] == 'SUCCESS'  ){ ?>success alert-success<?php }else{ ?>danger alert-danger<?php } ?>" name="msg" value="<?php echo htmlspecialchars( $msg["msg"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" readonly ></div>
              <div class="msg"><textarea class="form-control" name="err" id="err" rows="3" <?php if( $msg["err"] != NULL ){ ?>hidden<?php } ?> readonly><?php echo htmlspecialchars( $msg["err"], ENT_COMPAT, 'UTF-8', FALSE ); ?></textarea></div>
            </div>
            <div class="box box-success">
            <!-- form start -->
            
            <form role="form" action="/historicE/create?<?php if( $fireexting != NULL ){ ?><?php echo htmlspecialchars( $fireexting, ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>" method="post" enctype="multipart/form-data">
              <input type="text" name="fireexting_id" value="<?php echo htmlspecialchars( $fireexting, ENT_COMPAT, 'UTF-8', FALSE ); ?>" hidden>
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
                    <label for="htrigger">Gatilho</label>
                    <select class="form-control" name="htrigger" id="htrigger">
                      <option value="0" selected>OK</option>
                      <option value="1">NÃO OK</option>
                    </select>
                  </div>
                </div>
                
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="hose">Mangote</label>
                    <select class="form-control" name="hose" id="hose">
                      <option value="0" selected>OK</option>
                      <option value="1">NÃO OK</option>
                    </select>
                  </div>
                </div>
                <div class="col col-md-2">
                  <label for="diffuser">Difusor</label>
                    <select class="form-control" name="diffuser" id="diffuser">
                      <option value="0" selected>OK</option>
                      <option value="1">NÃO OK</option>
                    </select>
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
                  <div class="form-group">
                    <label for="hydrostatic">Teste Hidrostático</label>
                    <select class="form-control" name="hydrostatic" id="hydrostatic">
                      <option value="0" selected>OK</option>
                      <option value="1">NÃO OK</option>
                    </select>
                  </div>
                </div>
              </div>
              <div class="box-body">
                <div class="col col-md-4">
                  <div class="form-group">
                    <label for="hothers">Outros</label>
                    <input type="text" class="form-control" name="hothers" id="hothers" onKeyUp="convertLowToUpper(hothers)" required>
                  </div>
                </div>
                               
              </div>
              <!-- /.box-body -->
              <div class="box-footer">
                <input type="submit" id="fireexting" class="btn btn-success" value="Cadastrar Histórico">
                
                <a href="/historicE?fireexting_id=<?php echo htmlspecialchars( $fireexting, ENT_COMPAT, 'UTF-8', FALSE ); ?>&limit=10" class="btn btn-warning">Voltar</a>
                
              </div>
            </form>
          </div>
          </div>
      </div>
    
    </section>
    <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    