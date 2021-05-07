<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
<!-- Content Header (Page header) -->
<section class="content-header">
  <div class="box box-success title" style="background-color: #d5f8da;">
    <h4>
      Cadastro de Compra de Ações
    </h4>
  </div>
  <ol class="breadcrumb">
    <li><a href="/acoes"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="/acoes">Ação</a></li>
    <li class="active"><a href="/acoes/create">Cadastrar</a></li>
  </ol>
</section>

<!-- Main content -->
<section class="content">

  <div class="row">
  	<div class="col-md-12">
  		<div class="box box-success">
        <div class="box-header with-border">
          <h3 class="box-title">Nova Ação</h3>
        </div>
        <!-- /.box-header -->
        <!-- form start -->
        
        <form role="form" action="/acoes/create" method="post">
          <div class="box-body">
            <div class="col col-md-2">
              <div class="form-group">
                <label for="desperson">Empresa</label>
                <input type="text" class="form-control" name="desperson" id="desperson" onKeyUp="convertLowToUpper(desperson)" autofocus="autofocus">
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="sgcompany">Sigla</label>
                <input type="text" class="form-control" name="sgcompany" id="sgcompany" onKeyUp="convertLowToUpper(sgcompany)" required>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="descnpj">CPF/CNPJ</label>
                <input type="text" class="form-control" name="descnpj" id="descnpj">
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="tipe">Tipo</label>
                <select class="form-control" name="tipe" id="tipe">
                  <option value="1" selected>Swing Trade</option>
                  <option value="2">Day Trade</option>
                </select>
              </div>
            </div>
          </div>
          <div class="box-body">
            <div class="col col-md-2">
              <div class="form-group">
                <label for="dtbuy">Data Compra</label>
                <input type="text" class="form-control" name="dtbuy" id="dtbuy" onChange="replaceSlash(dtbuy)" required>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="qtdebuy">Qtde</label>
                <input type="text" class="form-control" name="qtdebuy" id="qtdebuy" onChange="sumTotal(qtdebuy.value, prcbuy, tlbuy)" required>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="prcbuy">Valor Compra</label>
                <input type="text" class="form-control" name="prcbuy" id="prcbuy" onChange="sumTotal(qtdebuy.value, prcbuy, tlbuy);" required>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="tlbuy">Total Compra</label>
                <input type="text" class="form-control" id="tlbuy" name="tlbuy" readonly>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="prcaverage">Valor Médio</label>
                <input type="text" class="form-control" id="prcaverage" name="prcaverage" readonly>
              </div>
            </div>
          </div>
          
          <!-- /.box-body -->
          <div class="box-footer">
            <input type="submit"name="compra" class="btn btn-success" value="Cadastrar Compra">
            <?php $counter1=-1;  if( isset($voltar) && ( is_array($voltar) || $voltar instanceof Traversable ) && sizeof($voltar) ) foreach( $voltar as $key1 => $value1 ){ $counter1++; ?>
            <a href="/<?php echo htmlspecialchars( $voltar["voltar"], ENT_COMPAT, 'UTF-8', FALSE ); ?>?limit=10" class="btn btn-warning">Voltar</a>
            <?php } ?>
          </div>
        </form>
      </div>
  	</div>
  </div>

</section>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->