<?php if(!class_exists('Rain\Tpl')){exit;}?><div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Cadastro de Responsável
        </h1>
        <ol class="breadcrumb">
            <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="/responsable">Responsável</a></li>
            <li class="active">Cadastrar</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <div id="msg<?php if( $msg["state"] == 'SUCCESS' ){ ?>-success<?php }else{ ?>-danger<?php } ?>" 
            class="box box-<?php if( $msg["state"] == 'SUCCESS' ){ ?>-success<?php }else{ ?>danger<?php } ?>" 
            <?php if( $msg["state"] != 'SUCCESS' && $msg["state"] != 'ERROR' ){ ?>readonly hidden<?php } ?>>
            <div class="msg"><input type="text" class="form-control msg-<?php if( $msg["state"] == 'SUCCESS'  ){ ?>success alert-success<?php }else{ ?>danger alert-danger<?php } ?>" name="msg" value="<?php echo htmlspecialchars( $msg["msg"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" ></div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="box box-success">
                    <!-- form start -->
                    <form role="form" action="/responsable/create" method="post">
                        <div class="box-body">
                            <div class="col col-md-3">
                                <div class="form-group">
                                <label for="name_person">Nome</label>
                                <input type="text" class="form-control" name="name_person" id="name_person" onkeyup="convertLowToUpper(name_person)" autofocus="autofocus" required>
                                </div>
                            </div>
                            <div class="col col-md-2">
                                <div class="form-group">
                                <label for="rg_person">RG</label>
                                <input type="text" class="form-control" name="rg_person" id="rg_person" onKeyUp="convertLowToUpper(rg_person)">
                                </div>
                            </div>
                            <div class="col col-md-2">
                                <div class="form-group">
                                <label for="cpf_person">CPF</label>
                                <input type="text" class="form-control" name="cpf_person" id="cpf_person" onKeyUp="convertLowToUpper(cpf_person)">
                                </div>
                            </div>
                            <div class="col col-md-2">
                                <div class="form-group">
                                <label for="phonenumber">Telefone</label>
                                <input type="text" class="form-control" name="phonenumber" id="phonenumber">
                                </div>
                            </div>
                            <div class="col col-md-3">
                                <div class="form-group">
                                  <label for="classification_id">Classificação</label>
                                  <select class="form-control" name="classification_id" id="classification_id">
                                    <?php $counter1=-1;  if( isset($classifications) && ( is_array($classifications) || $classifications instanceof Traversable ) && sizeof($classifications) ) foreach( $classifications as $key1 => $value1 ){ $counter1++; ?>
                                    <option value="<?php echo htmlspecialchars( $value1["classification_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" <?php if( $value1["classification_id"] == 5 ){ ?>selected<?php } ?>><?php echo htmlspecialchars( $value1["description"], ENT_COMPAT, 'UTF-8', FALSE ); ?></option>
                                    <?php } ?>
                                  </select>
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                            <button type="submit" id="btnSubmit" class="btn btn-success">Cadastrar</button>
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
