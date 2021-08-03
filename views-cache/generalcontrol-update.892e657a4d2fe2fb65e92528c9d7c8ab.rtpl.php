<?php if(!class_exists('Rain\Tpl')){exit;}?><div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Edição de Controle Geral
        </h1>
        <ol class="breadcrumb">
            <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
            <li>Controle Geral></li>
            <li class="active">Edição</li>
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
                    <form role="form" action="/generalcontrol/create" method="post">
                        <div class="box-body">
                            <div class="col col-md-2">
                                <div class="form-group">
                                    <label for="location_id">Localização</label>
                                    <select class="form-control" name="location_id" id="location_id" required>
                                      <?php $counter1=-1;  if( isset($locations) && ( is_array($locations) || $locations instanceof Traversable ) && sizeof($locations) ) foreach( $locations as $key1 => $value1 ){ $counter1++; ?>
                                      <option value="<?php echo htmlspecialchars( $value1["location_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" <?php if( $value1["location_id"] == $value1["location_id"] ){ ?>selected<?php } ?>><?php echo htmlspecialchars( $value1["deslocation"], ENT_COMPAT, 'UTF-8', FALSE ); ?></option>
                                      <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="col col-md-3">
                                <div class="form-group">
                                    <label for="local_id">Local</label>
                                    <select class="form-control" name="local_id" id="local_id" required>
                                      <?php $counter1=-1;  if( isset($locais) && ( is_array($locais) || $locais instanceof Traversable ) && sizeof($locais) ) foreach( $locais as $key1 => $value1 ){ $counter1++; ?>
                                      <option value="<?php echo htmlspecialchars( $value1["local_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" <?php if( $value1["local_id"] == $value1["local_id"] ){ ?>selected<?php } ?>><?php echo htmlspecialchars( $value1["deslocal"], ENT_COMPAT, 'UTF-8', FALSE ); ?></option>
                                      <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="col col-md-3">
                                <div class="form-group">
                                    <label for="dthydraulic">Hidráulica</label>
                                    <input type="text" class="form-control" id="dthydraulic" name="dthydraulic" value="<?php echo htmlspecialchars( $generalcontrol["dthydraulic"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onChange="replaceSlash(dthydraulic)" >
                                </div>
                            </div>
                            <div class="col col-md-2">
                                <div class="form-group">
                                    <label for="dteletric">Elétrica</label>
                                    <input type="text" class="form-control" id="dteletric" name="dteletric" value="<?php echo htmlspecialchars( $generalcontrol["dteletric"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onChange="replaceSlash(dteletric)" >
                                </div>
                            </div>
                            <div class="col col-md-2">
                                <div class="form-group">
                                    <label for="dtbuilding">Predial</label>
                                    <input type="text" class="form-control" id="dtbuilding" name="dtbuilding" value="<?php echo htmlspecialchars( $generalcontrol["dtbuilding"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onChange="replaceSlash(dtbuilding)" >
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                            <button type="submit" id="btnSubmit" class="btn btn-success">Atualizar</button>
                            <a href="/generalcontrol?limit=10" class="btn btn-warning">Voltar</a>

                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->
