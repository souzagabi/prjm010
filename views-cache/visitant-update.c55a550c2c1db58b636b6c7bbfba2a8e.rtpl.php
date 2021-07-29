<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
<!-- Content Header (Page header) -->
<section class="content-header">
  <div class="box box-success title" style="background-color: #d5f8da;">
    <h4>
      Edição de Visita
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
        
        <form role="form" action="/visitant/<?php echo htmlspecialchars( $visitant["visitant_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" method="post" enctype="multipart/form-data">
       
          <div class="box-body">
            <div class="col col-md-2">
              <div class="form-group">
                <label for="dt_save">Data do Cadastro</label>
                <input type="text" class="form-control" name="dt_save" id="dt_save" value="<?php echo htmlspecialchars( $visitant["dt_save"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" autofocus="autofocus" readonly>
              </div>
              
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="situation">Situação</label>
                <select class="form-control" name="situation" id="situation">
                  <option value="0" <?php if( $visitant["situation"] == 0 ){ ?>selected<?php } ?>>ATIVO</option>
                  <option value="1" <?php if( $visitant["situation"] == 1 ){ ?>selected<?php } ?>>INATIVO</option>
                </select>
              </div>
            </div>
          </div>
          <div class="box-body">
            <div class="col col-md-4">
              <div class="form-group">
                <label for="name_person">Nome</label><strong class="obrigatorio"> *</strong>
                <input type="text" class="form-control" name="name_person" id="name_person" onkeyup="convertLowToUpper(name_person)" value="<?php echo htmlspecialchars( $visitant["name_person"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" autofocus="autofocus" required>
              </div>
              
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="rg_person">RG</label><strong class="obrigatorio"> *</strong>
                <input type="text" class="form-control" name="rg_person" id="rg_person" value="<?php echo htmlspecialchars( $visitant["rg_person"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(rg_person)" required>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="cpf_person">CPF</label>
                <input type="text" class="form-control" name="cpf_person" id="cpf_person" value="<?php echo htmlspecialchars( $visitant["cpf_person"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(rg_person)">
              </div>
            </div>
            <div class="col col-md-4">
              <div class="form-group">
                <label for="email">Email</label>
                <input type="text" class="form-control" name="email" id="email" value="<?php echo htmlspecialchars( $visitant["email"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">
              </div>
            </div>
          </div>
          <div class="box-body">
            <div class="col col-md-2">
              <div class="form-group">
                <label for="phonenumber">Telefone</label>
                <input type="text" class="form-control" name="phonenumber" id="phonenumber" value="<?php echo htmlspecialchars( $visitant["phonenumber"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">
              </div>
            </div>
            <div class="col col-md-4">
              <div class="form-group">
                <label for="company">Empresa</label><strong class="obrigatorio"> *</strong>
                <input type="text" class="form-control" name="company" id="company" value="<?php echo htmlspecialchars( $visitant["company"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onkeyup="convertLowToUpper(company)" required>
              </div>
            </div>
            <div class="col col-md-4">
              <div class="form-group">
                <label for="reason">Motivo da Visita</label><strong class="obrigatorio"> *</strong>
                <input type="text" class="form-control" name="reason" id="reason" value="<?php echo htmlspecialchars( $visitant["reason"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onkeyup="convertLowToUpper(reason)" required>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="situation">Situação</label>
                <select class="form-control" name="situation" id="situation">
                  <option value="0"<?php if( $visitant["situation"] == 0 ){ ?>selected<?php } ?>>ATIVO</option>
                  <option value="1"<?php if( $visitant["situation"] == 1 ){ ?>selected<?php } ?>>INATIVO</option>
                </select>
              </div>
            </div>
            
          </div>
          <div class="box-body">
            <div class="col col-md-1">
              <div class="form-group">
                <label for="badge">Crachá</label><strong class="obrigatorio"> *</strong>
                <select class="form-control" name="badge" id="badge" required>
                  <?php $i = 1; ?>
                  <option value=""></option>
                  <?php $counter1=-1;  if( isset($j) && ( is_array($j) || $j instanceof Traversable ) && sizeof($j) ) foreach( $j as $key1 => $value1 ){ $counter1++; ?>
                  <option value="<?php echo htmlspecialchars( $i, ENT_COMPAT, 'UTF-8', FALSE ); ?>"<?php if( $visitant["badge"] == $i ){ ?>selected<?php } ?>><?php echo htmlspecialchars( $i++, ENT_COMPAT, 'UTF-8', FALSE ); ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="auth">Autorização</label><strong class="obrigatorio"> *</strong>
                <input type="text" class="form-control" name="auth" id="auth" value="<?php echo htmlspecialchars( $visitant["auth"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onkeyup="convertLowToUpper(auth)" required>
              </div>
            </div>
            <div class="col col-md-3">
              <div class="form-group">
                <label for="sign">Assinatura</label><strong class="obrigatorio"> *</strong>
                <input type="text" class="form-control" name="sign" id="sign" value="<?php echo htmlspecialchars( $visitant["sign"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onkeyup="convertLowToUpper(sign)" required>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="daydate">Data do Dia</label>
                <input type="text" class="form-control" id="daydate" name="daydate" value="<?php echo htmlspecialchars( $visitant["daydate"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" readonly>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="dayhour">Hora do Dia</label>
                <input type="text" class="form-control" id="dayhour" name="dayhour" value="<?php echo htmlspecialchars( $visitant["dayhour"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" readonly>
              </div>
            </div>
            <div class="col col-md-2">
              <div class="form-group">
                <label for="classification_id">Classificação</label><strong class="obrigatorio"> *</strong>
                <select class="form-control" name="classification_id" id="classification_id" required>
                  <option value=""></option>
                  <?php $counter1=-1;  if( isset($classifications) && ( is_array($classifications) || $classifications instanceof Traversable ) && sizeof($classifications) ) foreach( $classifications as $key1 => $value1 ){ $counter1++; ?>
                  <option value="<?php echo htmlspecialchars( $value1["classification_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" <?php if( $visitant["classification_id"] == $value1["classification_id"] ){ ?>selected<?php } ?>><?php echo htmlspecialchars( $value1["description"], ENT_COMPAT, 'UTF-8', FALSE ); ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
          </div>
         
          <!-- /.box-body -->
          <div class="box-footer">
            <input type="submit" id="compra" class="btn btn-success" value="Atualizar Visita">
            
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
