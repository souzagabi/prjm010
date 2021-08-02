<?php 
	session_start();
	require_once("vendor/autoload.php");

	use \Slim\Slim;
	use \PRJM010\Page;
	use \PRJM010\PageAdmin;
	use \PRJM010\PageUser;
	use \PRJM010\PageVisitant;
	use \PRJM010\PageResidual;
	use \PRJM010\PageGoods;
	use \PRJM010\PageNobreak;
	use \PRJM010\PageFireExting;
	use \PRJM010\PageHistoricE;
	use \PRJM010\PagePurifier;
	use \PRJM010\PageHistoricP;
	use \PRJM010\PageClothing;
	use \PRJM010\PageMaterial;
	use \PRJM010\PageHydrant;
	use \PRJM010\PageHistoricH;
	use \PRJM010\PageHistoricA;
	use \PRJM010\PageAirConditioning;
	use \PRJM010\PageAnualPlan;
	use \PRJM010\PageLocation;
	use \PRJM010\PageLocal;
	use \PRJM010\PageGeneralControl;

	use \PRJM010\Model\User;
	use \PRJM010\Model\Person;
	use \PRJM010\Model\Visitant;
	use \PRJM010\Model\Residual;
	use \PRJM010\Model\Goods;
	use \PRJM010\Model\Metodo;
	use \PRJM010\Model\Nobreak;
	use \PRJM010\Model\FireExting;
	use \PRJM010\Model\HistoricE;
	use \PRJM010\Model\Purifier;
	use \PRJM010\Model\HistoricP;
	use \PRJM010\Model\Clothing;
	use \PRJM010\Model\Material;
	use \PRJM010\Model\Hydrant;
	use \PRJM010\Model\HistoricH;
	use \PRJM010\Model\AirConditioning;
	use \PRJM010\Model\HistoricA;
	use \PRJM010\Model\AnualPlan;
	use \PRJM010\Model\Location;
	use \PRJM010\Model\Local;
	use \PRJM010\Model\GeneralControl;

	include_once("./config/php/funcao.php");

	date_default_timezone_set('America/Sao_Paulo');

	$app = new Slim();

	$app->config('debug', true);

/*======================================================================================*/
/*										Rotas dos Visitants								*/
/*======================================================================================*/
	$app->get('/', function() {
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
		}

		$page = new PageAdmin([
			"header"=> false,
			"footer"=> false

		]);
		$page->setTpl("login", array(
			"msg"=>$msg
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
		$classification = Visitant::listClassification();
		
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
		$date = explode(" ",date('d-m-Y H:i:s'));
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
		
		$user_id["user_id"] = $_SESSION["User"]["user_id"];
		$visitant->setdata($user_id);
		
		$msg = $visitant->delete();
		
		header("Location: /visitant?msg=".$msg);
		exit;
	});

	$app->get('/visitant/:visitant_id', function($visitant_id) 
	{
		$dir = 'image';
		$classifications = Visitant::listClassification();
		
		$visitant = new Visitant();
		$visitant->getById($visitant_id);
		
		User::verifyLogin();
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
		$company["residual"]	= NULL;
		$company["daydate"]	    	= NULL;
		$company["search"] 			= NULL;

		$locations = Location::listAll($company);
		$locais = Local::listAll($company);

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
			"residual"=>$responsable,
			"locations"=>$locations,
			"locais" =>$locais,
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

		$user_id["user_id"] = $_SESSION["User"]["user_id"];
		$residual->setdata($user_id);
		
		$msg = $residual->delete();
		
		header("Location: /residual?msg=".$msg."&daydate=&date_fim=&search=Search");
		exit;
	});

	$app->get("/residual/:residual_id", function($residual_id) {
		User::verifyLogin();
		$company["residual"]	= NULL;
		$company["daydate"]	    = NULL;
		$company["search"] 		= NULL;

		$locations = Location::listAll($company);
		$locais = Local::listAll($company);

		$residual = new Residual();
		$residual->getById($residual_id);
		
		$page = new PageResidual();
		
		$page ->setTpl("residual-update", array(
			"residual"=>$residual->getValues(),
			"locations"=>$locations,
			"locais" =>$locais,
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
/*										Rotas dos Goods									*/
/*======================================================================================*/

	$app->get('/goods', function() {
		User::verifyLogin();
		
		$company["goods"]	= NULL;
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
		
		$goods	= Metodo::selectRegister($company, "Goods");
		
		$page = new PageGoods();
		$page->setTpl("goods", array(
			"goods"=>$goods[0],
			"pgs"=>$goods[1],
			"msg"=>$msg
		));
		
	});

	$app->get('/goods/create', function() {
		User::verifyLogin();
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 

		$responsable["name_person"] = $_SESSION["User"]["name_person"];

		$date = explode(" ",date('d-m-Y H:i'));
		$dt["date"]		= $date[0];
		$dt1["hour"]	= $date[1];

		$page = new PageGoods();

		$page->setTpl("goods-create",array(
			"msg"=>$msg,
			"responsable"=>$responsable,
			"date"=>$dt,
			"hour"=>$dt1
		));
		
	});

	$app->post("/goods/create", function (){
		User::verifyLogin();
		
		$goods = new Goods();
		$ppost = Metodo::convertDateToDataBase(["daydate"=>$_POST["daydate"]]);
		
		foreach ($ppost as $key => $value) {
			$_POST[$key] = $value;
		}
		
		$_POST["user_id"] = $_SESSION["User"]["user_id"];
		$_POST["person_id"] = $_SESSION["User"]["person_id"];
		
		$goods->setData($_POST);
		
		$msg = $goods->save();
		
		header("Location: /goods/create?msg=$msg");
		exit;
	});

	$app->get("/goods/:goods_id/delete", function ($goods_id){
		User::verifyLogin();
		$goods = new Goods();
		$goods->getById($goods_id);

		$user_id["user_id"] = $_SESSION["User"]["user_id"];
		$goods->setdata($user_id);
		
		$msg = $goods->delete();
		
		header("Location: /goods?msg=".$msg."&daydate=&date_fim=&search=Search");
		exit;
	});

	$app->get("/goods/:goods_id", function($goods_id) {
		User::verifyLogin();
		$goods = new Goods();
		$goods->getById($goods_id);
		
		$page = new PageGoods();
		
		$page ->setTpl("goods-update", array(
			"goods"=>$goods->getValues()
		));
	});

	$app->post("/goods/:goods_id", function($goods_id) {
		User::verifyLogin();
		$goods = new Goods();
		$goods->getById($goods_id);
		if (isset($_POST)) {
			$ppost = Metodo::convertDateToDataBase(["daydate"=>$_POST["daydate"]]);
			foreach ($ppost as $key => $value) {
				$_POST[$key] = $value;
			}
			$_POST["user_id"] = $_SESSION["User"]["user_id"];
		}

		$goods->setData($_POST);
		
		$msg = $goods->update();
		
		header("Location: /goods?msg=".$msg);
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

		$date = explode(" ",date('d-m-Y H:i'));
		$dt["date"]		= $date[0];
		$dt1["hour"]	= $date[1];
		$responsable["name_person"] = $_SESSION["User"]["name_person"];

		$locations = Location::listAll($company);
		$locais = Local::listAll($company);

		$page = new PageNobreak();

		$page->setTpl("nobreak-create",array(
			"msg"=>$msg,
			"date"=>$dt,
			"hour"=>$dt1,
			"nobreak"=>$responsable,
			"locations"=>$locations,
			"locais"=>$locais
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

		$user_id["user_id"] = $_SESSION["User"]["user_id"];
		$nobreak->setdata($user_id);
		
		$msg = $nobreak->delete();
		
		header("Location: /nobreak?msg=".$msg."&daydate=&date_fim=&search=Search");
		exit;
	});

	$app->get("/nobreak/:nobreak_id", function($nobreak_id) {
		User::verifyLogin();
		
		$company["nobreak"]	= NULL;
		$company["daydate"]	    = NULL;
		$company["date_fim"]    = NULL;
		$company["name_person"] = NULL;
		$company["search"] 		= NULL;
		
		$locations = Location::listAll($company);
		$locais = Local::listAll($company);

		$nobreak = new Nobreak();
		$nobreak->getById($nobreak_id);
		

		$page = new PageNobreak();
		
		$page ->setTpl("nobreak-update", array(
			"nobreak"=>$nobreak->getValues(),
			"locations"=>$locations,
			"locais"=>$locais
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

		$company["fireexting"]	= NULL;
		
		$locations = Location::listAll($company);
		$locais = Local::listAll($company);
		
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
	
		$page->setTpl("fireexting-create",array(
			"msg"=>$msg,
			"date"=>$dt,
			"hour"=>$dt1,
			"locations"=>$locations,
			"locais"=>$locais
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
		
		$msg = $fireexting->save();
		
		header("Location: /fireexting/create?msg=$msg");
		exit;
		
	});

	$app->get("/fireexting/:fireexting_id/delete", function ($fireexting_id){
		User::verifyLogin();
		$fireexting = new FireExting();
		$fireexting->getById($fireexting_id);
		
		$user_id["user_id"] = $_SESSION["User"]["user_id"];
		$fireexting->setdata($user_id);
		
		$msg = $fireexting->delete();
	
		header("Location: /fireexting?msg=".$msg."&daydate=&date_fim=&search=Search");
		exit;
	});

	$app->get('/fireexting/:fireexting_id', function($fireexting_id) {
		User::verifyLogin();

		$company["fireexting"]	= NULL;
		
		$locations = Location::listAll($company);
		$locais = Local::listAll($company);

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		}

		$fireexting = new FireExting();
		$fireexting->getById($fireexting_id);
		
		$page = new PageFireExting();
		
		$page ->setTpl("fireexting-update", array(
			"fireexting"=>$fireexting->getValues(),
			"msg"=>$msg,
			"locations"=>$locations,
			"locais"=>$locais
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
/*								Rotas do Histórico do Extintor							*/
/*======================================================================================*/
		
	$app->get('/historicE', function() {
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

	$app->get('/historicE/create', function() {
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
		
		$page = new PageHistoricE();

		$page->setTpl("historic-create",array(
			"msg"=>$msg,
			"date"=>$dt,
			"fireexting"=>$fireexting_id
		));
		
	});

	$app->post('/historicE/create', function() {
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
		
		header("Location: /historicE/create?msg=$msg&fireexting_id=$fireexting_id");
		exit;
		
	});
	
	$app->get('/historicE/:historic_id/delete', function($historic_id) {
		User::verifyLogin();
		$historic = new HistoricE();
		$historic->getById($historic_id);

		$fireexting_id = $historic->getfireexting_id();

		$user_id["user_id"] = $_SESSION["User"]["user_id"];
		$historic->setdata($user_id);
		
		$msg = $historic->delete();
		
		header("Location: /historicE?msg=$msg&fireexting_id=$fireexting_id");
		exit;
		
	});
	
	$app->get('/historicE/:historic_id', function($historic_id) {
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

	$app->post('/historicE/:historic_id', function($historic_id) {
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
		
		header("Location: /historicE?pg=1&msg=$msg&fireexting_id=$fireexting_id");
		exit;
	});

/*======================================================================================*/
/*										Rotas do Purificado								*/
/*======================================================================================*/
	$app->get('/purifier', function() {
		User::verifyLogin();
		
		$company["purifier"]		= NULL;
		$company["daydate"]	    	= NULL;
		$company["date_fim"]    	= NULL;
		$company["search"] 			= NULL;

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
		
		$purifiers	= Metodo::selectRegister($company, "Purifier");
		
		$page = new PagePurifier();
		
		$page->setTpl("purifier", array(
			"purifiers"=>$purifiers[0],
			"pgs"=>$purifiers[1],
			"msg"=>$msg
		));
		
	});

	$app->get('/purifier/create', function() {
		User::verifyLogin();

		$company["purifier"]		= NULL;
		$company["daydate"]	    	= NULL;
		$company["date_fim"]    	= NULL;
		$company["search"] 			= NULL;
		
		$locations = Location::listAll($company);
		$locais = Local::listAll($company);

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 

		$date = explode(" ",date('d-m-Y H:i'));
		$dt["date"]		= $date[0];
		$responsable["name_person"] = $_SESSION["User"]["name_person"];

		$page = new PagePurifier();

		$page->setTpl("purifier-create",array(
			"msg"=>$msg,
			"date"=>$dt,
			"purifier"=>$responsable,
			"locations"=>$locations,
			"locais"=>$locais
		));
		
	});

	$app->post("/purifier/create", function (){
		User::verifyLogin();
		
		$purifier = new Purifier();
		
		$ppost = Metodo::convertDateToDataBase(["daydate"=>$_POST["daydate"], "nextmanager"=>$_POST["nextmanager"]]);
		
		foreach ($ppost as $key => $value) {
			$_POST[$key] = $value;
		}
		
		$_POST["user_id"] = $_SESSION["User"]["user_id"];
		$_POST["person_id"] = $_SESSION["User"]["person_id"];
		
		$purifier->setData($_POST);
		
		$msg = $purifier->save();
		
		header("Location: /purifier/create?msg=$msg");
		exit;
	});

	$app->get("/purifier/:purifier_id/delete", function ($purifier_id){
		User::verifyLogin();
		$purifier = new Purifier();
		$purifier->getById($purifier_id);

		$user_id["user_id"] = $_SESSION["User"]["user_id"];
		$purifier->setdata($user_id);
		
		$msg = $purifier->delete();
		
		header("Location: /purifier?msg=".$msg."&daydate=&date_fim=&search=Search");
		exit;
	});

	$app->get("/purifier/:purifier_id", function($purifier_id) {
		User::verifyLogin();

		$company["purifier"]		= NULL;
		$company["daydate"]	    	= NULL;
		$company["date_fim"]    	= NULL;
		$company["search"] 			= NULL;
		
		$locations = Location::listAll($company);
		$locais = Local::listAll($company);

		$purifier = new Purifier();
		$purifier->getById($purifier_id);
		
		$page = new PagePurifier();
		
		$page ->setTpl("purifier-update", array(
			"purifier"=>$purifier->getValues(),
			"locations"=>$locations,
			"locais"=>$locais
		));
	});

	$app->post("/purifier/:purifier_id", function($purifier_id) {
		User::verifyLogin();
		$purifier = new Purifier();
		$purifier->getById($purifier_id);
		
		if (isset($_POST)) {
			$ppost = Metodo::convertDateToDataBase(["daydate"=>$_POST["daydate"], "nextmanager"=>$_POST["nextmanager"]]);
			foreach ($ppost as $key => $value) {
				$_POST[$key] = $value;
			}
			$_POST["user_id"] = $_SESSION["User"]["user_id"];
		}

		$purifier->setData($_POST);
		
		$msg = $purifier->update();
		
		header("Location: /purifier?msg=".$msg);
		exit;
	});

/*======================================================================================*/
/*								Rotas do Histórico do Purificador						*/
/*======================================================================================*/
		
	$app->get('/historicP', function() {
		User::verifyLogin();
		
		$company["historic"]		= NULL;
		$company["daydate"]	    	= NULL;
		$company["date_fim"]    	= NULL;
		$company["search"] 			= NULL;
		
		if (isset($_GET["purifier_id"])) {
			$purifier_id = explode('_',$_GET["purifier_id"]);
			$company["purifier_id"]		= $purifier_id[0];
		}

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
		
		$historic	= Metodo::selectRegister($company, "HistoricP");

		if ($historic[0] == NULL) {
			$historic[0][0] = ["purifier_id"=>$purifier_id[0],"serialnumber"=> $purifier_id[1],"historic_id"=> NULL ];
		}

		$page = new PageHistoricP();
		
		$page->setTpl("historic", array(
			"purifiers"=>$historic[0],
			"pgs"=>$historic[1],
			"msg"=>$msg
		));
		
	});

	$app->get('/historicP/create', function() {
		User::verifyLogin();
		
		$purifier_id = [0=>"",1=>""];
		if (isset($_GET["purifier_id"])) {
			$purifier_id = explode('_',$_GET["purifier_id"]);
		}
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 
		
		$date = explode(" ",date('d-m-Y H:i'));
		$dt["date"]		= $date[0];
		
		$page = new PageHistoricP();

		$page->setTpl("historic-create",array(
			"msg"=>$msg,
			"date"=>$dt,
			"purifier"=>$purifier_id[0],
			"serialnumber"=>$purifier_id[1]
		));
		
	});

	$app->post('/historicP/create', function() {
		User::verifyLogin();
		echo 'Create';
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 
		
		$purifier = new HistoricP();
		
		$ppost = Metodo::convertDateToDataBase(["daydate"=>$_POST["daydate"]]);
		
		foreach ($ppost as $key => $value) {
			$_POST[$key] = $value;
		}
		
		$_POST["user_id"] = $_SESSION["User"]["user_id"];
		$purifier_id = $_POST["purifier_id"];
		$serialnumber = $_POST["serialnumber"];
		$purifier->setData($_POST);
		
		$msg = $purifier->save();
		
		header("Location: /historicP/create?msg=$msg&purifier_id=".$purifier_id."_".$serialnumber);
		exit;
		
	});

	$app->get('/historicP/:historic_id/delete', function($historic_id) {
		User::verifyLogin();

		$hist = explode('_',$historic_id);

		$historic = new HistoricP();
		
		$historic->getById($hist[0]);

		$user_id["user_id"] = $_SESSION["User"]["user_id"];
		$historic->setdata($user_id);
		
		$purifier_id = $historic->getpurifier_id();

		$msg = $historic->delete();
		
		header("Location: /historicP?msg=$msg&purifier_id=".$purifier_id."_".$hist[1]);
		exit;
		
	});

	$app->get('/historicP/:historic_id', function($historic_id) {
		User::verifyLogin();
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		}

		$historic = new HistoricP();
		$historic->getbyid($historic_id);
		
		$page = new PageHistoricP();
		
		$page ->setTpl("historic-update", array(
			"historic"=>$historic->getValues(),
			"msg"=>$msg
		));
	});

	$app->post('/historicP/:historic_id', function($historic_id) {
		User::verifyLogin();
		
		$historic = new HistoricP();
		$historic->getbyid($historic_id);
		$purifier_id = $_POST['purifier_id'];

		if (isset($_POST)) {
			$ppost = Metodo::convertDateToDataBase(["daydate"=>$_POST["daydate"]]);
			foreach ($ppost as $key => $value) {
				$_POST[$key] = $value;
			}
			$_POST["user_id"] = $_SESSION["User"]["user_id"];
		}
		
		$historic->setData($_POST);
		
		$msg = $historic->update();
		
		header("Location: /historicP?pg=1&msg=$msg&purifier_id=".$purifier_id."_".$_POST['serialnumber']);
		exit;
	});

/*======================================================================================*/
/*										Rotas da Roupa									*/
/*======================================================================================*/

	$app->get('/clothing', function() {
		User::verifyLogin();
		
		$company["clothing"]	= NULL;
		$company["dateout"]	    = NULL;
		$company["datein"]    	= NULL;
		$company["search"] 		= NULL;
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 

		if ((isset($_GET["dateout"]) && $_GET["dateout"] != '')) {
			$gget = Metodo::convertDateToDataBase(["dateout"=>$_GET["dateout"]]);

			foreach ($gget as $key => $value) {
				$_GET[$key] = $value;
			}
		} 
		if ( (isset($_GET["datein"]) && $_GET["datein"] != '')) 
		{
			$gget = Metodo::convertDateToDataBase(["datein"=>$_GET["datein"]]);

			foreach ($gget as $key => $value) {
				$_GET[$key] = $value;
			}
		}
		
		$clothing	= Metodo::selectRegister($company, "Clothing");
		
		$page = new PageClothing();
		$page->setTpl("clothing", array(
			"clothings"=>$clothing[0],
			"pgs"=>$clothing[1],
			"msg"=>$msg
		));
		
	});

	$app->get('/clothing/create', function() {
		User::verifyLogin();
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 

		$date = explode(" ",date('d-m-Y H:i'));
		$dt["dateout"]		= $date[0];

		$page = new PageClothing();

		$page->setTpl("clothing-create",array(
			"msg"=>$msg,
			"date"=>$dt
		));
		
	});

	$app->post("/clothing/create", function (){
		User::verifyLogin();
		
		$clothing = new Clothing();
		$ppost = Metodo::convertDateToDataBase(["dateout"=>$_POST["dateout"],"datein"=>$_POST["datein"]]);
		
		foreach ($ppost as $key => $value) {
			$_POST[$key] = $value;
		}
		
		$_POST["user_id"] = $_SESSION["User"]["user_id"];
		$_POST["person_id"] = $_SESSION["User"]["person_id"];
		
		$clothing->setData($_POST);
		
		$msg = $clothing->save();
		
		header("Location: /clothing/create?msg=$msg");
		exit;
	});

	$app->get("/clothing/:clothing_id/delete", function ($clothing_id){
		User::verifyLogin();
		$clothing = new Clothing();
		$clothing->getById($clothing_id);

		$user_id["user_id"] = $_SESSION["User"]["user_id"];
		$clothing->setdata($user_id);
		
		$msg = $clothing->delete();
		
		header("Location: /clothing?msg=".$msg."&daydate=&date_fim=&search=Search");
		exit;
	});

	$app->get("/clothing/:clothing_id", function($clothing_id) {
		User::verifyLogin();
		$clothing = new Clothing();
		$clothing->getById($clothing_id);
		
		$page = new PageClothing();
		
		$page ->setTpl("clothing-update", array(
			"clothing"=>$clothing->getValues()
		));
	});

	$app->post("/clothing/:clothing_id", function($clothing_id) {
		User::verifyLogin();
		$clothing = new Clothing();
		$clothing->getById($clothing_id);
		if (isset($_POST)) {
			$ppost = Metodo::convertDateToDataBase(["dateout"=>$_POST["dateout"], "datein"=>$_POST["datein"]]);
			foreach ($ppost as $key => $value) {
				$_POST[$key] = $value;
			}
			$_POST["user_id"] = $_SESSION["User"]["user_id"];
		}

		$clothing->setData($_POST);
		
		$msg = $clothing->update();
		
		header("Location: /clothing?msg=".$msg);
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
		
		$page = new PageMaterial();
		$page->setTpl("material", array(
			"material"=>$material[0],
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

		$user_id["user_id"] = $_SESSION["User"]["user_id"];
		$material->setdata($user_id);
		
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
/*										Rotas do Hidrante								*/
/*======================================================================================*/

	$app->get('/hydrant', function() {
		User::verifyLogin();
		
		$company["hydrant"]	= NULL;
		$company["search"] 		= NULL;
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 
		
		$hydrant	= Metodo::selectRegister($company, "Hydrant");
		
		$page = new PageHydrant();
		$page->setTpl("hydrant", array(
			"hydrants"=>$hydrant[0],
			"pgs"=>$hydrant[1],
			"msg"=>$msg
		));
	});

	$app->get('/hydrant/create', function() {
		User::verifyLogin();
		
		$company["hydrant"]		= NULL;
		
		$locations = Location::listAll($company);
		$locais = Local::listAll($company);

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 
	
		$page = new PageHydrant();
	
		$page->setTpl("hydrant-create",array(
			"msg"=>$msg,
			"locations"=>$locations,
			"locais"=>$locais
		));
		
	});

	$app->post('/hydrant/create', function() {
		User::verifyLogin();
		
		$hydrant = new Hydrant();
		
		$_POST["user_id"] = $_SESSION["User"]["user_id"];
		$_POST["person_id"] = $_SESSION["User"]["person_id"];
		
		$hydrant->setData($_POST);
		
		$msg = $hydrant->save();
		
		header("Location: /hydrant/create?msg=$msg");
		exit;
		
	});

	$app->get("/hydrant/:hydrant_id/delete", function ($hydrant_id){
		User::verifyLogin();
		$hydrant = new Hydrant();
		$hydrant->getById($hydrant_id);
		
		$user_id["user_id"] = $_SESSION["User"]["user_id"];
		$hydrant->setdata($user_id);
		
		$msg = $hydrant->delete();

		header("Location: /hydrant?msg=".$msg."&daydate=&date_fim=&search=Search");
		exit;
	});

	$app->get('/hydrant/:hydrant_id', function($hydrant_id) {
		User::verifyLogin();

		$company["hydrant"]		= NULL;
		
		$locations = Location::listAll($company);
		$locais = Local::listAll($company);

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		}

		$hydrant = new Hydrant();
		$hydrant->getById($hydrant_id);
		
		$page = new PageHydrant();
		
		$page ->setTpl("hydrant-update", array(
			"hydrant"=>$hydrant->getValues(),
			"msg"=>$msg,
			"locations"=>$locations,
			"locais"=>$locais
		));
	});

	$app->post('/hydrant/:hydrant_id', function($hydrant_id) {
		User::verifyLogin();
		$hydrant = new Hydrant();
		$hydrant->getById($hydrant_id);
		
		
		$_POST["user_id"] = $_SESSION["User"]["user_id"];
		$_POST["person_id"] = $_SESSION["User"]["person_id"];

		$hydrant->setData($_POST);
		
		$msg = $hydrant->update();
		
		header("Location: /hydrant?msg=".$msg);
		exit;
	});

/*======================================================================================*/
/*								Rotas do Histórico do Hidrante							*/
/*======================================================================================*/
		
	$app->get('/historicH', function() {
		User::verifyLogin();
		
		$company["historic"]		= NULL;
		$company["daydate"]	    	= NULL;
		$company["date_fim"]    	= NULL;
		$company["search"] 			= NULL;
		$company["hydrant_id"]		= $_GET["hydrant_id"];

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
		
		$historic	= Metodo::selectRegister($company, "HistoricH");
		if ($historic[0] == NULL) {
			$historic[0][0] = ["hydrant_id"=>$_GET["hydrant_id"],"historic_id"=> NULL ];
		}

		$page = new PageHistoricH();
		
		$page->setTpl("historic", array(
			"hydrants"=>$historic[0],
			"pgs"=>$historic[1],
			"msg"=>$msg
		));
		
	});

	$app->get('/historicH/create', function() {
		User::verifyLogin();
		
		if (isset($_GET["hydrant_id"])) {
			$hydrant_id = $_GET["hydrant_id"];
		}
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 
		
		$date = explode(" ",date('d-m-Y H:i'));
		$dt["date"]		= $date[0];
		
		$page = new PageHistoricH();

		$page->setTpl("historic-create",array(
			"msg"=>$msg,
			"date"=>$dt,
			"hydrant"=>$hydrant_id
		));
		
	});

	$app->post('/historicH/create', function() {
		User::verifyLogin();
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 
		
		$fireexting = new HistoricH();
		
		$ppost = Metodo::convertDateToDataBase(["daydate"=>$_POST["daydate"]]);
		
		foreach ($ppost as $key => $value) {
			$_POST[$key] = $value;
		}
		
		$_POST["user_id"] = $_SESSION["User"]["user_id"];
		$hydrant_id = $_POST["hydrant_id"];
		$fireexting->setData($_POST);
		
		$msg = $fireexting->save();
		
		header("Location: /historicH/create?msg=$msg&hydrant_id=$hydrant_id");
		exit;
		
	});

	$app->get('/historicH/:historic_id/delete', function($historic_id) {
		User::verifyLogin();
		$historic = new HistoricH();
		$historic->getById($historic_id);

		$hydrant_id = $historic->gethydrant_id();

		$user_id["user_id"] = $_SESSION["User"]["user_id"];
		$historic->setdata($user_id);
		
		$msg = $historic->delete();
		
		header("Location: /historicH?msg=$msg&hydrant_id=$hydrant_id");
		exit;
		
	});

	$app->get('/historicH/:historic_id', function($historic_id) {
		User::verifyLogin();
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		}

		$historic = new HistoricH();
		$historic->getbyid($historic_id);
		
		$page = new PageHistoricH();
		
		$page ->setTpl("historic-update", array(
			"historic"=>$historic->getValues(),
			"msg"=>$msg
		));
	});

	$app->post('/historicH/:historic_id', function($historic_id) {
		User::verifyLogin();
		$historic = new HistoricH();
		$historic->getbyid($historic_id);
		$hydrant_id = $_POST['hydrant_id'];

		if (isset($_POST)) {
			$ppost = Metodo::convertDateToDataBase(["daydate"=>$_POST["daydate"]]);
			foreach ($ppost as $key => $value) {
				$_POST[$key] = $value;
			}
			$_POST["user_id"] = $_SESSION["User"]["user_id"];
		}

		$historic->setData($_POST);
		
		$msg = $historic->update();
		
		header("Location: /historicH?pg=1&msg=$msg&hydrant_id=$hydrant_id");
		exit;
	});

/*======================================================================================*/
/*								Rotas do Ar Condicionado								*/
/*======================================================================================*/

	$app->get('/airconditioning', function() {
		User::verifyLogin();
		$company["daydate"]	    = NULL;
		$company["date_fim"]    = NULL;
		$company["search"] 		= NULL;
		$company["airconditioning"]	= NULL;

		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 
		
		$airconditioning	= Metodo::selectRegister($company, "AirConditioning");
		
		$page = new PageAirConditioning();
		$page->setTpl("airconditioning", array(
			"airconditionings"=>$airconditioning[0],
			"pgs"=>$airconditioning[1],
			"msg"=>$msg
		));
	});

	$app->get('/airconditioning/create', function() {
		User::verifyLogin();
		
		$company["daydate"]	    = NULL;
		$company["date_fim"]    = NULL;
		$company["search"] 		= NULL;
		$company["airconditioning"]	= NULL;
		
		$locations = Location::listAll($company);
		$locais = Local::listAll($company);

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 

		$page = new PageAirConditioning();

		$page->setTpl("airconditioning-create",array(
			"msg"=>$msg,
			"locations"=>$locations,
			"locais"=>$locais
		));
		
	});

	$app->post('/airconditioning/create', function() {
		User::verifyLogin();
		
		$airconditioning = new AirConditioning();
		
		$_POST["user_id"] = $_SESSION["User"]["user_id"];
		$_POST["person_id"] = $_SESSION["User"]["person_id"];
		
		$airconditioning->setData($_POST);
		
		$msg = $airconditioning->save();
		
		header("Location: /airconditioning/create?msg=$msg");
		exit;
		
	});

	$app->get("/airconditioning/:airconditioning_id/delete", function ($airconditioning_id){
		User::verifyLogin();
		$airconditioning = new AirConditioning();
		$airconditioning->getById($airconditioning_id);
		
		$user_id["user_id"] = $_SESSION["User"]["user_id"];
		$airconditioning->setdata($user_id);
		
		$msg = $airconditioning->delete();

		header("Location: /airconditioning?msg=".$msg."&daydate=&date_fim=&search=Search");
		exit;
	});

	$app->get('/airconditioning/:airconditioning_id', function($airconditioning_id) {
		User::verifyLogin();

		$company["daydate"]	    = NULL;
		$company["date_fim"]    = NULL;
		$company["search"] 		= NULL;
		$company["airconditioning"]	= NULL;
		
		$locations = Location::listAll($company);
		$locais = Local::listAll($company);

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		}

		$airconditioning = new AirConditioning();
		$airconditioning->getById($airconditioning_id);
		
		$page = new PageAirConditioning();
		
		$page ->setTpl("airconditioning-update", array(
			"airconditioning"=>$airconditioning->getValues(),
			"msg"=>$msg,
			"locations"=>$locations,
			"locais"=>$locais
		));
	});

	$app->post('/airconditioning/:airconditioning_id', function($airconditioning_id) {
		User::verifyLogin();
		$airconditioning = new AirConditioning();
		$airconditioning->getById($airconditioning_id);
				
		$_POST["user_id"] = $_SESSION["User"]["user_id"];
		$_POST["person_id"] = $_SESSION["User"]["person_id"];

		$airconditioning->setData($_POST);
		
		$msg = $airconditioning->update();
		
		header("Location: /airconditioning?msg=".$msg);
		exit;
	});

/*======================================================================================*/
/*						Rotas do Histórico do Ar Condicionado							*/
/*======================================================================================*/
		
	$app->get('/historicA', function() {
		User::verifyLogin();
		
		$company["historic"]		= NULL;
		$company["daydate"]	    	= NULL;
		$company["search"] 			= NULL;
		$company["airconditioning_id"]	= $_GET["airconditioning_id"];

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
		
		$historic	= Metodo::selectRegister($company, "HistoricA");
		if ($historic[0] == NULL) {
			$historic[0][0] = ["airconditioning_id"=>$_GET["airconditioning_id"],"historic_id"=> NULL ];
		}

		$page = new PageHistoricA();
		
		$page->setTpl("historic", array(
			"airconditionings"=>$historic[0],
			"pgs"=>$historic[1],
			"msg"=>$msg
		));
		
	});

	$app->get('/historicA/create', function() {
		User::verifyLogin();
		if (isset($_GET["airconditioning_id"])) {
			$airconditioning_id = $_GET["airconditioning_id"];
		}
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 

		$month = date('M');
		
		if ($month == 'Jan') { $month = 'JANIERO';
		}
		if ($month == 'Fev') { $month = 'FEVERIEO';
		}
		if ($month == 'Mar') { $month = 'MARÇO';
		}
		if ($month == 'Abr') { $month = 'ABRIL';
		}
		if ($month == 'Mai') { $month = 'MAIO';
		}
		if ($month == 'Jun') { $month = 'JUNHO';
		}
		if ($month == 'Jul') { $month = 'JULHO';
		}
		if ($month == 'Aug') { $month = 'AGOSTO';
		}
		if ($month == 'Sep') { $month = 'SETEMBRO';
		}
		if ($month == 'Oct') { $month = 'OUTUBRO';
		}
		if ($month == 'Nov') { $month = 'NOVEMBRO';
		}
		if ($month == 'Dec') { $month = 'DEZEMBRO';
		}
		
		$page = new PageHistoricA();

		$page->setTpl("historic-create",array(
			"msg"=>$msg,
			"airconditioning"=>$airconditioning_id,
			"month"=>$month
		));
		
	});

	$app->post('/historicA/create', function() {
		User::verifyLogin();
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 
		
		$airconditioning = new HistoricA();
		
		$ppost = Metodo::convertDateToDataBase(["daydate"=>$_POST["daydate"]]);
		
		foreach ($ppost as $key => $value) {
			$_POST[$key] = $value;
		}
		
		$_POST["user_id"] = $_SESSION["User"]["user_id"];
		$airconditioning_id = $_POST["airconditioning_id"];
		$airconditioning->setData($_POST);
		
		$msg = $airconditioning->save();
		
		header("Location: /historicA/create?msg=$msg&airconditioning_id=$airconditioning_id");
		exit;
		
	});

	$app->get('/historicA/:historic_id/delete', function($historic_id) {
		User::verifyLogin();
		$historic = new HistoricA();
		$historic->getById($historic_id);

		$airconditioning_id = $historic->getairconditioning_id();

		$user_id["user_id"] = $_SESSION["User"]["user_id"];
		$historic->setdata($user_id);
		
		$msg = $historic->delete();
		
		header("Location: /historicA?msg=$msg&airconditioning_id=$airconditioning_id");
		exit;
		
	});

	$app->get('/historicA/:historic_id', function($historic_id) {
		User::verifyLogin();
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		}

		$historic = new HistoricA();
		$historic->getbyid($historic_id);
		
		$page = new PageHistoricA();
		
		$page ->setTpl("historic-update", array(
			"historic"=>$historic->getValues(),
			"msg"=>$msg
		));
	});

	$app->post('/historicA/:historic_id', function($historic_id) {
		User::verifyLogin();
		$historic = new HistoricA();
		$historic->getbyid($historic_id);
		$airconditioning_id = $_POST['airconditioning_id'];

		if (isset($_POST)) {
			$ppost = Metodo::convertDateToDataBase(["daydate"=>$_POST["daydate"]]);
			foreach ($ppost as $key => $value) {
				$_POST[$key] = $value;
			}
			$_POST["user_id"] = $_SESSION["User"]["user_id"];
		}

		$historic->setData($_POST);
		
		$msg = $historic->update();
		
		header("Location: /historicA?pg=1&msg=$msg&airconditioning_id=$airconditioning_id");
		exit;
	});

/*======================================================================================*/
/*					Rotas do Plano Anual de Manutenção Preventiva						*/
/*======================================================================================*/
	
	$app->get('/anualplan', function() {
		User::verifyLogin();
		
		$company["anualplan"]		= NULL;
		$company["daydate"]	    	= NULL;
		$company["search"] 			= NULL;

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
		
		$anualplan	= Metodo::selectRegister($company, "AnualPlan");

		$page = new PageAnualPlan();
		$page->setTpl("anualplan", array(
			"anualplans"=>$anualplan[0],
			"pgs"=>$anualplan[1],
			"msg"=>$msg
		));
		
	});

	$app->get('/anualplan/create', function() {
		User::verifyLogin();
		$company["anualplan"]	    = 'anualplan';
		$company["daydate"]	    	= NULL;
		$company["search"] 			= NULL;

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		}

		$equipaments	= Metodo::selectRegister($company, "Equipament");
		$locais			= Metodo::selectRegister($company, "Local");
		$locations		= Metodo::selectRegister($company, "Location");
		$responsables	= Metodo::selectRegister($company, "Responsable");
	
		$page = new PageAnualPlan();
		$page->setTpl('anualplan-create', array(
			"equipaments"=>$equipaments[0],
			"locais"=>$locais[0],
			"locations"=>$locations[0],
			"responsables"=>$responsables[0],
			"msg"=>$msg
		));
	});

	$app->post('/anualplan/create', function() {
		User::verifyLogin();
		
		$anualplan = new AnualPlan();
		$ppost = Metodo::convertDateToDataBase(["dtprevision"=>$_POST["dtprevision"]]);

		foreach ($ppost as $key => $value) {
			$_POST[$key] = $value;
		}
		
		$anualplan->setData($_POST);
		
		$msg = $anualplan->saveA();

		header("Location: /anualplan/create?msg=$msg");
		exit;

	});

	$app->get("/anualplan/:anualplan_id/delete", function ($anualplan_id){
		User::verifyLogin();
		
		$anualplan = new AnualPlan();
		$anualplan->getByIdA($anualplan_id);
		
		$user_id["user_id"] = $_SESSION["User"]["user_id"];
		$anualplan->setdata($user_id);
		
		$msg = $anualplan->deleteA();
		
		header("Location: /anualplan?msg=".$msg);
		exit;
	});

	$app->get('/anualplan/:anualplan_id', function($anualplan_id) {
		User::verifyLogin();
		
		$company["anualplan"]		= NULL;
		$company["daydate"]	    	= NULL;
		$company["search"] 			= NULL;

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		}

		$equipaments	= Metodo::selectRegister($company, "Equipament");
		$locais		= Metodo::selectRegister($company, "Local");
		$locations		= Metodo::selectRegister($company, "Location");
		$responsables	= Metodo::selectRegister($company, "Responsable");

		$anualplan = new AnualPlan();
		$anualplan->getByIdA($anualplan_id);
		
		$page = new PageAnualPlan();
		$page->setTpl('anualplan-update', array(
			"anualplan" =>$anualplan->getValues(),
			"equipaments"=>$equipaments[0],
			"locations"=>$locations[0],
			"locais"=>$locais[0],
			"responsables"=>$responsables[0],
			"msg"=>$msg
		));
	});

	$app->post('/anualplan/:anualplan_id', function($anualplan_id) {
		User::verifyLogin();
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		}
		if (isset($_POST)) {
			$ppost = Metodo::convertDateToDataBase(["dtprevision"=>$_POST["dtprevision"]]);
			foreach ($ppost as $key => $value) {
				$_POST[$key] = $value;
			}
			$_POST["user_id"] = $_SESSION["User"]["user_id"];
		}

		$anualplan = new AnualPlan();
		$anualplan->getByIdA($anualplan_id);
		
		$anualplan->setData($_POST);
		$msg = $anualplan->updateA();
		
		header("Location: /anualplan?msg=".$msg);
		exit;
		
	});

/*======================================================================================*/
/*									Rotas do Equipamento								*/
/*======================================================================================*/

	$app->get('/equipament', function() {
		User::verifyLogin();

		$company["equipament"]		= NULL;
		$company["daydate"]	    	= NULL;
		$company["search"] 			= NULL;

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 

		$equipaments	= Metodo::selectRegister($company, "Equipament");
		
		$page = new PageAnualPlan();
		
		$page->setTpl("equipament", array(
			"equipaments"=>$equipaments[0],
			"pgs"=>$equipaments[1],
			"msg"=>$msg
		));
	});

	$app->get('/equipament/create', function() {
		User::verifyLogin();
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		}

		$page = new PageAnualPlan();
		$page->setTpl('equipament-create', array(
			"msg"=>$msg
		));
	});

	$app->post('/equipament/create', function() {
		User::verifyLogin();
		
		$equipament = new AnualPlan();

		$equipament->setData($_POST);
		
		$msg = $equipament->saveE();

		header("Location: /equipament/create?msg=$msg");
		exit;

	});

	$app->get("/equipament/:equipament_id/delete", function ($equipament_id){
		User::verifyLogin();
		$equipament = new AnualPlan();
		$equipament->getByIdE($equipament_id);
		
		$user_id["user_id"] = $_SESSION["User"]["user_id"];
		$equipament->setdata($user_id);
		
		$msg = $equipament->deleteE();
		
		header("Location: /equipament?msg=".$msg);
		exit;
	});

	$app->get('/equipament/:equipament_id', function($equipament_id) {
		User::verifyLogin();
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		}

		$equipament = new AnualPlan();
		$equipament->getByIdE($equipament_id);
		
		$page = new PageAnualPlan();
		$page->setTpl('equipament-update', array(
			"equipament" =>$equipament->getValues(),
			"msg"=>$msg
		));
	});

	$app->post('/equipament/:equipament_id', function($equipament_id) {
		User::verifyLogin();
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		}
		$equipament = new AnualPlan();
		$equipament->getByIdE($equipament_id);
		
		$equipament->setData($_POST);
		$msg = $equipament->updateE();
		
		header("Location: /equipament?msg=".$msg);
		exit;
		
	});

/*======================================================================================*/
/*										Rotas da Local									*/
/*======================================================================================*/
	
	$app->get('/local', function() {
		User::verifyLogin();

		$company["local"]		= NULL;
		$company["daydate"]	    	= NULL;
		$company["search"] 			= NULL;

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 

		$locais	= Metodo::selectRegister($company, "Local");
		
		$page = new PageLocal();
		
		$page->setTpl("local", array(
			"locais"=>$locais[0],
			"pgs"=>$locais[1],
			"msg"=>$msg
		));
	});

	$app->get('/local/create', function() {
		User::verifyLogin();
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		}

		$page = new PageLocal();
		$page->setTpl('local-create', array(
			"msg"=>$msg
		));
	});

	$app->post('/local/create', function() {
		User::verifyLogin();
		
		$local = new Local();

		$local->setData($_POST);
		
		$msg = $local->save();

		header("Location: /local/create?msg=$msg");
		exit;

	});

	$app->get("/local/:local_id/delete", function ($local_id){
		User::verifyLogin();
		$local = new Local();
		$local->getById($local_id);

		$user_id["user_id"] = $_SESSION["User"]["user_id"];
		$local->setdata($user_id);

		$msg = $local->delete();
		
		header("Location: /local?msg=".$msg);
		exit;
	});

	$app->get('/local/:local_id', function($local_id) {
		User::verifyLogin();
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		}

		$local = new Local();
		$local->getById($local_id);
		
		$page = new PageLocal();
		$page->setTpl('local-update', array(
			"local" =>$local->getValues(),
			"msg"=>$msg
		));
	});

	$app->post('/local/:local_id', function($local_id) {
		User::verifyLogin();
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		}
		$local = new Local();
		$local->getById($local_id);
		
		$local->setData($_POST);
		$msg = $local->update();
		
		header("Location: /local?msg=".$msg);
		exit;
		
	});

/*======================================================================================*/
/*									Rotas do Responsável								*/
/*======================================================================================*/
	
	$app->get('/responsable', function() {
		User::verifyLogin();

		$company["responsable"]		= NULL;
		$company["daydate"]	    	= NULL;
		$company["search"] 			= NULL;

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 

		$responsables	= Metodo::selectRegister($company, "Responsable");
		
		$page = new PageAnualPlan();
		
		$page->setTpl("responsable", array(
			"responsables"=>$responsables[0],
			"pgs"=>$responsables[1],
			"msg"=>$msg
		));
	});

	$app->get('/responsable/create', function() {
		User::verifyLogin();
		$classification = Visitant::listClassification();
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		}

		$page = new PageAnualPlan();
		$page->setTpl('responsable-create', array(
			"classifications" =>$classification,
			"msg"=>$msg
		));
	});

	$app->post('/responsable/create', function() {
		User::verifyLogin();

		if ($_POST["rg_person"] == '') {
			$_POST["rg_person"] = '999999';
		}
		$user = new User();

		$date["daydate"] = date('d-m-Y');

		$ppost = Metodo::convertDateToDataBase(["daydate"=>$date["daydate"]]);

		foreach ($ppost as $key => $value) {
			$_POST[$key] = $value;
		}

		$_POST["situation"] = '0';
		$_POST["email"] = '';
		$_POST["photo"] = '';
		$_POST["login"] = '';
		$_POST["pass"] = '';
		$_POST["inadmin"] = '';

		$user->setData($_POST);
		
		$msg = $user->save();

		header("Location: /responsable/create?msg=$msg");
		exit;

	});

	$app->get("/responsable/:responsable_id/delete", function ($responsable_id){
		User::verifyLogin();
		$responsable = new User();
		$responsable->get($responsable_id);

		$user_id["user_id"] = $_SESSION["User"]["user_id"];
		$responsable->setdata($user_id);

		$msg = $responsable->delete();
		
		header("Location: /responsable?msg=".$msg);
		exit;
	});

	$app->get('/responsable/:responsable_id', function($responsable_id) {
		User::verifyLogin();
		$classification = Visitant::listClassification();
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		}

		$responsable = new User();
		$responsable->get($responsable_id);
		
		$page = new PageAnualPlan();
		$page->setTpl('responsable-update', array(
			"responsable" =>$responsable->getValues(),
			"classifications" =>$classification,
			"msg"=>$msg
		));
	});

	$app->post('/responsable/:responsable_id', function($responsable_id) {
		User::verifyLogin();
		
		if ($_POST["rg_person"] == '') {
			$_POST["rg_person"] = '999999';
		}
		
		$_POST["situation"] = '0';
		$_POST["email"] = '';
		$_POST["photo"] = '';
		$_POST["login"] = '';
		$_POST["pass"] = '';
		$_POST["inadmin"] = '';
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		}
		
		$responsable = new User();
		$responsable->get($responsable_id);
		
		$responsable->setData($_POST);
		$msg = $responsable->update();
		
		header("Location: /responsable?msg=".$msg);
		exit;
		
	});

/******************************************************************************************/

/*======================================================================================*/
/*									Rotas da Localização								*/
/*======================================================================================*/
	
	$app->get('/location', function() {
		User::verifyLogin();

		$company["location"]		= NULL;
		$company["daydate"]	    	= NULL;
		$company["search"] 			= NULL;

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 

		$locations	= Metodo::selectRegister($company, "Location");
		
		$page = new PageLocation();
		
		$page->setTpl("location", array(
			"locations"=>$locations[0],
			"pgs"=>$locations[1],
			"msg"=>$msg
		));
	});

	$app->get('/location/create', function() {
		User::verifyLogin();
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		}

		$page = new PageLocation();
		$page->setTpl('location-create', array(
			"msg"=>$msg
		));
	});

	$app->post('/location/create', function() {
		User::verifyLogin();
		
		$location = new Location();

		$location->setData($_POST);
		
		$msg = $location->save();

		header("Location: /location/create?msg=$msg");
		exit;

	});

	$app->get("/location/:location_id/delete", function ($location_id){
		User::verifyLogin();
		$location = new Location();
		$location->getById($location_id);

		$user_id["user_id"] = $_SESSION["User"]["user_id"];
		$location->setdata($user_id);

		$msg = $location->delete();
		
		header("Location: /location?msg=".$msg);
		exit;
	});

	$app->get('/location/:location_id', function($location_id) {
		User::verifyLogin();
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		}

		$location = new Location();
		$location->getById($location_id);
		
		$page = new PageLocation();
		$page->setTpl('location-update', array(
			"location" =>$location->getValues(),
			"msg"=>$msg
		));
	});

	$app->post('/location/:location_id', function($location_id) {
		User::verifyLogin();
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		}
		$location = new Location();
		$location->getById($location_id);
		
		$location->setData($_POST);
		$msg = $location->update();
		
		header("Location: /location?msg=".$msg);
		exit;
		
	});





/*======================================================================================*/
/*								Rotas do Controle Geral									*/
/*======================================================================================*/

	$app->get('/generalcontrol', function() {
		User::verifyLogin();

		$company["generalcontrol"]	= NULL;
		$company["daydate"]	    	= NULL;
		$company["search"] 			= NULL;

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 

		$generalcontrols	= Metodo::selectRegister($company, "GeneralControl");
		
		$page = new PageGeneralControl();
		
		$page->setTpl("generalcontrol", array(
			"generalcontrols"=>$generalcontrols[0],
			"pgs"=>$generalcontrols[1],
			"msg"=>$msg
		));
	});

	$app->get('/generalcontrol/create', function() {
		User::verifyLogin();
		$company["generalcontrol"]	= NULL;
		$company["daydate"]	    	= NULL;
		$company["search"] 			= NULL;

		$locations = Location::listAll($company);
		$locais = Local::listAll($company);
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		}

		$page = new PageGeneralControl();
		$page->setTpl('generalcontrol-create', array(
			"locations"=>$locations,
			"locais" =>$locais,
			"msg"=>$msg
		));
	});

	$app->post('/generalcontrol/create', function() {
		User::verifyLogin();
		
		$generalcontrol = new GeneralControl();

		$generalcontrol->setData($_POST);
		
		$msg = $generalcontrol->save();

		header("Location: /generalcontrol/create?msg=$msg");
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
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
		}

		$page = new PageAdmin([
			"header"=> false,
			"footer"=> false

		]);
		$page->setTpl("login", array(
			"msg"=>$msg
		));
		
	});

	$app->post('/admin/login', function() {
		
		User::login($_POST["login"], $_POST["pass"]);
		
		header("Location: /visitant");
		exit;
		
	});

	$app->get('/admin/logout', function() {
		
		User::logout();
		header("Location: /admin/login");
		exit;
	});

	$app->get("/admin/forgot", function(){
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
		}

		$page = new PageAdmin([
			"header"=>false,
			"footer"=>false
		]);
		$page->setTpl("forgot", array(
			"msg"=>$msg
		));
	});

	$app->post("/admin/forgot", function(){
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
		}
		
		$user = User::getForgot($_POST["email"]);
		header("Location: /admin/forgot/sent");
		exit;
	});

	$app->get("/admin/forgot/sent", function(){
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
		}

		$page = new PageAdmin([
			"header"=>false,
			"footer"=>false
		]);
		$page->setTpl("forgot-sent",array(
			"msg"=>$msg
		));
	});

	$app->get("/admin/forgot/reset", function(){

		$user = User::validForgotDecrypt($_GET["code"]);
		$page = new PageAdmin([
			"header"=>false,
			"footer"=>false
		]);
		$page->setTpl("forgot-reset", array(
			"name"=>$user["name_person"],
			"code"=>$_GET["code"]
		));
	});

	$app->post("/admin/forgot/reset", function(){
		
		$_POST['password'] = password_hash($_POST["password"], PASSWORD_DEFAULT, [
			"cost"=>12
			]);
		$forgot = User::validForgotDecrypt($_POST["code"]);
		User::setForgotUsed($forgot["recovery_id"]);
		$user= new User();
		$user->get((int)$forgot["user_id"]);
		$user->setPassword($_POST["password"]);

		$page = new PageAdmin([
			"header"=>false,
			"footer"=>false
		]);
		$page->setTpl("forgot-reset-success");
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
			$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];
		
			if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
				$mess = explode(':', $_GET["msg"]);
				$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
				$_GET["msg"] = '';
			}
			$page = new PageUser();
			$page->setTpl("users-create", array(
				"msg"=>$msg
			));
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

/*======================================================================================*/
/*									Execução do aplicativo								*/
/*======================================================================================*/

	$app->run();

?>
	