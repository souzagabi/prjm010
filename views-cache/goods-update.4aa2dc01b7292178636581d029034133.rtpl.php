<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
<!-- Content Header (Page header) -->
<section class="content-header">
  <div class="box box-success title" style="background-color: #d5f8da;">
    <h4>
      Edição de Materiais
    </h4>
  </div>
  <ol class="breadcrumb">
    <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="/goods">Mercadoria</a></li>
    <li class="active"><a href="/goods/create">Cadastrar</a></li>
  </ol>
</section>

<!-- Main content -->
<section class="content">

  <div class="row">
  	<div class="col-md-12">
  		<div class="box box-success">
        <!-- form start -->
        
        <form role="form" action="/goods/<?php echo htmlspecialchars( $goods["goods_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" method="post" enctype="multipart/form-data">
          
          <div class="box-body">
            <div class="col col-md-2">
              <div class="form-group">
                <label for="daydate">Data do Dia</label>
                <input type="text" class="form-control" id="daydate" name="daydate" value="<?php echo htmlspecialchars( $goods["daydate"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="dayhour">Hora do Dia</label>
                <input type="text" class="form-control" id="dayhour" name="dayhour" value="<?php echo htmlspecialchars( $goods["dayhour"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">
              </div>
            </div>
            <div class="col col-md-4">
              <div class="form-group">
                <label for="goods">goods</label>
                <input type="text" class="form-control" name="goods" id="goods" value="<?php echo htmlspecialchars( $goods["goods"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(goods)" autofocus>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="qtde">Local</label>
                <input type="text" class="form-control" name="qtde" id="qtde" value="<?php echo htmlspecialchars( $goods["qtde"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(location)">
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="packing">Embalagem</label>
                <select class="form-control" name="packing" id="packing">
                  <option value="0"<?php if( $goods["packing"] == 0 ){ ?>selected<?php } ?>>UN</option>
                  <option value="1"<?php if( $goods["packing"] == 1 ){ ?>selected<?php } ?>>CX</option>
                  <option value="2"<?php if( $goods["packing"] == 2 ){ ?>selected<?php } ?>>KG</option>
                  <option value="3"<?php if( $goods["packing"] == 3 ){ ?>selected<?php } ?>>L</option>
                  <option value="4"<?php if( $goods["packing"] == 4 ){ ?>selected<?php } ?>>ML</option>
                  <option value="5"<?php if( $goods["packing"] == 5 ){ ?>selected<?php } ?>>PC</option>
                </select>
              </div>
            </div>
          </div>
          <div class="box-body">
            <div class="col col-md-4">
              <div class="form-group">
                <label for="receiver">Responsável Recebimento</label>
                <input type="text" class="form-control" name="receiver" id="receiver" value="<?php echo htmlspecialchars( $goods["receiver"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(receiver)" required>
              </div>
            </div>
            <div class="col col-md-4">
              <div class="form-group">
                <label for="deliveryman">Responsável pela Entrada</label>
                <input type="text" class="form-control" name="deliveryman" id="deliveryman" value="<?php echo htmlspecialchars( $goods["deliveryman"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(deliveryman)" required>
              </div>
            </div>
          </div>
          <!-- /.box-body -->
          <div class="box-footer">
            <input type="submit" id="compra" class="btn btn-success" value="Atualizar Mercadoria">
            
            <a href="/goods?limit=10" class="btn btn-warning">Voltar</a>
            
          </div>
        </form>
      </div>
  	</div>
  </div>

</section>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->
