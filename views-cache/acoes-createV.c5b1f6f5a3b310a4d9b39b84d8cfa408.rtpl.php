<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
<!-- Content Header (Page header) -->
<section class="content-header">
  <div class="box box-danger title" style="background-color: #f8dad5;">
    <h4>
      Cadastro de Venda de Ações
    </h4>
  </div>
  <ol class="breadcrumb">
    <li><a href="/acoes"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="/acoes">Ação</a></li>
    <li class="active"><a href="/acoes/createV">Cadastrar</a></li>
  </ol>
</section>

<!-- Main content -->
<section class="content">

  <div class="row">
  	<div class="col-md-12">
  		<div class="box box-danger">
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
            <!-- <div class="col col-md-2">
              <div class="form-group">
                <label for="descnpj">CPF/CNPJ</label>
                <input type="text" class="form-control" name="descnpj" id="descnpj">
              </div>
            </div> -->
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
                <label for="dtsell">Data Venda</label>
                <input type="text" class="form-control" name="dtsell" id="dtsell" onChange="replaceSlash(dtsell)">
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="qtdesell">Qtde</label>
                <input type="text" class="form-control" name="qtdesell" id="qtdesell" onChange="sumTotal(qtdesell.value, prcsell, tlsell)">
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="prcsell">Valor Venda</label>
                <input type="text" class="form-control" name="prcsell" id="prcsell" onChange="sumTotal(qtdesell.value, prcsell, tlsell)">
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="tlsell">Total Venda</label>
                <input type="text" class="form-control" id="tlsell" name="tlsell" readonly>
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
            <input type="submit"name="venda" class="btn btn-success" value="Cadastrar Venda">

            <!-- <button type="submit" name="Venda" class="btn btn-success">Cadastrar Venda</button> -->
            <?php $counter1=-1;  if( isset($voltar) && ( is_array($voltar) || $voltar instanceof Traversable ) && sizeof($voltar) ) foreach( $voltar as $key1 => $value1 ){ $counter1++; ?>
            <a href="/<?php echo htmlspecialchars( $voltar["voltar"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" class="btn btn-warning">Voltar</a>
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