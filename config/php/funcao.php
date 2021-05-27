<?php
// Função para converter base64 em imagem
    function converter_base64_para_imagem( $codigo_base64, $caminho, $nome_imagem = null ) {
        if ( !empty($codigo_base64) && !empty($caminho) ) :
            
            // Separa a string em array
            $array_string = explode( ";base64,", $codigo_base64);
            
            // Divide a posição ZERO do array em outro array
            $tipo_imagem = explode( "image/", $array_string[0] );
            
            // Pega o tipo de imagem
            $tipo_img = $tipo_imagem[1];
            
            // Cria o caminho onde vai salvar a imagem
            $diretorio = $caminho.md5(uniqid()).'.'.$tipo_img;
    
            // Verifica se a variável está vazia e atribui um nome
            if ( !empty($nome_imagem) ) :
                $diretorio = $caminho.'/'.$nome_imagem.'.'.$tipo_img;
            endif;
    
            // Decodifica a imagem
            $imagem_decodificada = base64_decode( $array_string[1] );
            
            if(!file_exists($diretorio)){
                // Salva a imagem no diretório
                file_put_contents( $diretorio, $imagem_decodificada );
             }

        endif;
    
    }
    function passwordVerity($passUser)
    {
        alert("teste");
        if (password_verify($passUser, $data["pass"]) === true) {
                       
            return true;
        } else{
            return false;
        }
    }

?>
