<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="box box-success title" style="background-color: #d5f8da;">
        <h4>
          Cadastro de Histórico do Purificador
        </h4>
      </div>
      <ol class="breadcrumb">
        <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="/historicP/<?php echo htmlspecialchars( $historic["purifier_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">Histórico</a></li>
        <li class="active"><a href="/historicP/create">Cadastrar</a></li>
      </ol>
    </section>
    
    <!-- Main content -->
    <section class="content">
    
      <div class="row">
          <div class="col-md-12">
            <div class="box box-success">
            <!-- form start -->
            
              <form role="form" action="/historicP/<?php echo htmlspecialchars( $historic["historic_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" method="post" enctype="multipart/form-data">
                <input type="text" name="purifier_id" value="<?php echo htmlspecialchars( $historic["purifier_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" hidden>
                <input type="text" name="historic_id" value="<?php echo htmlspecialchars( $historic["historic_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" hidden>
                <div class="box-body">
                  <div class="col col-md-2">
                    <div class="form-group">
                      <label for="daydate">Data da Manutenção</label>
                      <input type="text" class="form-control" id="daydate" name="daydate" value="<?php echo htmlspecialchars( $historic["daydate"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onChange="replaceSlash(daydate)" >
                    </div>
                  </div>
                  <div class="col col-md-4">
                    <div class="form-group">
                      <label for="serialnumber">Nº Serial</label>
                      <input type="text" class="form-control" name="serialnumber" id="serialnumber" value="<?php echo htmlspecialchars( $historic["serialnumber"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(serialnumber)" required readonly>
                    </div>
                  </div>
                                
                </div>
                <!-- /.box-body -->
                <div class="box-footer">
                  <input type="submit" id="purifier" class="btn btn-success" value="Atualizar Histórico">
                  
                  <a href="/historicP?purifier_id=<?php echo htmlspecialchars( $historic["purifier_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>&limit=10" class="btn btn-warning">Voltar</a>
                  
                </div>
              </form>
            </div>
          </div>
      </div>
    
    </section>
    <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    