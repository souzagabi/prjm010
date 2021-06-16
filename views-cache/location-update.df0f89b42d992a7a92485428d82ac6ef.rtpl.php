<?php if(!class_exists('Rain\Tpl')){exit;}?><div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Edição de Localidade
        </h1>
        <ol class="breadcrumb">
            <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="/location">Localidade</a></li>
            <li class="active">Edição</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <div id="msgDanger" name="msgDanger"  class="alert-danger box box-danger" style="display: none;">
            <div>
            <div id="msgError" name="msgError" class="msgError"></div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="box box-success">
                    <!-- form start -->
                    <form role="form" action="/location/<?php echo htmlspecialchars( $location["location_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" method="post">
                        <div class="box-body">
                            <div class="col col-md-4">
                                <div class="form-group">
                                <label for="deslocation">Nome</label>
                                <input type="text" class="form-control" name="deslocation" id="deslocation" value="<?php echo htmlspecialchars( $location["deslocation"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onkeyup="convertLowToUpper(name_person)" autofocus="autofocus" required>
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                            <button type="submit" id="btnSubmit" class="btn btn-success">Atualizar</button>
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
