<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="box box-success title" style="background-color: #d5f8da;">
        <h4>
          Editção de Extintor
        </h4>
      </div>
      <ol class="breadcrumb">
        <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="/fireexting">Extintores</a></li>
        <li class="active"><a href="/fireexting/create">Cadastrar</a></li>
      </ol>
    </section>
    
    <!-- Main content -->
    <section class="content">
    
      <div class="row">
          <div class="col-md-12">
            <div class="box box-success">
            <!-- form start -->
            
            <form role="form" action="/fireexting/<?php echo htmlspecialchars( $fireexting["fireexting_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" method="post" enctype="multipart/form-data">
             
              <div class="box-body">
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="daydate">Data do Dia</label>
                    <input type="text" class="form-control" id="daydate" name="daydate" value="<?php echo htmlspecialchars( $fireexting["daydate"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onChange="replaceSlash(daydate)" >
                  </div>
                </div>
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="dayhour">Hora do Dia</label>
                    <input type="text" class="form-control" id="dayhour" name="dayhour" value="<?php echo htmlspecialchars( $fireexting["dayhour"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">
                  </div>
                </div>
                
                <div class="col col-md-2">
                  <div class="form-group">
                      <label for="location_id">Localização</label>
                      <select class="form-control" name="location_id" id="location_id" required>
                        <?php $counter1=-1;  if( isset($locations) && ( is_array($locations) || $locations instanceof Traversable ) && sizeof($locations) ) foreach( $locations as $key1 => $value1 ){ $counter1++; ?>
                        <option value="<?php echo htmlspecialchars( $value1["location_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" <?php if( $value1["location_id"] == $fireexting["location_id"] ){ ?>selected<?php } ?>><?php echo htmlspecialchars( $value1["deslocation"], ENT_COMPAT, 'UTF-8', FALSE ); ?></option>
                        <?php } ?>
                      </select>
                  </div>
                </div>
                <div class="col col-md-3">
                    <div class="form-group">
                        <label for="local_id">Local</label>
                        <select class="form-control" name="local_id" id="local_id" required>
                          <?php $counter1=-1;  if( isset($locais) && ( is_array($locais) || $locais instanceof Traversable ) && sizeof($locais) ) foreach( $locais as $key1 => $value1 ){ $counter1++; ?>
                          <option value="<?php echo htmlspecialchars( $value1["local_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" <?php if( $value1["local_id"] == $fireexting["local_id"] ){ ?>selected<?php } ?>><?php echo htmlspecialchars( $value1["deslocal"], ENT_COMPAT, 'UTF-8', FALSE ); ?></option>
                          <?php } ?>
                        </select>
                    </div>
                </div>
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="tipe">Tipo</label>
                    <input type="text" class="form-control" name="tipe" maxlength="20" id="tipe" value="<?php echo htmlspecialchars( $fireexting["tipe"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(tipe)" required>
                  </div>
                </div>
              </div>
              <div class="box-body">
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="weight">Peso</label>
                    <input type="text" class="form-control" name="weight" maxlength="10" id="weight" value="<?php echo htmlspecialchars( $fireexting["weight"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(weight)" required>
                  </div>
                </div>
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="capacity">Capacidade</label>
                    <input type="text" class="form-control" name="capacity" maxlength="10" id="capacity" value="<?php echo htmlspecialchars( $fireexting["capacity"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(capacity)" required>
                  </div>
                </div>
                <div class="col col-md-2">
                  <div class="form-group">
                    <label for="rechargedate">Data de Recarga</label>
                    <input type="text" class="form-control" name="rechargedate" id="rechargedate" value="<?php echo htmlspecialchars( $fireexting["rechargedate"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onChange="replaceSlash(rechargedate)" required>
                  </div>
                </div>
               
              </div>
              <!-- /.box-body -->
              <div class="box-footer">
                <input type="submit" id="fireexting" class="btn btn-success" value="Atualizar Extintor">
                
                <a href="/fireexting?limit=10" class="btn btn-warning">Voltar</a>
                
              </div>
            </form>
          </div>
          </div>
      </div>
    
    </section>
    <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    