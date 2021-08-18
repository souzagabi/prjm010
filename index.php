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

		User::verifyLogin();
		
		header("Location: /visitant");
		exit;
		
	});

	$app->get('/visitant', function() 
	{
		
		User::verifyLogin();

		$company["name_person"]	= NULL;
		$company["visitants"]	= NULL;
		$company["search"]		= NULL;

		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
		}

		if (isset($_GET["search"])) {
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
	
			foreach ($_GET as $key => $value) {
				$company[$key] = $value;
			}
		}
		$firstday 	= '1';
		$lastday 	= date('t');
		$year 		= date('Y');
		$month 		= date('m');
		
		if ((!isset($_GET["daydate"]) || ($_GET["daydate"] == '') ) && (!isset($_GET["date_fim"]) || ($_GET["date_fim"] == ''))) {
			$company["daydate"] 	= $year.'-'.$month.'-'.$firstday;
			$company["date_fim"] 	= $year.'-'.$month.'-'.$lastday;
		}
		
		$company["visitants"]	= "visitants";
	
		$visitants = Metodo::selectRegister($company, "Visitant");
		
		if ($visitants[0] == NULL) {
			$visitants[0][0] = ["visitant_id"=>NULL ];
		}
		
		if (isset($visitants[0][0]["MESSAGE"])) {
			$msg = Metodo::divideMessage($visitants[0][0]["MESSAGE"]);
		} else {
			$visitants[0][0]["MESSAGE"] = 'VAZIO';
		}
		
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
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];		

		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
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
			$_POST["photo"] = null;
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
		User::verifyLogin();
		
		$dir = 'image';
		$classifications = Visitant::listClassification();
		
		$visitant = new Visitant();
		$visitant->getById($visitant_id);
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];	
		
		if (isset($visitant->getValues()["MESSAGE"])) {
			header("Location: /visitant?msg=".$visitant->getValues()["MESSAGE"]);
			exit;
		} else {
			$visitant->setData(['MESSAGE'=> 'VAZIO']);
		}

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
			"classifications"=>$classifications,
			"msg"=>$msg
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

/******************************************************************************************/

/*======================================================================================*/
/*										Rotas dos Resíduos								*/
/*======================================================================================*/

	$app->get('/residual', function() {
		User::verifyLogin();
		
		$company["residual"]	= NULL;
		$company["name_person"] = NULL;
		$company["search"] 		= NULL;
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
		} 

		if (isset($_GET["search"])) {
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
			foreach ($_GET as $key => $value) {
				$company[$key] = $value;
			}
		}
		
		$firstday 	= '1';
		$lastday 	= date('t');
		$year 		= date('Y');
		$month 		= date('m');
		
		if ((!isset($_GET["daydate"]) || ($_GET["daydate"] == '') ) && (!isset($_GET["date_fim"]) || ($_GET["date_fim"] == ''))) {
			$company["daydate"] 	= $year.'-'.$month.'-'.$firstday;
			$company["date_fim"] 	= $year.'-'.$month.'-'.$lastday;
		}

		$residual	= Metodo::selectRegister($company, "Residual");
		
		if ($residual[0] == NULL) {
			$residual[0][0] = ["residual_id"=>NULL ];
		}
		
		if (isset($residual[0][0]["MESSAGE"])) {
			$msg = Metodo::divideMessage($residual[0][0]["MESSAGE"]);
			$residual[0][0] = ["residual_id"=>NULL ];
		} else {
			$residual[0][0]["MESSAGE"] = 'VAZIO';
		}

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

		$locations		= Location::listAll($company);
		$locais			= Local::listAll($company);
		$responsables	= AnualPlan::listResponsableAll($company);

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];		

		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
		} 

		$date = explode(" ",date('d-m-Y H:i'));
		$dt["date"]		= $date[0];
		$dt1["hour"]	= $date[1];
		
		$page = new PageResidual();

		$page->setTpl("residual-create",array(
			"msg"=>$msg,
			"date"=>$dt,
			"hour"=>$dt1,
			"responsables"=>$responsables,
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
 

		$locations 		= Location::listAll($company);
		$locais 		= Local::listAll($company);
		$responsables	= AnualPlan::listResponsableAll($company);

		$residual = new Residual();
		$residual->getById($residual_id);
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];	
		
		if (isset($residual->getValues()["MESSAGE"])) {
			header("Location: /residual?msg=".$residual->getValues()["MESSAGE"]);
			exit;
		} else {
			$residual->setData(['MESSAGE'=> 'VAZIO']);
		}
		$page = new PageResidual();
		
		$page ->setTpl("residual-update", array(
			"residual"=>$residual->getValues(),
			"locations"=>$locations,
			"locais" =>$locais,
			"responsables" =>$responsables,
			"msg" =>$msg
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
/******************************************************************************************/

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
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
		} 

		if (isset($_GET["search"])) {
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
			foreach ($_GET as $key => $value) {
				$company[$key] = $value;
			}
		}
		
		$firstday 	= '1';
		$lastday 	= date('t');
		$year 		= date('Y');
		$month 		= date('m');
		
		if ((!isset($_GET["daydate"]) || ($_GET["daydate"] == '') ) && (!isset($_GET["date_fim"]) || ($_GET["date_fim"] == ''))) {
			$company["daydate"] 	= $year.'-'.$month.'-'.$firstday;
			$company["date_fim"] 	= $year.'-'.$month.'-'.$lastday;
		}
		
		$goods	= Metodo::selectRegister($company, "Goods");
		
		if ($goods[0] == NULL) {
			$goods[0][0] = ["goods_id"=>NULL ];
		}
		
		if (isset($goods[0][0]["MESSAGE"])) {
			$msg = Metodo::divideMessage($goods[0][0]["MESSAGE"]);
		} else {
			$goods[0][0]["MESSAGE"] = 'VAZIO';
		}

		$page = new PageGoods();
		$page->setTpl("goods", array(
			"goods"=>$goods[0],
			"pgs"=>$goods[1],
			"msg"=>$msg
		));
		
	});

	$app->get('/goods/create', function() {
		User::verifyLogin();

		$company["goods"]	= NULL;

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
		} 

		$responsables	= Metodo::selectRegister($company, "Responsable");

		$date = explode(" ",date('d-m-Y H:i'));
		$dt["date"]		= $date[0];
		$dt1["hour"]	= $date[1];

		$page = new PageGoods();

		$page->setTpl("goods-create",array(
			"msg"=>$msg,
			"responsables"=>$responsables[0],
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

		$company["goods"]	= NULL;

		$goods = new Goods();
		$goods->getById($goods_id);
		
		$responsables	= Metodo::selectRegister($company, "Responsable");

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];	
		
		if (isset($goods->getValues()["MESSAGE"])) {
			header("Location: /goods?msg=".$goods->getValues()["MESSAGE"]);
			exit;
		} else {
			$goods->setData(['MESSAGE'=> 'VAZIO']);
		}
		
		$page = new PageGoods();
		
		$page ->setTpl("goods-update", array(
			"goods"=>$goods->getValues(),
			"responsables"=>$responsables[0],
			"msg"=>$msg
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
/******************************************************************************************/

/*======================================================================================*/
/*										Rotas dos Nobreak								*/
/*======================================================================================*/

	$app->get('/nobreak', function() {
		User::verifyLogin();
		
		$company["nobreak"]		= NULL;
		$company["location"] 	= NULL;
		$company["serialnumber"]= NULL;
		$company["search"] 		= NULL;
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
		} 
		
		if (isset($_GET["search"])) {
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
	
			foreach ($_GET as $key => $value) {
				$company[$key] = $value;
			}
		}
		$firstday 	= '1';
		$lastday 	= date('t');
		$year 		= date('Y');
		$month 		= date('m');
		
		if ((!isset($_GET["daydate"]) || ($_GET["daydate"] == '') ) && (!isset($_GET["date_fim"]) || ($_GET["date_fim"] == ''))) {
			$company["daydate"] 	= $year.'-'.$month.'-'.$firstday;
			$company["date_fim"] 	= $year.'-'.$month.'-'.$lastday;
		}
		
		$nobreak	= Metodo::selectRegister($company, "Nobreak");
		
		if ($nobreak[0] == NULL) {
			$nobreak[0][0] = ["nobreak_id"=>NULL ];
		}
		
		if (isset($nobreak[0][0]["MESSAGE"])) {
			$msg = Metodo::divideMessage($nobreak[0][0]["MESSAGE"]);
		} else {
			$nobreak[0][0]["MESSAGE"] = 'VAZIO';
		}

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

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
		} 

		$date = explode(" ",date('d-m-Y H:i'));
		$dt["date"]		= $date[0];
		$dt1["hour"]	= $date[1];

		$locations = Location::listAll($company);
		$locais = Local::listAll($company);
		
		$responsables	= Metodo::selectRegister($company, "Responsable");

		$page = new PageNobreak();

		$page->setTpl("nobreak-create",array(
			"msg"=>$msg,
			"date"=>$dt,
			"hour"=>$dt1,
			"responsables"=>$responsables[0],
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
		$responsables	= Metodo::selectRegister($company, "Responsable");

		$nobreak = new Nobreak();
		$nobreak->getById($nobreak_id);
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];	
		
		if (isset($nobreak->getValues()["MESSAGE"])) {
			header("Location: /nobreak?msg=".$nobreak->getValues()["MESSAGE"]);
			exit;
		} else {
			$nobreak->setData(['MESSAGE'=> 'VAZIO']);
		}

		$page = new PageNobreak();
		
		$page ->setTpl("nobreak-update", array(
			"nobreak"=>$nobreak->getValues(),
			"locations"=>$locations,
			"responsables"=>$responsables[0],
			"locais"=>$locais,
			"msg"=>$msg
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
/******************************************************************************************/
	
/*======================================================================================*/
/*										Rotas do Extintor								*/
/*======================================================================================*/

	$app->get('/fireexting', function() {
		User::verifyLogin();
		
		$company["fireexting"]	= NULL;
		$company["daydate"]	    = NULL;
		$company["date_fim"]    = NULL;
		$company["search"] 		= NULL;
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
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
		
		if ($fireexting[0] == NULL) {
			$fireexting[0][0] = ["fireexting_id"=>NULL ];
		}
		
		if (isset($fireexting[0][0]["MESSAGE"])) {
			$msg = Metodo::divideMessage($fireexting[0][0]["MESSAGE"]);
		} else {
			$fireexting[0][0]["MESSAGE"] = 'VAZIO';
		}

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
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
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
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];	
		
		if (isset($fireexting->getValues()["MESSAGE"])) {
			header("Location: /fireexting?msg=".$fireexting->getValues()["MESSAGE"]);
			exit;
		} else {
			$fireexting->setData(['MESSAGE'=> 'VAZIO']);
		}

		$page = new PageFireExting();
		
		$page ->setTpl("fireexting-update", array(
			"fireexting"=>$fireexting->getValues(),
			"msg"=>$msg,
			"locations"=>$locations,
			"locais"=>$locais,
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
/******************************************************************************************/

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

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
		} 
		
		$historics	= Metodo::selectRegister($company, "HistoricE");
		if ($historics[0] == NULL) {
			$historics[0][0] = ["fireexting_id"=>$_GET["fireexting_id"],"historic_id"=> NULL ];
		}
		
		$page = new PageHistoricE();
		
		$page->setTpl("historic", array(
			"historics"=>$historics[0],
			"pgs"=>$historics[1],
			"msg"=>$msg
		));
		
	});

	$app->get('/historicE/create', function() {
		User::verifyLogin();
		if (isset($_GET["fireexting_id"])) {
			$fireexting_id = $_GET["fireexting_id"];
		}
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
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
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];	
		
		if (isset($historic->getValues()["MESSAGE"])) {
			header("Location: /historicE?msg=".$historic->getValues()["MESSAGE"]);
			exit;
		} else {
			$historic->setData(['MESSAGE'=> 'VAZIO']);
		}

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
/******************************************************************************************/

/*======================================================================================*/
/*										Rotas do Purificado								*/
/*======================================================================================*/
	$app->get('/purifier', function() {
		User::verifyLogin();
		
		$company["purifier"]		= NULL;
		$company["location"]	   	= NULL;
		$company["serialnumber"]   	= NULL;
		$company["search"] 			= NULL;

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
		} 
		
		if (isset($_GET["search"])) {
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
	
			foreach ($_GET as $key => $value) {
				$company[$key] = $value;
			}
		}
		$firstday 	= '1';
		$lastday 	= date('t');
		$year 		= date('Y');
		$month 		= date('m');
		
		if ((!isset($_GET["daydate"]) || ($_GET["daydate"] == '') ) && (!isset($_GET["date_fim"]) || ($_GET["date_fim"] == ''))) {
			$company["daydate"] 	= $year.'-'.$month.'-'.$firstday;
			$company["date_fim"] 	= $year.'-'.$month.'-'.$lastday;
		}
		
		$purifiers	= Metodo::selectRegister($company, "Purifier");
		
		if ($purifiers[0] == NULL) {
			$purifiers[0][0] = ["purifier_id"=>NULL ];
		}
		
		if (isset($purifiers[0][0]["MESSAGE"])) {
			$msg = Metodo::divideMessage($purifiers[0][0]["MESSAGE"]);
		} else {
			$purifiers[0][0]["MESSAGE"] = 'VAZIO';
		}

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

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
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
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];	
		
		if (isset($purifier->getValues()["MESSAGE"])) {
			header("Location: /purifier?msg=".$purifier->getValues()["MESSAGE"]);
			exit;
		} else {
			$purifier->setData(['MESSAGE'=> 'VAZIO']);
		}

		$page = new PagePurifier();
		
		$page ->setTpl("purifier-update", array(
			"purifier"=>$purifier->getValues(),
			"locations"=>$locations,
			"locais"=>$locais,
			"msg"=>$msg
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
/******************************************************************************************/

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

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
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
		
		if (isset($historic[0][0]["MESSAGE"])) {
			$msg = Metodo::divideMessage($historic[0][0]["MESSAGE"]);
		} else {
			$historic[0][0]["MESSAGE"] = 'VAZIO';
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
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
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
		
		$historic = new HistoricP();
		$historic->getbyid($historic_id);
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];	
		
		if (isset($historic->getValues()["MESSAGE"])) {
			header("Location: /historicP?msg=".$historic->getValues()["MESSAGE"]);
			exit;
		} else {
			$historic->setData(['MESSAGE'=> 'VAZIO']);
		}

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

/******************************************************************************************/
	
/*======================================================================================*/
/*										Rotas da Roupa									*/
/*======================================================================================*/

	$app->get('/clothing', function() {
		User::verifyLogin();
		
		$company["clothing"]	= NULL;
		$company["search"] 		= NULL;
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
		} 

		if (isset($_GET["search"])) {
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
			foreach ($_GET as $key => $value) {
				$company[$key] = $value;
			}
		}
		
		$firstday 	= '1';
		$lastday 	= date('t');
		$year 		= date('Y');
		$month 		= date('m');
		
		if ((!isset($_GET["dateout"]) || ($_GET["dateout"] == '') ) && (!isset($_GET["datein"]) || ($_GET["datein"] == ''))) {
			$company["dateout"] 	= $year.'-'.$month.'-'.$firstday;
			$company["datein"] 	= $year.'-'.$month.'-'.$lastday;
		}

		$clothings	= Metodo::selectRegister($company, "Clothing");
		if ($clothings[0] == NULL) {
			$clothings[0][0] = ["clothing_id"=>NULL ];
		}
		
		if (isset($clothings[0][0]["MESSAGE"])) {
			$msg = Metodo::divideMessage($clothings[0][0]["MESSAGE"]);
			$clothings[0][0] = ["clothing_id"=>NULL ];
		} else {
			$clothings[0][0]["MESSAGE"] = 'VAZIO';
		}

		$page = new PageClothing();
		$page->setTpl("clothing", array(
			"clothings"=>$clothings[0],
			"pgs"=>$clothings[1],
			"msg"=>$msg
		));
		
	});

	$app->get('/clothing/create', function() {
		User::verifyLogin();
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
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
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];	
		
		if (isset($clothing->getValues()["MESSAGE"])) {
			header("Location: /clothing?msg=".$clothing->getValues()["MESSAGE"]);
			exit;
		} else {
			$clothing->setData(['MESSAGE'=> 'VAZIO']);
		}

		$page = new PageClothing();
		
		$page ->setTpl("clothing-update", array(
			"clothing"=>$clothing->getValues(),
			"msg"=>$msg
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

/******************************************************************************************/

/*======================================================================================*/
/*										Rotas dos Material								*/
/*======================================================================================*/

	$app->get('/material', function() {
		User::verifyLogin();
		
		$company["material"]	= NULL;
		$company["receiver"] 	= NULL;
		$company["search"] 		= NULL;
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
		} 

		if (isset($_GET["search"])) {
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
			foreach ($_GET as $key => $value) {
				$company[$key] = $value;
			}
		}
		
		$firstday 	= '1';
		$lastday 	= date('t');
		$year 		= date('Y');
		$month 		= date('m');
		
		if ((!isset($_GET["daydate"]) || ($_GET["daydate"] == '') ) && (!isset($_GET["date_fim"]) || ($_GET["date_fim"] == ''))) {
			$company["daydate"] 	= $year.'-'.$month.'-'.$firstday;
			$company["date_fim"] 	= $year.'-'.$month.'-'.$lastday;
		}
		
		$material	= Metodo::selectRegister($company, "Material");
		
		if ($material[0] == NULL) {
			$material[0][0] = ["material_id"=>NULL ];
		}
		
		if (isset($material[0][0]["MESSAGE"])) {
			$msg = Metodo::divideMessage($material[0][0]["MESSAGE"]);
		} else {
			$material[0][0]["MESSAGE"] = 'VAZIO';
		}

		$page = new PageMaterial();
		$page->setTpl("material", array(
			"material"=>$material[0],
			"pgs"=>$material[1],
			"msg"=>$msg
		));
		
	});

	$app->get('/material/create', function() {
		User::verifyLogin();
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
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
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];	
		
		if (isset($material->getValues()["MESSAGE"])) {
			header("Location: /material?msg=".$material->getValues()["MESSAGE"]);
			exit;
		} else {
			$material->setData(['MESSAGE'=> 'VAZIO']);
		}

		$page = new PageMaterial();
		
		$page ->setTpl("material-update", array(
			"material"=>$material->getValues(),
			"msg"=>$msg
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
/******************************************************************************************/

/*======================================================================================*/
/*										Rotas do Hidrante								*/
/*======================================================================================*/

	$app->get('/hydrant', function() {
		User::verifyLogin();
		
		$company["hydrant"]	= NULL;
		$company["search"] 		= NULL;
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
		} 
		
		$hydrant	= Metodo::selectRegister($company, "Hydrant");
		
		if ($hydrant[0] == NULL) {
			$hydrant[0][0] = ["hydrant_id"=>NULL ];
		}
		
		if (isset($hydrant[0][0]["MESSAGE"])) {
			$msg = Metodo::divideMessage($hydrant[0][0]["MESSAGE"]);
		} else {
			$hydrant[0][0]["MESSAGE"] = 'VAZIO';
		}

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

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
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

		
		$hydrant = new Hydrant();
		$hydrant->getById($hydrant_id);
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];	
		
		if (isset($hydrant->getValues()["MESSAGE"])) {
			header("Location: /hydrant?msg=".$hydrant->getValues()["MESSAGE"]);
			exit;
		} else {
			$hydrant->setData(['MESSAGE'=> 'VAZIO']);
		}

		$page = new PageHydrant();
		
		$page ->setTpl("hydrant-update", array(
			"hydrant"=>$hydrant->getValues(),
			"msg"=>$msg,
			"locations"=>$locations,
			"locais"=>$locais,
			"msg"=>$msg
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
/******************************************************************************************/

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

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
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
			$historic[0][0]["historic_id"] = NULL;
		}
		$historic[0][0]["hydrant_id"] = $_GET["hydrant_id"];

		if (isset($historic[0][0]["MESSAGE"])) {
			$msg = Metodo::divideMessage($historic[0][0]["MESSAGE"]);
		} else {
			$historic[0][0]["MESSAGE"] = 'VAZIO';
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
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
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
		
		$historic = new HistoricH();
		$historic->getbyid($historic_id);
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];	
		
		if (isset($historic->getValues()["MESSAGE"])) {
			header("Location: /historicH?msg=".$historic->getValues()["MESSAGE"]);
			exit;
		} else {
			$historic->setData(['MESSAGE'=> 'VAZIO']);
		}

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
/******************************************************************************************/

/*======================================================================================*/
/*								Rotas do Ar Condicionado								*/
/*======================================================================================*/

	$app->get('/airconditioning', function() {
		User::verifyLogin();
		
		$company["search"] 		= NULL;
		$company["location"] 	= NULL;
		$company["serialnumber"]= NULL;
		$company["brand"] 		= NULL;
		$company["airconditioning"]	= NULL;
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
		} 

		if (isset($_GET["search"])) {
	
			foreach ($_GET as $key => $value) {
				$company[$key] = $value;
			}
		}

		$airconditioning	= Metodo::selectRegister($company, "AirConditioning");
		
		if ($airconditioning[0] == NULL) {
			$airconditioning[0][0] = ["airconditioning_id"=>NULL ];
		}

		if (isset($airconditioning[0][0]["MESSAGE"])) {
			$msg = Metodo::divideMessage($airconditioning[0][0]["MESSAGE"]);
		} else {
			$airconditioning[0][0]["MESSAGE"] = 'VAZIO';
		}
		
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

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];		

		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
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

		$airconditioning = new AirConditioning();
		$airconditioning->getById($airconditioning_id);

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];	
		
		if (isset($airconditioning->getValues()["MESSAGE"])) {
			header("Location: /airconditioning?msg=".$airconditioning->getValues()["MESSAGE"]);
			exit;
		} else {
			$airconditioning->setData(['MESSAGE'=> 'VAZIO']);
		}
		
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
/******************************************************************************************/

/*======================================================================================*/
/*						Rotas do Histórico do Ar Condicionado							*/
/*======================================================================================*/
		
	$app->get('/historicA', function() {
		User::verifyLogin();
		
		$company["historic"]		= NULL;
		$company["daydate"]	    	= NULL;
		$company["search"] 			= NULL;
		$company["airconditioning_id"]	= $_GET["airconditioning_id"];

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];		

		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
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
		
		if (isset($historic[0][0]["MESSAGE"])) {
			$msg = Metodo::divideMessage($historic[0][0]["MESSAGE"]);
		} else {
			$historic[0][0]["MESSAGE"] = 'VAZIO';
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
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];		

		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
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
		
		$airconditioning = new HistoricA();
		
		$ppost = Metodo::convertDateToDataBase(["daydate"=>$_POST["daydate"],"dtnextmanager"=>$_POST["dtnextmanager"]]);
		
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
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];		

		$historic = new HistoricA();
		$historic->getById($historic_id);
		if (isset($historic->getValues()["MESSAGE"])) {
			header("Location: /historic?msg=".$historic->getValues()["MESSAGE"]);
			exit;
		} else {
			$historic->setData(['MESSAGE'=> 'VAZIO']);
		}

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
			$ppost = Metodo::convertDateToDataBase(["daydate"=>$_POST["daydate"],"dtnextmanager"=>$_POST["dtnextmanager"]]);
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
/******************************************************************************************/

/*======================================================================================*/
/*					Rotas do Plano Anual de Manutenção Preventiva						*/
/*======================================================================================*/
	
	$app->get('/anualplan', function() {
		User::verifyLogin();
		
		$company["anualplan"]		= NULL;
		$company["daydate"]	    	= NULL;
		$company["search"] 			= NULL;

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
		} 
		
		if ((isset($_GET["daydate"]) && $_GET["daydate"] != '')) {
			$gget = Metodo::convertDateToDataBase(["daydate"=>$_GET["daydate"]]);

			foreach ($gget as $key => $value) {
				$_GET[$key] = $value;
			}
		} 
		
		$anualplan	= Metodo::selectRegister($company, "AnualPlan");

		if ($anualplan[0] == NULL) {
			$anualplan[0][0] = ["anualplan_id"=>NULL ];
		}
		
		if (isset($anualplan[0][0]["MESSAGE"])) {
			$msg = Metodo::divideMessage($anualplan[0][0]["MESSAGE"]);
		} else {
			$anualplan[0][0]["MESSAGE"] = 'VAZIO';
		}

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

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
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
	
		$equipaments	= Metodo::selectRegister($company, "Equipament");
		$locais			= Metodo::selectRegister($company, "Local");
		$locations		= Metodo::selectRegister($company, "Location");
		$responsables	= Metodo::selectRegister($company, "Responsable");

		$anualplan = new AnualPlan();
		$anualplan->getByIdA($anualplan_id);
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];	
		
		if (isset($anualplan->getValues()["MESSAGE"])) {
			header("Location: /anualplan?msg=".$anualplan->getValues()["MESSAGE"]);
			exit;
		} else {
			$anualplan->setData(['MESSAGE'=> 'VAZIO']);
			$status = Metodo::insertcolor($anualplan->getdtprevision(),$anualplan->getdtexecution(),$anualplan->getrstatus());
		}

		$page = new PageAnualPlan();
		$page->setTpl('anualplan-update', array(
			"anualplan" =>$anualplan->getValues(),
			"equipaments"=>$equipaments[0],
			"locations"=>$locations[0],
			"locais"=>$locais[0],
			"responsables"=>$responsables[0],
			"msg"=>$msg,
			"status"=>$status
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
			$ppost = Metodo::convertDateToDataBase(["dtprevision"=>$_POST["dtprevision"],"dtexecution"=>$_POST["dtexecution"]]);
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
/******************************************************************************************/

/*======================================================================================*/
/*									Rotas do Equipamento								*/
/*======================================================================================*/

	$app->get('/equipament', function() {
		User::verifyLogin();

		$company["equipament"]		= NULL;
		$company["daydate"]	    	= NULL;
		$company["search"] 			= NULL;

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
		} 

		$equipaments	= Metodo::selectRegister($company, "Equipament");
		
		if ($equipaments[0] == NULL) {
			$equipaments[0][0] = ["equipament_id"=>NULL ];
		}
		
		if (isset($equipaments[0][0]["MESSAGE"])) {
			$msg = Metodo::divideMessage($equipaments[0][0]["MESSAGE"]);
		} else {
			$equipaments[0][0]["MESSAGE"] = 'VAZIO';
		}

		$page = new PageAnualPlan();
		
		$page->setTpl("equipament", array(
			"equipaments"=>$equipaments[0],
			"pgs"=>$equipaments[1],
			"msg"=>$msg
		));
	});

	$app->get('/equipament/create', function() {
		User::verifyLogin();
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
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
		
		$equipament = new AnualPlan();
		$equipament->getByIdE($equipament_id);
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];	
		
		if (isset($equipament->getValues()["MESSAGE"])) {
			header("Location: /equipament?msg=".$equipament->getValues()["MESSAGE"]);
			exit;
		} else {
			$equipament->setData(['MESSAGE'=> 'VAZIO']);
		}

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
/******************************************************************************************/

/*======================================================================================*/
/*										Rotas da Local									*/
/*======================================================================================*/
	
	$app->get('/local', function() {
		User::verifyLogin();

		$company["local"]		= NULL;
		$company["daydate"]	    	= NULL;
		$company["search"] 			= NULL;

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
		} 

		$locais	= Metodo::selectRegister($company, "Local");
		
		if ($locais[0] == NULL) {
			$locais[0][0] = ["local_id"=>NULL ];
		}
		
		if (isset($locais[0][0]["MESSAGE"])) {
			$msg = Metodo::divideMessage($locais[0][0]["MESSAGE"]);
		} else {
			$locais[0][0]["MESSAGE"] = 'VAZIO';
		}

		$page = new PageLocal();
		
		$page->setTpl("local", array(
			"locais"=>$locais[0],
			"pgs"=>$locais[1],
			"msg"=>$msg
		));
	});

	$app->get('/local/create', function() {
		User::verifyLogin();
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
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
		
		$local = new Local();
		$local->getById($local_id);
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];	
		
		if (isset($local->getValues()["MESSAGE"])) {
			header("Location: /local?msg=".$local->getValues()["MESSAGE"]);
			exit;
		} else {
			$local->setData(['MESSAGE'=> 'VAZIO']);
		}

		$page = new PageLocal();
		$page->setTpl('local-update', array(
			"local" =>$local->getValues(),
			"msg"=>$msg
		));
	});

	$app->post('/local/:local_id', function($local_id) {
		User::verifyLogin();
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
		}

		$local = new Local();
		$local->getById($local_id);
		
		$local->setData($_POST);
		$msg = $local->update();
		
		header("Location: /local?msg=".$msg);
		exit;
		
	});
/******************************************************************************************/

/*======================================================================================*/
/*									Rotas do Responsável								*/
/*======================================================================================*/
	
	$app->get('/responsable', function() {
		User::verifyLogin();

		$company["responsable"]		= NULL;
		$company["daydate"]	    	= NULL;
		$company["search"] 			= NULL;

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
		} 

		$responsables	= Metodo::selectRegister($company, "Responsable");
		
		if ($responsables[0] == NULL) {
			$responsables[0][0] = ["responsable_id"=>NULL ];
		}
		
		if (isset($responsables[0][0]["MESSAGE"])) {
			$msg = Metodo::divideMessage($responsables[0][0]["MESSAGE"]);
		} else {
			$responsables[0][0]["MESSAGE"] = 'VAZIO';
		}

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
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
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
		
		$responsable = new User();
		$responsable->get($responsable_id);
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];	
		
		if (isset($responsable->getValues()["MESSAGE"])) {
			header("Location: /responsable?msg=".$responsable->getValues()["MESSAGE"]);
			exit;
		} else {
			$responsable->setData(['MESSAGE'=> 'VAZIO']);
		}

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

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
		} 

		$locations	= Metodo::selectRegister($company, "Location");
		
		if ($locations[0] == NULL) {
			$locations[0][0] = ["location_id"=>NULL ];
		}
		
		if (isset($locations[0][0]["MESSAGE"])) {
			$msg = Metodo::divideMessage($locations[0][0]["MESSAGE"]);
		} else {
			$locations[0][0]["MESSAGE"] = 'VAZIO';
		}

		$page = new PageLocation();
		
		$page->setTpl("location", array(
			"locations"=>$locations[0],
			"pgs"=>$locations[1],
			"msg"=>$msg
		));
	});

	$app->get('/location/create', function() {
		User::verifyLogin();
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
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
		
		$location = new Location();
		$location->getById($location_id);
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];	
		
		if (isset($location->getValues()["MESSAGE"])) {
			header("Location: /location?msg=".$location->getValues()["MESSAGE"]);
			exit;
		} else {
			$location->setData(['MESSAGE'=> 'VAZIO']);
		}

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
/******************************************************************************************/

/*======================================================================================*/
/*								Rotas do Controle Geral									*/
/*======================================================================================*/

	$app->get('/generalcontrol', function() {
		User::verifyLogin();

		$company["generalcontrol"]	= NULL;
		$company["daydate"]	    	= NULL;
		$company["search"] 			= NULL;

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
		} 

		$generalcontrols	= Metodo::selectRegister($company, "GeneralControl");
		
		if ($generalcontrols[0] == NULL) {
			$generalcontrols[0][0] = ["generalcontrol_id"=>NULL ];
		}
		
		if (isset($generalcontrols[0][0]["MESSAGE"])) {
			$msg = Metodo::divideMessage($generalcontrols[0][0]["MESSAGE"]);
			$generalcontrols[0][0]["generalcontrol_id"] = NULL;
		} else {
			$generalcontrols[0][0]["MESSAGE"] = 'VAZIO';
		}

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
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
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
		$ppost = Metodo::convertDateToDataBase(["dthydraulic"=>$_POST["dthydraulic"],"dteletric"=>$_POST["dteletric"],"dtbuilding"=>$_POST["dtbuilding"]]);
		foreach ($ppost as $key => $value) {
			$_POST[$key] = $value;
		}	
		$generalcontrol->setData($_POST);
		
		$msg = $generalcontrol->save();

		header("Location: /generalcontrol/create?msg=$msg");
		exit;

	});

	$app->get("/generalcontrol/:generalcontrol_id/delete", function ($generalcontrol_id){
		User::verifyLogin();
		
		$generalcontrol = new GeneralControl();
		$generalcontrol->getById($generalcontrol_id);
		
		$user_id["user_id"] = $_SESSION["User"]["user_id"];
		$generalcontrol->setdata($user_id);
		
		$msg = $generalcontrol->delete();
		
		header("Location: /generalcontrol?msg=".$msg);
		exit;
	});

	$app->get('/generalcontrol/:generalcontrol_id', function($generalcontrol_id) {
		User::verifyLogin();
		
		$company["generalcontrol"]		= NULL;
		$company["daydate"]	    	= NULL;
		$company["search"] 			= NULL;

		$locais			= Metodo::selectRegister($company, "Local");
		$locations		= Metodo::selectRegister($company, "Location");
		
		$generalcontrol = new GeneralControl();
		$generalcontrol->getById($generalcontrol_id);

		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];	
		
		if (isset($generalcontrol->getValues()["MESSAGE"])) {
			header("Location: /generalcontrol?msg=".$generalcontrol->getValues()["MESSAGE"]);
			exit;
		} else {
			$generalcontrol->setData(['MESSAGE'=> 'VAZIO']);
		}

		$page = new PageGeneralControl();
		$page->setTpl('generalcontrol-update', array(
			"generalcontrol" =>$generalcontrol->getValues(),
			"locations"=>$locations[0],
			"locais"=>$locais[0],
			"msg"=>$msg
		));
	});

	$app->post('/generalcontrol/:generalcontrol_id', function($generalcontrol_id) {
		User::verifyLogin();
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
		}

		if (isset($_POST)) {
			$ppost = Metodo::convertDateToDataBase(["dthydraulic"=>$_POST["dthydraulic"],"dteletric"=>$_POST["dteletric"],"dtbuilding"=>$_POST["dtbuilding"]]);
			foreach ($ppost as $key => $value) {
				$_POST[$key] = $value;
			}
			$_POST["user_id"] = $_SESSION["User"]["user_id"];
		}

		$generalcontrol = new GeneralControl();
		$generalcontrol->getById($generalcontrol_id);
		
		$generalcontrol->setData($_POST);
		
		$msg = $generalcontrol->update();
		
		header("Location: /generalcontrol?msg=".$msg);
		exit;
		
	});
/******************************************************************************************/

/*======================================================================================*/
/*										Rotas do Admin									*/
/*======================================================================================*/

	$app->get('/admin', function() {

		User::verifyLogin();
		if ($_SESSION["User"]["inadmin"] == '1') {
			$users = User::listAll();

			$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
			if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
				$msg = Metodo::divideMessage($_GET["msg"]);
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
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
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
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
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
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
		}
		
		$user = User::getForgot($_POST["email"]);
		header("Location: /admin/forgot/sent");
		exit;
	});

	$app->get("/admin/forgot/sent", function(){
		
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$msg = Metodo::divideMessage($_GET["msg"]);
			$_GET["msg"] = '';
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
/******************************************************************************************/

/*======================================================================================*/
/*										Rotas do Users									*/
/*======================================================================================*/

	$app->get('/users', function() {
		
		User::verifyLogin();
		if ($_SESSION["User"]["inadmin"] == '1') {
			$users = User::listAll();
			
			$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
			if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
				$msg = Metodo::divideMessage($_GET["msg"]);
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

	$app->get('/users/create', function() {
		
		User::verifyLogin();
		if ($_SESSION["User"]["inadmin"] == '1') {
			$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO', "err"=>"VAZIO"];		
		
			if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
				$msg = Metodo::divideMessage($_GET["msg"]);
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
			
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO',"err"=> 'VAZIO'];	
		
		if (isset($user->getValues()["MESSAGE"])) {
			header("Location: /users?msg=".$user->getValues()["MESSAGE"]);
			exit;
		} else {
			$user->setData(['MESSAGE'=> 'VAZIO']);
		}

		$page = new PageUser();
		
		$page ->setTpl("users-update", array(
			"user"=>$user->getValues(),
			"msg"=>$msg
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
/******************************************************************************************/

/*======================================================================================*/
/*									Execução do aplicativo								*/
/*======================================================================================*/

	$app->run();

?>
	