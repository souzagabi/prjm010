<?php if(!class_exists('Rain\Tpl')){exit;}?><div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Cadastro de Localidade
        </h1>
        <ol class="breadcrumb">
            <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="/location">Localidade</a></li>
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
                    <form role="form" action="/location/create" method="post">
                        <div class="box-body">
                            <div class="col col-md-4">
                                <div class="form-group">
                                <label for="deslocation">Localidade</label>
                                <input type="text" class="form-control" name="deslocation" id="deslocation" onkeyup="convertLowToUpper(deslocation)" autofocus="autofocus" required>
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                            <button type="submit" id="btnSubmit" class="btn btn-success">Cadastrar</button>
                            <a href="/location?limit=10" class="btn btn-warning">Voltar</a>

                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->
