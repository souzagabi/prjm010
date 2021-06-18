<?php if(!class_exists('Rain\Tpl')){exit;}?><div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Edição de Responsável
        </h1>
        <ol class="breadcrumb">
            <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="/responsable">Responsável</a></li>
            <li class="active">Edição</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box box-success">
                    <!-- form start -->
                    <form role="form" action="/responsable/<?php echo htmlspecialchars( $responsable["person_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" method="post">
                        <div class="box-body">
                            <div class="col col-md-3">
                                <div class="form-group">
                                <label for="name_person">Nome</label>
                                <input type="text" class="form-control" name="name_person" id="name_person" value="<?php echo htmlspecialchars( $responsable["name_person"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onkeyup="convertLowToUpper(name_person)" autofocus="autofocus" required>
                                </div>
                            </div>
                            <div class="col col-md-2">
                                <div class="form-group">
                                <label for="rg_person">RG</label>
                                <input type="text" class="form-control" name="rg_person" id="rg_person" value="<?php echo htmlspecialchars( $responsable["rg_person"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(rg_person)">
                                </div>
                            </div>
                            <div class="col col-md-2">
                                <div class="form-group">
                                <label for="cpf_person">CPF</label>
                                <input type="text" class="form-control" name="cpf_person" id="cpf_person" value="<?php echo htmlspecialchars( $responsable["cpf_person"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(cpf_person)">
                                </div>
                            </div>
                            <div class="col col-md-2">
                                <div class="form-group">
                                <label for="phonenumber">Telefone</label>
                                <input type="text" class="form-control" name="phonenumber" id="phonenumber" value="<?php echo htmlspecialchars( $responsable["phonenumber"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">
                                </div>
                            </div>
                            <div class="col col-md-3">
                                <div class="form-group">
                                  <label for="classification_id">Classificação</label>
                                  <select class="form-control" name="classification_id" id="classification_id">
                                    <?php $counter1=-1;  if( isset($classifications) && ( is_array($classifications) || $classifications instanceof Traversable ) && sizeof($classifications) ) foreach( $classifications as $key1 => $value1 ){ $counter1++; ?>
                                    <?php if( $value1["classification_id"] == 5 ){ ?>
                                    <option value="<?php echo htmlspecialchars( $value1["classification_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" <?php if( $responsable["classification_id"] == $value1["classification_id"] ){ ?>selected<?php } ?>><?php echo htmlspecialchars( $value1["description"], ENT_COMPAT, 'UTF-8', FALSE ); ?></option>
                                    <?php } ?>
                                    <?php } ?>
                                  </select>
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                            <button type="submit" id="btnSubmit" class="btn btn-success">Atualizar</button>
                            <a href="/responsable?limit=10" class="btn btn-warning">Voltar</a>

                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->
