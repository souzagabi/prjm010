<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="box box-success title" style="background-color: #d5f8da;">
        <h4>
          Edição de Histórico do Ar Condicionado
        </h4>
      </div>
      <ol class="breadcrumb">
        <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="/historicA/<?php echo htmlspecialchars( $historic["airconditioning_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">Histórico</a></li>
        <li class="active">Edição</li>
      </ol>
    </section>
    
    <!-- Main content -->
    <section class="content">
    
      <div class="row">
          <div class="col-md-12">
            <div class="box box-success">
            <!-- form start -->
            
            <form role="form" action="/historicA/<?php echo htmlspecialchars( $historic["historic_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" method="post" enctype="multipart/form-data">
              <input type="text" name="airconditioning_id" value="<?php echo htmlspecialchars( $historic["airconditioning_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" hidden>
              <div class="box-body">
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="inmonth">Mês</label>
                    <input type="text" class="form-control" id="inmonth" name="inmonth" value="<?php echo htmlspecialchars( $historic["inmonth"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(inmonth)" >
                  </div>
                </div>
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="daydate">Data do Dia</label>
                    <input type="text" class="form-control" id="daydate" name="daydate" value="<?php echo htmlspecialchars( $historic["daydate"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onChange="replaceSlash(daydate)" >
                  </div>
                </div>
              </div>
              <!-- /.box-body -->
              <div class="box-footer">
                <input type="submit" id="historic" class="btn btn-success" value="Aualizar Histórico">
               <a href="/historicA?airconditioning_id=<?php echo htmlspecialchars( $historic["airconditioning_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>&limit=10" class="btn btn-warning">Voltar</a>
              </div>
            </form>
          </div>
          </div>
      </div>
    
    </section>
    <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    