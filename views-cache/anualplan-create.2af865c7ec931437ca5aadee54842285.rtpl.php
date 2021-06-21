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
                            <div class="row">
                                <div class="col col-md-2">
                                    <div class="form-group"> 
                                        <label for="jan">LEGENDA</label>
                                    </div>
                                </div>
                                <div class="col col-md-2">
                                    <div class="form-group"> 
                                        <label>Antecipado</label>
                                        <div class="antecipado">&nbsp;&nbsp;&nbsp;&nbsp;</div>
                                    </div>
                                </div>
                                <div class="col col-md-2">
                                    <div class="form-group"> 
                                        <label>Programado</label>
                                        <div class="programado">&nbsp;&nbsp;&nbsp;&nbsp;</div>
                                    </div>
                                </div>
                                <div class="col col-md-2">
                                    <div class="form-group"> 
                                        <label>Efetuado</label>
                                        <div class="efetuado">&nbsp;&nbsp;&nbsp;&nbsp;</div>
                                    </div>
                                </div>
                                <div class="col col-md-2">
                                    <div class="form-group"> 
                                        <label>Atrasado</label>
                                        <div class="atrasado">&nbsp;&nbsp;&nbsp;&nbsp;</div>
                                    </div>
                                </div>
                                <div class="col col-md-2">
                                    <div class="form-group"> 
                                        <label>Não Executado</label>
                                        <div class="naoexecutou">&nbsp;&nbsp;&nbsp;&nbsp;</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
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
                        
                        <div class="box-body">
                            <div class="col col-md-3">
                                <div class="form-group">
                                    <label for="frequency">Frequência</label>
                                    <input type="text" class="form-control" name="frequency" id="frequency" onkeyup="convertLowToUpper(frequency)" >
                                </div>
                            </div>
                            <div class="col col-md-2">
                                <div class="form-group"> 
                                    <label for="amonth">Mês</label>
                                    <select class="form-control" name="amonth" id="amonth" required>
                                        <option value="1">Janeiro</option>
                                        <option value="2">Fevereiro</option>
                                        <option value="3">Março</option>
                                        <option value="4">Abril</option>
                                        <option value="5">Maio</option>
                                        <option value="6">Junho</option>
                                        <option value="7">Julho</option>
                                        <option value="8">Agosto</option>
                                        <option value="9">Setembro</option>
                                        <option value="10">Outubro</option>
                                        <option value="11">Novembro</option>
                                        <option value="12">Dezembro</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col col-md-2">
                                <div class="form-group">
                                    <label for="dtprevision">Data Previsão</label>
                                    <input type="text" class="form-control" name="dtprevision" id="dtprevision" onkeyup="replaceSlash(dtprevision)" >
                                </div>
                            </div>
                            <div class="col col-md-5">
                                <div class="form-group"> 
                                    <div class="col col-md-2">
                                        <label for="rstatus">Execução</label>
                                    </div>
                                    <div class="col col-md-4">
                                        <input type="radio" name="rstatus" id="rstatus" value="0" onclick="insertcolor(dtprevision,rstatus)"> Programado
                                    </div>
                                    <div class="col col-md-3">
                                        <input type="radio" name="rstatus" id="rstatus" value="1" onclick="insertcolor(dtprevision,rstatus)"> SIM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    </div>
                                    <div class="col col-md-3">
                                        <input type="radio" name="rstatus" id="rstatus" value="2" onclick="insertcolor(dtprevision,rstatus)"> NÃO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    </div>
                                </div>
                            </div>
                            
                        </div>
                        <div class="row">&nbsp;</div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col col-md-12">
                    <div class="box box-primary">
                        <div class="box-footer">
                            <div class="row">
                                <div class="col col-md-2">
                                    <button type="submit" id="btnSubmit" class="btn btn-success">Cadastrar</button>
                                    <a href="/anualplan?limit=10" class="btn btn-warning">Voltar</a>
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
