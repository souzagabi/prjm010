<?php 
	session_start();
	require_once("vendor/autoload.php");

	use \Slim\Slim;
	use \PRJM010\Page;
	use \PRJM010\PageAdmin;
	use \PRJM010\PageUser;
	use \PRJM010\PageVisitant;
	use \PRJM010\PageResidual;
	use \PRJM010\PageMaterial;
	use \PRJM010\PageNobreak;
	use \PRJM010\PageFireExting;
	use \PRJM010\PageHistoricE;
	use \PRJM010\Model\User;
	use \PRJM010\Model\Visitant;
	use \PRJM010\Model\Residual;
	use \PRJM010\Model\Material;
	use \PRJM010\Model\Metodo;
	use \PRJM010\Model\Nobreak;
	use \PRJM010\Model\FireExting;
	use \PRJM010\Model\HistoricE;

	include_once("./config/php/funcao.php");

	date_default_timezone_set('America/Sao_Paulo');	
	
	$app = new Slim();

	$app->config('debug', true);

/*======================================================================================*/
/*										Rotas dos Visitants								*/
/*======================================================================================*/
	$app->get('/', function() {
		User::verifyLogin();
		$company["name_person"]	= NULL;
		$company["date_save"] 	= NULL;
		$company["date_fim"] 	= NULL;
		$company["visitants"]	= "visitants";
		$company["search"]		= NULL;

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
		} 

		$visitants = Metodo::selectRegister($company, "Visitant");
		
		// var_dump($visitants);exit;
		//var_dump($msg);exit;
		$page = new PageVisitant();
		
		$page->setTpl("visitant", array(
			"visitants"	=> $visitants[0],
			"pgs"		=> $visitants[1],
			"msg"		=> $msg
		));
		
	});

	$app->get('/visitant', function() 
	{
		
		User::verifyLogin();

		$company["name_person"]	= NULL;
		$company["visitants"]	= NULL;
		$company["search"]		= NULL;
		$company["date_fim"] 	= NULL;
		$company["date_save"] 	= NULL;
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 

		if ((isset($_GET["date_save"]) && $_GET["date_save"] != '')) {
			$gget = Metodo::convertDateToDataBase(["date_save"=>$_GET["date_save"]]);

			foreach ($gget as $key => $value) {
				$_GET[$key] = $value;
			}
		} 
		if ( (isset($_GET["date_fim"]) && $_GET["date_fim"] != '')) 
		{
			$gget = Metodo::convertDateToDataBase(["date_fim"=>$_GET["date_fim"]]);

			foreach ($gget as $key => $value) {
				$_GET[$key] = $value;
			}
		} 

		foreach ($_GET as $key => $value) {
			$company[$key] = $value;
		}
		$company["visitants"]	= "visitants";
		$visitants = Metodo::selectRegister($company, "Visitant");
		
		$page = new PageVisitant();
		$page->setTpl("visitant", array(
			"visitants"	=> $visitants[0],
			"pgs"		=> $visitants[1],
			"msg"		=> $msg
		));
	});

	$app->get('/visitant/create', function() 
	{
		User::verifyLogin();
		$classification = Metodo::listClassification();
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
				
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 
		
		for ($i=0; $i < 200 ; $i++) 
		{ 
			$j[$i] = $i;
		}
		$date = explode(" ",date('d-m-Y H:i'));
		$dt["date"] = $date[0];
		$dt1["hour"] =$date[1];


		$page = new PageVisitant();

		$page->setTpl("visitant-create", array(
			"j"	=>$j,
			"date"	=>$dt,
			"hour"	=>$dt1,
			"classifications" =>$classification,
			"msg" =>$msg,
		));
	});
	
	$app->post('/visitant/create', function() 
	{
		User::verifyLogin();
		
		$visitant = new Visitant();

		$ppost = Metodo::convertDateToDataBase(["daydate"=>$_POST["daydate"]]);

		foreach ($ppost as $key => $value) {
			$_POST[$key] = $value;
		}
		$_POST["user_id"] = $_SESSION["User"]["user_id"];
		
		if (isset($_FILES['image']) && $_FILES['image'] != '') {
			$photo = $_FILES['image']['tmp_name'];
			$tamanho = $_FILES['image']['size'];
			$tipo = $_FILES['image']['type'];
			$nome = $_FILES['image']['name'];

			$fp = fopen($photo, "rb");
			$conteudo = fread($fp, $tamanho);
			$_POST["photo"] = base64_encode($conteudo);

			fclose($fp);
		
		} else {
			$_POST["photo"] = '';
		}
		
		$visitant->setData($_POST);
		$msg = $visitant->save();
				
		header("Location: /visitant/create?msg=".$msg);
		exit;
	});

	$app->get("/visitant/:visitant_id/delete", function ($visitant_id){
		User::verifyLogin();
		$visitant = new Visitant();
		$visitant->getById($visitant_id);
		$msg = $visitant->delete();
		
		header("Location: /visitant?msg=".$msg);
		exit;
	});

	$app->get('/visitant/:person_id', function($person_id) 
	{
		$dir = 'image';
		User::verifyLogin();
		$classifications = Metodo::listClassification();
		
		$visitant = new Visitant();
		$visitant->getById($person_id);
		if(!is_dir($dir))
			mkdir($dir, 777);
		
		if ($visitant->getphoto()) {
			$photo = $visitant->getphoto();
			$person_id = $visitant->getperson_id();
			
			$bs64_code = 'data:image/jpg;base64,'.$photo;
			converter_base64_para_imagem($bs64_code, $dir, $person_id);
		}
		
		for ($i=0; $i < 200 ; $i++) 
		{ 
			$j[$i] = $i;
		}

		$page = new PageVisitant();
		
		$page ->setTpl("visitant-update", array(
			"visitant"		=>$visitant->getValues(),
			"j"				=>$j,
			"classifications"=>$classifications
		));
		
	});

	$app->post("/visitant/:person_id", function ($person_id)
	{
		User::verifyLogin();
			
		$visitant = new Visitant();
		$visitant->getById($person_id);
		if (isset($_POST)) {
			$ppost = Metodo::convertDateToDataBase(["daydate"=>$_POST["daydate"], "dt_save"=>$_POST["dt_save"]]);
			foreach ($ppost as $key => $value) {
				$_POST[$key] = $value;
			}
			$_POST["user_id"] = $_SESSION["User"]["user_id"];
		}
		if (isset($_FILES['image']) && $_FILES['image'] != '') {
			$photo = $_FILES['image']['tmp_name'];
			$tamanho = $_FILES['image']['size'];
			$tipo = $_FILES['image']['type'];
			$nome = $_FILES['image']['name'];

			$fp = fopen($photo, "rb");
			$conteudo = fread($fp, $tamanho);
			$_POST["photo"] = base64_encode($conteudo);

			fclose($fp);
		}
		
		$visitant->setData($_POST);
		$msg = $visitant->update();
		
		header("Location: /visitant?msg=".$msg);
		exit;
	});

/*======================================================================================*/
/*										Rotas dos Resíduos								*/
/*======================================================================================*/
	

	$app->get('/residual', function() {
		User::verifyLogin();
		
		$company["residual"]	= NULL;
		$company["daydate"]	    = NULL;
		$company["date_fim"]    = NULL;
		$company["name_person"] = NULL;
		$company["search"] 		= NULL;
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 

		if ((isset($_GET["daydate"]) && $_GET["daydate"] != '')) {
			$gget = Metodo::convertDateToDataBase(["daydate"=>$_GET["daydate"]]);

			foreach ($gget as $key => $value) {
				$_GET[$key] = $value;
			}
		} 
		if ( (isset($_GET["date_fim"]) && $_GET["date_fim"] != '')) 
		{
			$gget = Metodo::convertDateToDataBase(["date_fim"=>$_GET["date_fim"]]);

			foreach ($gget as $key => $value) {
				$_GET[$key] = $value;
			}
		}
		
		$residual	= Metodo::selectRegister($company, "Residual");
		
		$page = new PageResidual();
		$page->setTpl("residual", array(
			"residuals"=>$residual[0],
			"pgs"=>$residual[1],
			"msg"=>$msg
		));
		
	});

	$app->get('/residual/create', function() {
		User::verifyLogin();
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 

		$date = explode(" ",date('d-m-Y H:i'));
		$dt["date"]		= $date[0];
		$dt1["hour"]	= $date[1];
		$responsable["name_person"] = $_SESSION["User"]["name_person"];

		$page = new PageResidual();

		$page->setTpl("residual-create",array(
			"msg"=>$msg,
			"date"=>$dt,
			"hour"=>$dt1,
			"residual"=>$responsable
		));
		
	});

	$app->post("/residual/create", function (){
		User::verifyLogin();
		
		$residual = new Residual();
		
		$ppost = Metodo::convertDateToDataBase(["daydate"=>$_POST["daydate"]]);
		
		foreach ($ppost as $key => $value) {
			$_POST[$key] = $value;
		}
		
		$_POST["user_id"] = $_SESSION["User"]["user_id"];
		$_POST["person_id"] = $_SESSION["User"]["person_id"];
		
		$residual->setData($_POST);
		
		$msg = $residual->save();
		
		header("Location: /residual/create?msg=$msg");
		exit;
	});
	
	$app->get("/residual/:residual_id/delete", function ($residual_id){
		User::verifyLogin();
		$residual = new Residual();
		$residual->getById($residual_id);

		$msg = $residual->delete();
		
		header("Location: /residual?msg=".$msg."&daydate=&date_fim=&search=Search");
		exit;
	});

	$app->get("/residual/:residual_id", function($residual_id) {
		User::verifyLogin();
		$residual = new Residual();
		$residual->getById($residual_id);
		
		$page = new PageResidual();
		
		$page ->setTpl("residual-update", array(
			"residual"=>$residual->getValues()
		));
	});

	$app->post("/residual/:residual_id", function($residual_id) {
		User::verifyLogin();
		$residual = new Residual();
		$residual->getById($residual_id);
		
		if (isset($_POST)) {
			$ppost = Metodo::convertDateToDataBase(["daydate"=>$_POST["daydate"]]);
			foreach ($ppost as $key => $value) {
				$_POST[$key] = $value;
			}
			$_POST["user_id"] = $_SESSION["User"]["user_id"];
		}

		$residual->setData($_POST);
		
		$msg = $residual->update();
		
		header("Location: /residual?msg=".$msg);
		exit;
	});

/*======================================================================================*/
/*										Rotas dos Material								*/
/*======================================================================================*/

	$app->get('/material', function() {
		User::verifyLogin();
		
		$company["material"]	= NULL;
		$company["daydate"]	    = NULL;
		$company["date_fim"]    = NULL;
		$company["receiver"] 	= NULL;
		$company["search"] 		= NULL;
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 

		if ((isset($_GET["daydate"]) && $_GET["daydate"] != '')) {
			$gget = Metodo::convertDateToDataBase(["daydate"=>$_GET["daydate"]]);

			foreach ($gget as $key => $value) {
				$_GET[$key] = $value;
			}
		} 
		if ( (isset($_GET["date_fim"]) && $_GET["date_fim"] != '')) 
		{
			$gget = Metodo::convertDateToDataBase(["date_fim"=>$_GET["date_fim"]]);

			foreach ($gget as $key => $value) {
				$_GET[$key] = $value;
			}
		}
		
		$material	= Metodo::selectRegister($company, "Material");
		// echo '<pre>';
		// print_r($material);
		// echo '</pre>';
		// exit;
		$page = new PageMaterial();
		$page->setTpl("material", array(
			"materials"=>$material[0],
			"pgs"=>$material[1],
			"msg"=>$msg
		));
		
	});

	$app->get('/material/create', function() {
		User::verifyLogin();
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 

		$date = explode(" ",date('d-m-Y H:i'));
		$dt["date"]		= $date[0];
		$dt1["hour"]	= $date[1];

		$page = new PageMaterial();

		$page->setTpl("material-create",array(
			"msg"=>$msg,
			"date"=>$dt,
			"hour"=>$dt1
		));
		
	});

	$app->post("/material/create", function (){
		User::verifyLogin();
		
		$material = new Material();
		$ppost = Metodo::convertDateToDataBase(["daydate"=>$_POST["daydate"]]);
		
		foreach ($ppost as $key => $value) {
			$_POST[$key] = $value;
		}
		
		$_POST["user_id"] = $_SESSION["User"]["user_id"];
		$_POST["person_id"] = $_SESSION["User"]["person_id"];
		
		$material->setData($_POST);
		
		$msg = $material->save();
		
		header("Location: /material/create?msg=$msg");
		exit;
	});

	$app->get("/material/:material_id/delete", function ($material_id){
		User::verifyLogin();
		$material = new Material();
		$material->getById($material_id);

		$msg = $material->delete();
		
		header("Location: /material?msg=".$msg."&daydate=&date_fim=&search=Search");
		exit;
	});

	$app->get("/material/:material_id", function($material_id) {
		User::verifyLogin();
		$material = new Material();
		$material->getById($material_id);
		
		$page = new PageMaterial();
		
		$page ->setTpl("material-update", array(
			"material"=>$material->getValues()
		));
	});

	$app->post("/material/:material_id", function($material_id) {
		User::verifyLogin();
		$material = new Material();
		$material->getById($material_id);
		if (isset($_POST)) {
			$ppost = Metodo::convertDateToDataBase(["daydate"=>$_POST["daydate"]]);
			foreach ($ppost as $key => $value) {
				$_POST[$key] = $value;
			}
			$_POST["user_id"] = $_SESSION["User"]["user_id"];
		}

		$material->setData($_POST);
		
		$msg = $material->update();
		
		header("Location: /material?msg=".$msg);
		exit;
	});	

/*======================================================================================*/
/*										Rotas dos Nobreak								*/
/*======================================================================================*/

	$app->get('/nobreak', function() {
		User::verifyLogin();
		
		$company["nobreak"]	= NULL;
		$company["daydate"]	    = NULL;
		$company["date_fim"]    = NULL;
		$company["name_person"] = NULL;
		$company["search"] 		= NULL;
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 
		
		if ((isset($_GET["daydate"]) && $_GET["daydate"] != '')) {
			$gget = Metodo::convertDateToDataBase(["daydate"=>$_GET["daydate"]]);

			foreach ($gget as $key => $value) {
				$_GET[$key] = $value;
			}
		} 
		
		if ( (isset($_GET["date_fim"]) && $_GET["date_fim"] != '')) 
		{
			$gget = Metodo::convertDateToDataBase(["date_fim"=>$_GET["date_fim"]]);

			foreach ($gget as $key => $value) {
				$_GET[$key] = $value;
			}
		}
		
		$nobreak	= Metodo::selectRegister($company, "Nobreak");
		
		$page = new PageNobreak();
		$page->setTpl("nobreak", array(
			"nobreaks"=>$nobreak[0],
			"pgs"=>$nobreak[1],
			"msg"=>$msg
		));
		
	});

	$app->get('/nobreak/create', function() {
		User::verifyLogin();
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 

		$date = explode(" ",date('d-m-Y H:i'));
		$dt["date"]		= $date[0];
		$dt1["hour"]	= $date[1];
		$responsable["name_person"] = $_SESSION["User"]["name_person"];

		$page = new PageNobreak();

		$page->setTpl("nobreak-create",array(
			"msg"=>$msg,
			"date"=>$dt,
			"hour"=>$dt1,
			"nobreak"=>$responsable
		));
		
	});

	$app->post("/nobreak/create", function (){
		User::verifyLogin();
		
		$nobreak = new Nobreak();
		
		$ppost = Metodo::convertDateToDataBase(["daydate"=>$_POST["daydate"]]);
		
		foreach ($ppost as $key => $value) {
			$_POST[$key] = $value;
		}
		
		$_POST["user_id"] = $_SESSION["User"]["user_id"];
		$_POST["person_id"] = $_SESSION["User"]["person_id"];
		
		$nobreak->setData($_POST);
		
		$msg = $nobreak->save();
		
		header("Location: /nobreak/create?msg=$msg");
		exit;
	});

	$app->get("/nobreak/:nobreak_id/delete", function ($nobreak_id){
		User::verifyLogin();
		$nobreak = new Nobreak();
		$nobreak->getById($nobreak_id);

		$msg = $nobreak->delete();
		
		header("Location: /nobreak?msg=".$msg."&daydate=&date_fim=&search=Search");
		exit;
	});

	$app->get("/nobreak/:nobreak_id", function($nobreak_id) {
		User::verifyLogin();
		$nobreak = new Nobreak();
		$nobreak->getById($nobreak_id);
		
		$page = new PageNobreak();
		
		$page ->setTpl("nobreak-update", array(
			"nobreak"=>$nobreak->getValues()
		));
	});

	$app->post("/nobreak/:nobreak_id", function($nobreak_id) {
		User::verifyLogin();
		$nobreak = new Nobreak();
		$nobreak->getById($nobreak_id);
		
		if (isset($_POST)) {
			$ppost = Metodo::convertDateToDataBase(["daydate"=>$_POST["daydate"]]);
			foreach ($ppost as $key => $value) {
				$_POST[$key] = $value;
			}
			$_POST["user_id"] = $_SESSION["User"]["user_id"];
		}

		$nobreak->setData($_POST);
		
		$msg = $nobreak->update();
		
		header("Location: /nobreak?msg=".$msg);
		exit;
	});

	
/*======================================================================================*/
/*										Rotas do Extintor								*/
/*======================================================================================*/

	$app->get('/fireexting', function() {
		User::verifyLogin();
		
		$company["fireexting"]	= NULL;
		$company["daydate"]	    = NULL;
		$company["date_fim"]    = NULL;
		$company["search"] 		= NULL;
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 
		
		if ((isset($_GET["daydate"]) && $_GET["daydate"] != '')) {
			$gget = Metodo::convertDateToDataBase(["daydate"=>$_GET["daydate"]]);

			foreach ($gget as $key => $value) {
				$_GET[$key] = $value;
			}
		} 
		
		if ( (isset($_GET["date_fim"]) && $_GET["date_fim"] != '')) 
		{
			$gget = Metodo::convertDateToDataBase(["date_fim"=>$_GET["date_fim"]]);

			foreach ($gget as $key => $value) {
				$_GET[$key] = $value;
			}
		}
		
		$fireexting	= Metodo::selectRegister($company, "FireExting");
		
		$page = new PageFireExting();
		$page->setTpl("fireexting", array(
			"fireextings"=>$fireexting[0],
			"pgs"=>$fireexting[1],
			"msg"=>$msg
		));
	});

	
	$app->get('/fireexting/create', function() {
		User::verifyLogin();
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 
		
		$date = explode(" ",date('d-m-Y H:i'));
		$dt["date"]		= $date[0];
		$dt1["hour"]	= $date[1];
		
		$page = new PageFireExting();
		//var_dump($msg);exit;

		$page->setTpl("fireexting-create",array(
			"msg"=>$msg,
			"date"=>$dt,
			"hour"=>$dt1
		));
		
	});

	$app->post('/fireexting/create', function() {
		User::verifyLogin();
		
		$fireexting = new FireExting();
		
		$ppost = Metodo::convertDateToDataBase(["daydate"=>$_POST["daydate"], "rechargedate"=>$_POST["rechargedate"]]);
		
		foreach ($ppost as $key => $value) {
			$_POST[$key] = $value;
		}
		
		$_POST["user_id"] = $_SESSION["User"]["user_id"];
		$_POST["person_id"] = $_SESSION["User"]["person_id"];
		
		$fireexting->setData($_POST);
		$sql = new Sql();
		
		$msg = $fireexting->save();
		
		header("Location: /fireexting/create?msg=$msg");
		exit;
		
	});

	$app->get("/fireexting/:fireexting_id/delete", function ($fireexting_id){
		User::verifyLogin();
		$fireexting = new FireExting();
		$fireexting->getById($fireexting_id);

		$msg = $fireexting->delete();
		
		header("Location: /fireexting?msg=".$msg."&daydate=&date_fim=&search=Search");
		exit;
	});

	$app->get('/fireexting/:fireexting_id', function($fireexting_id) {
		User::verifyLogin();
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		}

		$fireexting = new FireExting();
		$fireexting->getById($fireexting_id);
		// echo '<pre>';
		// print_r($fireexting);
		// echo '</pre>';
		//exit;
		$page = new PageFireExting();
		
		$page ->setTpl("fireexting-update", array(
			"fireexting"=>$fireexting->getValues(),
			"msg"=>$msg
		));
	});

	$app->post('/fireexting/:fireexting_id', function($fireexting_id) {
		User::verifyLogin();
		$fireexting = new FireExting();
		$fireexting->getById($fireexting_id);
		
		if (isset($_POST)) {
			$ppost = Metodo::convertDateToDataBase(["daydate"=>$_POST["daydate"],"rechargedate"=>$_POST["rechargedate"]]);
			foreach ($ppost as $key => $value) {
				$_POST[$key] = $value;
			}
			$_POST["user_id"] = $_SESSION["User"]["user_id"];
		}

		$fireexting->setData($_POST);
		
		$msg = $fireexting->update();
		
		header("Location: /fireexting?msg=".$msg);
		exit;
	});

/*======================================================================================*/
/*							Rotas do Histórico do Extintor								*/
/*======================================================================================*/
		
	$app->get('/historic', function() {
		User::verifyLogin();
		
		$company["historic"]		= NULL;
		$company["daydate"]	    	= NULL;
		$company["date_fim"]    	= NULL;
		$company["search"] 			= NULL;
		$company["fireexting_id"]	= $_GET["fireexting_id"];

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 
		
		if ((isset($_GET["daydate"]) && $_GET["daydate"] != '')) {
			$gget = Metodo::convertDateToDataBase(["daydate"=>$_GET["daydate"]]);

			foreach ($gget as $key => $value) {
				$_GET[$key] = $value;
			}
		} 
		
		if ( (isset($_GET["date_fim"]) && $_GET["date_fim"] != '')) 
		{
			$gget = Metodo::convertDateToDataBase(["date_fim"=>$_GET["date_fim"]]);

			foreach ($gget as $key => $value) {
				$_GET[$key] = $value;
			}
		}
		
		$historic	= Metodo::selectRegister($company, "HistoricE");
		if ($historic[0] == NULL) {
			$historic[0][0] = ["fireexting_id"=>$_GET["fireexting_id"],"historic_id"=> NULL ];
		}
	
		$page = new PageHistoricE();
		
		$page->setTpl("historic", array(
			"fireextings"=>$historic[0],
			"pgs"=>$historic[1],
			"msg"=>$msg
		));
		
	});

	$app->get('/historic/create', function() {
		User::verifyLogin();
		if (isset($_GET["fireexting_id"])) {
			$fireexting_id = $_GET["fireexting_id"];
		}
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 
		
		$date = explode(" ",date('d-m-Y H:i'));
		$dt["date"]		= $date[0];
		// echo 'IL734';
		// var_dump($_GET);exit;
		$page = new PageHistoricE();

		$page->setTpl("historic-create",array(
			"msg"=>$msg,
			"date"=>$dt,
			"fireexting"=>$fireexting_id
		));
		
	});

	$app->post('/historic/create', function() {
		User::verifyLogin();
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 
		
		$fireexting = new HistoricE();
		
		$ppost = Metodo::convertDateToDataBase(["daydate"=>$_POST["daydate"]]);
		
		foreach ($ppost as $key => $value) {
			$_POST[$key] = $value;
		}
		
		$_POST["user_id"] = $_SESSION["User"]["user_id"];
		$fireexting_id = $_POST["fireexting_id"];
		$fireexting->setData($_POST);
		
		$msg = $fireexting->save();
		
		header("Location: /historic/create?msg=$msg&fireexting_id=$fireexting_id");
		exit;
		
	});
	
	
	$app->get('/historic/:historic_id/delete', function($historic_id) {
		User::verifyLogin();
		$historic = new HistoricE();
		$historic->getById($historic_id);

		$fireexting_id = $historic->getfireexting_id();

		$msg = $historic->delete();
		
		header("Location: /historic?msg=$msg&fireexting_id=$fireexting_id");
		exit;
		
	});
	
	$app->get('/historic/:historic_id', function($historic_id) {
		User::verifyLogin();
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		}

		$historic = new HistoricE();
		$historic->getbyid($historic_id);
		
		$page = new PageHistoricE();
		
		$page ->setTpl("historic-update", array(
			"historic"=>$historic->getValues(),
			"msg"=>$msg
		));
	});

	$app->post('/historic/:historic_id', function($historic_id) {
		User::verifyLogin();
		$historic = new HistoricE();
		$historic->getbyid($historic_id);
		$fireexting_id = $_POST['fireexting_id'];

		if (isset($_POST)) {
			$ppost = Metodo::convertDateToDataBase(["daydate"=>$_POST["daydate"]]);
			foreach ($ppost as $key => $value) {
				$_POST[$key] = $value;
			}
			$_POST["user_id"] = $_SESSION["User"]["user_id"];
		}

		$historic->setData($_POST);
		
		$msg = $historic->update();
		
		header("Location: /historic?pg=1&msg=$msg&fireexting_id=$fireexting_id");
		exit;
	});


/*======================================================================================*/
/*										Rotas do Admin									*/
/*======================================================================================*/

	$app->get('/admin', function() {

		User::verifyLogin();
		if ($_SESSION["User"]["inadmin"] == '1') {
			$users = User::listAll();
	
			$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];		
			
			if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
				$mess = explode(':', $_GET["msg"]);
				$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
				$_GET["msg"] = '';
			} 
	
			$page = new PageUser();
			
			$page->setTpl("users", array(
				"users"=> $users,
				"msg"=>$msg
			));
		} else {
			header("Location: /visitant?pg=1&limit=10");
			exit;
		}
	});

	$app->get('/admin/login', function() {
		
		$page = new PageAdmin([
			"header"=> false,
			"footer"=> false

		]);
		
		$page->setTpl("login");
		
	});

	$app->post('/admin/login', function() {
		
		User::login($_POST["login"], $_POST["pass"]);
		
		header("Location: /");
		exit;
		
	});

	$app->get('/admin/logout', function() {
		
		User::logout();
		header("Location: /admin/login");
		exit;
	});

	$app->get("/admin/forgot", function(){
		$page = new PageAdmin([
			"header"=>false,
			"footer"=>false
		]);
		$page->setTpl("forgot");
	});

	$app->post("/admin/forgot", function(){
		
		$user = User::getForgot($_POST["email"]);
		header("Location: /admin/forgot/sent");
		exit;
	});

	$app->get("/admin/forgot/sent", function(){
		$page = new PageAdmin([
			"header"=>false,
			"footer"=>false
		]);
		$page->setTpl("forgot-sent");
	});

	$app->get("/admin/forgot/reset", function(){
		$user = User::validForgotDecrypt($_GET["code"]);
		$page = new PageAdmin([
			"header"=>false,
			"footer"=>false
		]);
		$page->setTpl("forgot-reset", array(
			"name"=>$user["desperson"],
			"code"=>$_GET["code"]
		));
	});

	$app->post("/admin/forgot/reset", function(){
		$forgot = User::validForgotDecrypt($_GET["code"]);
		User::setForgotUsed($forgot["idrecovery"]);
		$user= new User();
		$user->get((int)$forgot["iduser"]);
		$user->setPassword($_POST["password"]);
	});


/*======================================================================================*/
/*										Rotas do Users									*/
/*======================================================================================*/

	$app->get('/users', function() {
		
		User::verifyLogin();
		if ($_SESSION["User"]["inadmin"] == '1') {
			$users = User::listAll();
			
			$msg= '';
			
			if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
				$mess = explode(':', $_GET["msg"]);
				$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			} else {
				$msg = ["state"=>'', "msg"=> ''];
			}

			$page = new PageUser();
			$page->setTpl("users", array(
				"users"=> $users,
				"msg"=>$msg
			));
		} else {
			header("Location: /visitant?pg=1&limit=10");
			exit;
		}
	});

	$app->get('/users/create', function() {
		
		User::verifyLogin();
		if ($_SESSION["User"]["inadmin"] == '1') {
			$page = new PageUser();
			$page->setTpl("users-create");
		} else {
			header("Location: /visitant?pg=1&limit=10");
			exit;
		}
	});
	
	$app->post("/users/create", function (){
		User::verifyLogin();

		$user = new User();

		$date = explode(" ",date('d-m-Y H:i'));
		$dt["daydate"] = $date[0];
		$dt1["hour"] =$date[1];
		$ppost = Metodo::convertDateToDataBase(["daydate"=>$date[0]]);

		foreach ($ppost as $key => $value) {
			$_POST[$key] = $value;
		}

		$_POST["inadmin"] = (isset($_POST["inadmin"])) ? 1 : 0;

		$_POST["situation"] = '0';
		$_POST["photo"] = '';
		$_POST["classification_id"] = '4';
	
		$_POST['pass'] = password_hash($_POST["pass"], PASSWORD_DEFAULT, [
			"cost"=>12
			]);

		$user->setData($_POST);

		$msg = $user->save();

		header("Location: /users?msg=$msg");
			exit;
	});
	$app->get("/users/:person_id/delete", function ($person_id){
		User::verifyLogin();
		if ($_SESSION["User"]["inadmin"] == '1') {
			$user = new User();
			$user->get((int)$person_id);

			$msg = $user->delete();
			header("Location: /users?msg=$msg");
			exit;
		} else {
			header("Location: /visitant?pg=1&limit=10");
			exit;
		}
	});

	$app->get("/users/:person_id", function($person_id) {
		User::verifyLogin();
		$user = new User();
 
		$user->get((int)$person_id);
			
		$page = new PageUser();
		
		$page ->setTpl("users-update", array(
			"user"=>$user->getValues()
		));
	});
	
	$app->post("/users/:person_id", function ($person_id){
		User::verifyLogin();
		$user = new User();
		$_POST["inadmin"] = (isset($_POST["inadmin"])) ? 1 : 0;
		$_POST['pass'] = password_hash($_POST["pass"], PASSWORD_DEFAULT, [
			"cost"=>12
			]);
		$user->get((int)$person_id);
		$user->setData($_POST);
		$msg = $user->update();
		
		header("Location: /users?msg=".$msg);
		exit;
		
	});
	
	$app->run();

?>
