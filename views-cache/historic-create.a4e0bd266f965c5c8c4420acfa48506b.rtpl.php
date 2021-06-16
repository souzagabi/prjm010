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
        <li><a href="/historicA/<?php echo htmlspecialchars( $airconditioning, ENT_COMPAT, 'UTF-8', FALSE ); ?>">Histórico</a></li>
        <li class="active"><a href="/historicA/create">Cadastrar</a></li>
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
            
            <form role="form" action="/historicA/create?<?php if( $airconditioning != NULL ){ ?><?php echo htmlspecialchars( $airconditioning, ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>" method="post" enctype="multipart/form-data">
              <input type="text" name="airconditioning_id" value="<?php echo htmlspecialchars( $airconditioning, ENT_COMPAT, 'UTF-8', FALSE ); ?>" hidden>
              <div class="box-body">
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="inmonth">Mês</label>
                    <input type="text" class="form-control" id="inmonth" name="inmonth" value="<?php echo htmlspecialchars( $month, ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(inmonth)" >
                  </div>
                </div>
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="daydate">Data do Dia</label>
                    <input type="text" class="form-control" id="daydate" name="daydate" onChange="replaceSlash(daydate)" >
                  </div>
                </div>
              </div>
              <!-- /.box-body -->
              <div class="box-footer">
                <input type="submit" id="airconditioning" class="btn btn-success" value="Cadastrar Histórico">
                
                <a href="/historicA?airconditioning_id=<?php echo htmlspecialchars( $airconditioning, ENT_COMPAT, 'UTF-8', FALSE ); ?>&limit=10" class="btn btn-warning">Voltar</a>
                
              </div>
            </form>
          </div>
          </div>
      </div>
    
    </section>
    <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    