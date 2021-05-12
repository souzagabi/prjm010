<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
<!-- Content Header (Page header) -->
<section class="content-header">
  <div class="box box-success title" style="background-color: #d5f8da;">
    <h4>
      Cadastro Visita
    </h4>
  </div>
  <ol class="breadcrumb">
    <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="/visitant">Visitas</a></li>
    <li class="active"><a href="/visitant/create">Cadastrar</a></li>
  </ol>
</section>

<!-- Main content -->
<section class="content">

  <div class="row">
  	<div class="col-md-12">
  		<div class="box box-success">
        <!-- form start -->
        
        <form role="form" action="/visitant/create" method="post">
          <div class="box-body">
            <div class="col col-md-2">
              <div class="form-group">
                <label for="name_person">Nome</label>
                <input type="text" class="form-control" name="name_person" id="name_person" onkeyup="convertLowToUpper(name_person)" autofocus="autofocus" required>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="rg_person">RG</label>
                <input type="text" class="form-control" name="rg_person" id="rg_person" onKeyUp="convertLowToUpper(rg_person)" required>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="phonenumber">Telefone</label>
                <input type="text" class="form-control" name="phonenumber" id="phonenumber">
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="company">Empresa</label>
                <input type="text" class="form-control" name="company" id="company" onkeyup="convertLowToUpper(company)" >
              </div>
            </div>
            <div class="col col-md-4">
              <div class="form-group">
                <label for="reason">Motivo da Visita</label>
                <input type="text" class="form-control" name="reason" id="reason">
              </div>
            </div>
            
          </div>
          <div class="box-body">
            <div class="col col-md-1">
              <div class="form-group">
                <label for="badge">Crachá</label>
                <select class="form-control" name="badge" id="badge">
                  <?php $i = 1; ?>
                  <option value=""></option>
                  <?php $counter1=-1;  if( isset($j) && ( is_array($j) || $j instanceof Traversable ) && sizeof($j) ) foreach( $j as $key1 => $value1 ){ $counter1++; ?>
                  <option value="<?php echo htmlspecialchars( $i, ENT_COMPAT, 'UTF-8', FALSE ); ?>"><?php echo htmlspecialchars( $i++, ENT_COMPAT, 'UTF-8', FALSE ); ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="auth">Autorização</label>
                <input type="text" class="form-control" name="auth" id="auth" required>
              </div>
            </div>
            <div class="col col-md-3">
              <div class="form-group">
                <label for="sign">Assinatura</label>
                <input type="text" class="form-control" name="sign" id="sign" required>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="daydate">Data do Dia</label>
                <?php $counter1=-1;  if( isset($date) && ( is_array($date) || $date instanceof Traversable ) && sizeof($date) ) foreach( $date as $key1 => $value1 ){ $counter1++; ?>
                <input type="text" class="form-control" id="daydate" name="daydate" value="<?php echo htmlspecialchars( $date["date"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" readonly>
                <?php } ?>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="dayhour">Hora do Dia</label>
                <?php $counter1=-1;  if( isset($hour) && ( is_array($hour) || $hour instanceof Traversable ) && sizeof($hour) ) foreach( $hour as $key1 => $value1 ){ $counter1++; ?>
                <input type="text" class="form-control" id="dayhour" name="dayhour" value="<?php echo htmlspecialchars( $hour["hour"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" readonly>
                <?php } ?>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="classification">Classificação</label>
                <select class="form-control" name="classification" id="classification">
                  <option value=""></option>
                  <?php $counter1=-1;  if( isset($classifications) && ( is_array($classifications) || $classifications instanceof Traversable ) && sizeof($classifications) ) foreach( $classifications as $key1 => $value1 ){ $counter1++; ?>
                  <option value="<?php echo htmlspecialchars( $value1["classification_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>"><?php echo htmlspecialchars( $value1["description"], ENT_COMPAT, 'UTF-8', FALSE ); ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
          </div>
          
          <!-- /.box-body -->
          <div class="box-footer">
            <input type="submit" id="compra" class="btn btn-success" value="Cadastrar Compra">
            
            <a href="/visitant?limit=10" class="btn btn-warning">Voltar</a>
            
          </div>
        </form>
      </div>
  	</div>
  </div>

</section>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->
