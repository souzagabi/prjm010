<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="box box-success title" style="background-color: #d5f8da;">
        <h4>
          Edição de Materiais
        </h4>
      </div>
      <ol class="breadcrumb">
        <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="/clothing">Resíduos</a></li>
        <li class="active"><a href="/clothing/create">Cadastrar</a></li>
      </ol>
    </section>
    
    <!-- Main content -->
    <section class="content">
    
      <div class="row">
          <div class="col-md-12">
              <div class="box box-success">
            <!-- form start -->
            
            <form role="form" action="/clothing/<?php echo htmlspecialchars( $clothing["clothing_id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" method="post" enctype="multipart/form-data">
              
                <div class="box-body">
                    <div class="col col-md-2">
                      <div class="form-group">
                        <label for="dateout">Data da Retirada</label>
                        <input type="text" class="form-control" id="dateout" name="dateout" value="<?php echo htmlspecialchars( $clothing["dateout"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onChange="replaceSlash(dateout)" >
                      </div>
                    </div>
                    <div class="col col-md-2">
                      <div class="form-group">
                        <label for="qtdeout">Qtde de Saída</label>
                        <input type="text" class="form-control" id="qtdeout" name="qtdeout" value="<?php echo htmlspecialchars( $clothing["qtdeout"], ENT_COMPAT, 'UTF-8', FALSE ); ?>">
                      </div>
                    </div>
                    <div class="col col-md-8">
                      <div class="form-group">
                        <label for="signout">Assinatura da Empresa</label>
                        <input type="text" class="form-control" id="signout" name="signout" value="<?php echo htmlspecialchars( $clothing["signout"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(signout)">
                      </div>
                    </div>
                  </div>
                  <div class="box-body">
                    <div class="col col-md-2">
                      <div class="form-group">
                        <label for="datein">Data de Entrada</label>
                        <input type="text" class="form-control" id="datein" name="datein" value="<?php echo htmlspecialchars( $clothing["datein"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onChange="replaceSlash(datein)">
                      </div>
                    </div>
                    
                    <div class="col col-md-2">
                        <div class="form-group">
                          <label for="qtdein">Qtde de Entrada</label>
                          <input type="text" class="form-control" id="qtdein" value="<?php echo htmlspecialchars( $clothing["qtdein"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" name="qtdein">
                        </div>
                      </div>
                      <div class="col col-md-8">
                        <div class="form-group">
                          <label for="signin">Assinatura da Empresa</label>
                          <input type="text" class="form-control" id="signin" name="signin" value="<?php echo htmlspecialchars( $clothing["signin"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" onKeyUp="convertLowToUpper(signin)">
                        </div>
                      </div>
                  
                  </div>
              <!-- /.box-body -->
              <div class="box-footer">
                <input type="submit" id="compra" class="btn btn-success" value="Atualizar Roupa">
                
                <a href="/clothing?limit=10" class="btn btn-warning">Voltar</a>
                
              </div>
            </form>
          </div>
          </div>
      </div>
    
    </section>
    <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    