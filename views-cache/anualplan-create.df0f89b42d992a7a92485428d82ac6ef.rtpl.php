<?php if(!class_exists('Rain\Tpl')){exit;}?><div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Cadastro de Plano Anual de Manutenção
        </h1>
        <ol class="breadcrumb">
            <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="/anualplan">Plano Anual de Manutenção</a></li>
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
         <!-- form start -->
         <form role="form" action="/anualplan/create" method="post">
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-success">
                       <div class="box-body">
                            <div class="col col-md-2">
                                <div class="form-group">
                                <label for="yyear">Ano</label>
                                <input type="text" class="form-control" name="yyear" id="yyear" autofocus="autofocus" required>
                                </div>
                            </div>
                            <div class="col col-md-3">
                                <div class="form-group">
                                    <label for="equipament_id">Equipamento</label>
                                    <select class="form-control" name="equipament_id" id="equipament_id" required>
                                    <option value=""></option>
                                    <?php $counter1=-1;  if( isset($equipaments) && ( is_array($equipaments) || $equipaments instanceof Traversable ) && sizeof($equipaments) ) foreach( $equipaments as $key1 => $value1 ){ $counter1++; ?>
                                    <option value="<?php echo htmlspecialchars( $value1["equipament_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>"><?php echo htmlspecialchars( $value1["desequipament"], ENT_COMPAT, 'UTF-8', FALSE ); ?></option>
                                    <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="col col-md-3">
                                <div class="form-group">
                                    <label for="location_id">Localização</label>
                                    <select class="form-control" name="location_id" id="location_id" required>
                                    <option value=""></option>
                                    <?php $counter1=-1;  if( isset($locations) && ( is_array($locations) || $locations instanceof Traversable ) && sizeof($locations) ) foreach( $locations as $key1 => $value1 ){ $counter1++; ?>
                                    <option value="<?php echo htmlspecialchars( $value1["location_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>"><?php echo htmlspecialchars( $value1["deslocation"], ENT_COMPAT, 'UTF-8', FALSE ); ?></option>
                                    <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="col col-md-3">
                                <div class="form-group">
                                    <label for="person_id">Responsável</label>
                                    <select class="form-control" name="person_id" id="person_id" required>
                                    <option value=""></option>
                                    <?php $counter1=-1;  if( isset($responsables) && ( is_array($responsables) || $responsables instanceof Traversable ) && sizeof($responsables) ) foreach( $responsables as $key1 => $value1 ){ $counter1++; ?>
                                    <option value="<?php echo htmlspecialchars( $value1["person_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>"><?php echo htmlspecialchars( $value1["responsable"], ENT_COMPAT, 'UTF-8', FALSE ); ?></option>
                                    <?php } ?>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                            <button type="submit" id="btnSubmit" class="btn btn-success">Cadastrar</button>
                            <a href="/anualplan?limit=10" class="btn btn-warning">Voltar</a>

                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col col-md-12">
                    <div class="box box-success">
                        <div class="box-body">
                            <div class="col col-md-2">
                                <div class="form-group"> 
                                <label for="jan">Janeiro</label>
                                <input type="text" class="form-control" name="jan" id="jan" onblur="insertcolor(jan)" onkeyup="replaceSlash(jan)">
                                </div>
                            </div>
                            <div class="col col-md-1">
                                <div class="form-group"> 
                                <label for="rjan">Execução</label>
                                <input type="radio" name="rjan" id="rjan" value="0" onblur="insertcolor(rjan)"> SIM&nbsp;&nbsp;&nbsp;
                                <input type="radio" name="rjan" id="rjan" value="1" onblur="insertcolor(rjan)"> NÃO
                                </div>
                            </div>
                            <div class="col col-md-2">
                                <div class="form-group">
                                <label for="fev">Fevereiro</label>
                                <input type="text" class="form-control" name="fev" id="fev" onkeyup="replaceSlash(fev)" >
                                </div>
                            </div>
                            <div class="col col-md-2">
                                <div class="form-group">
                                <label for="mar">Março</label>
                                <input type="text" class="form-control" name="mar" id="mar" onkeyup="replaceSlash(mar)" >
                                </div>
                            </div>
                            <div class="col col-md-2">
                                <div class="form-group">
                                <label for="apr">Abril</label>
                                <input type="text" class="form-control" name="apr" id="apr" onkeyup="replaceSlash(apr)" >
                                </div>
                            </div>
                            <div class="col col-md-2">
                                <div class="form-group">
                                <label for="may">Maio</label>
                                <input type="text" class="form-control" name="may" id="may" onkeyup="replaceSlash(may)" >
                                </div>
                            </div>
                            <div class="col col-md-2">
                                <div class="form-group">
                                <label for="jun">Junho</label>
                                <input type="text" class="form-control" name="jun" id="jun" onkeyup="replaceSlash(jun)" >
                                </div>
                            </div>
                        </div>
                        <div class="box-body">
                            <div class="col col-md-2">
                                <div class="form-group">
                                <label for="jul">Julho</label>
                                <input type="text" class="form-control" name="jul" id="jul" onkeyup="replaceSlash(jul)" >
                                </div>
                            </div>
                            <div class="col col-md-2">
                                <div class="form-group">
                                <label for="aug">Agosto</label>
                                <input type="text" class="form-control" name="aug" id="aug" onkeyup="replaceSlash(aug)" >
                                </div>
                            </div>
                            <div class="col col-md-2">
                                <div class="form-group">
                                <label for="sep">Setembro</label>
                                <input type="text" class="form-control" name="sep" id="sep" onkeyup="replaceSlash(sep)" >
                                </div>
                            </div>
                            <div class="col col-md-2">
                                <div class="form-group">
                                <label for="oct">Outubro</label>
                                <input type="text" class="form-control" name="oct" id="oct" onkeyup="replaceSlash(oct)" >
                                </div>
                            </div>
                            <div class="col col-md-2">
                                <div class="form-group">
                                <label for="nov">Novembro</label>
                                <input type="text" class="form-control" name="nov" id="nov" onkeyup="replaceSlash(nov)" >
                                </div>
                            </div>
                            <div class="col col-md-2">
                                <div class="form-group">
                                <label for="dec">Dezembro</label>
                                <input type="text" class="form-control" name="dec" id="dec" onkeyup="replaceSlash(dec)" >
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </section>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->
