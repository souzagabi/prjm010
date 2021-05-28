<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
<!-- Content Header (Page header) -->
<section class="content-header">
  <div class="box box-success title" style="background-color: #d5f8da;">
    <h4>
      Cadastro de Materiais
    </h4>
  </div>
  <ol class="breadcrumb">
    <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="/material">Visitas</a></li>
    <li class="active"><a href="/material/create">Cadastrar</a></li>
  </ol>
</section>

<!-- Main content -->
<section class="content">

  <div class="row">
  	<div class="col-md-12">
      <div id="<?php if( $msg["state"] == 'SUCCESS'  ){ ?>msg-success<?php } ?>" class="box box-success" <?php if( $msg["state"] != 'SUCCESS'  ){ ?>readonly hidden<?php } ?>>
        <div class="msg"><input type="text" class="form-control <?php if( $msg["state"] == 'SUCCESS'  ){ ?>alert-success<?php }else{ ?>alert-danger<?php } ?>" name="msg" id="msg" value="<?php if( $msg["state"] == 'SUCCESS'  ){ ?><?php echo htmlspecialchars( $msg["msg"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?>" ></div>
      </div>
  		<div class="box box-success">
        <!-- form start -->
        
        <form role="form" action="/material/create" method="post" enctype="multipart/form-data">
         
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
                <label for="dayhour">Hora do Dia</label>
                <?php $counter1=-1;  if( isset($hour) && ( is_array($hour) || $hour instanceof Traversable ) && sizeof($hour) ) foreach( $hour as $key1 => $value1 ){ $counter1++; ?>
                <input type="text" class="form-control" id="dayhour" name="dayhour" value="<?php echo htmlspecialchars( $hour["hour"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">
                <?php } ?>
              </div>
            </div>
            
            <div class="col col-md-4">
              <div class="form-group">
                <label for="material">Material</label>
                <input type="text" class="form-control" name="material" id="material" onKeyUp="convertLowToUpper(material)" autofocus="autofocus" required>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="qtde">Quantidade</label>
                <input type="number" class="form-control" name="qtde" id="qtde" required>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="packing">Embalagem</label>
                <select class="form-control" name="packing" id="packing">
                  <option value="0" selected>UN</option>
                  <option value="1">CX</option>
                  <option value="2">KG</option>
                  <option value="3">L</option>
                  <option value="4">ML</option>
                  <option value="5">PC</option>
                </select>
              </div>
            </div>
          </div>
          <div class="box-body">
            <div class="col col-md-4">
              <div class="form-group">
                <label for="receiver">Responsável Recebimento</label>
                <input type="text" class="form-control" name="receiver" id="receiver" onKeyUp="convertLowToUpper(receiver)" required>
              </div>
            </div>
            <div class="col col-md-4">
              <div class="form-group">
                <label for="deliveryman">Entregador</label>
                <input type="text" class="form-control" name="deliveryman" id="deliveryman" onKeyUp="convertLowToUpper(deliveryman)" required>
              </div>
            </div>
           
          </div>
          <!-- /.box-body -->
          <div class="box-footer">
            <input type="submit" id="material" class="btn btn-success" value="Cadastrar Material">
            
            <a href="/material?limit=10" class="btn btn-warning">Voltar</a>
            
          </div>
        </form>
      </div>
  	</div>
  </div>

</section>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->
