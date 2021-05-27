<?php 
	session_start();
	require_once("vendor/autoload.php");

	use \Slim\Slim;
	use \PRJM010\Page;
	use \PRJM010\PageAdmin;
	use \PRJM010\PageUser;
	use \PRJM010\PageVisitant;
	use \PRJM010\PageResidual;
	use \PRJM010\Model\User;
	use \PRJM010\Model\Visitant;
	use \PRJM010\Model\Residual;
	//use \PRJM010\PagePerson;
	//use \PRJM010\Model\Person;

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

		$visitants = Visitant::selectRegister($company);
		
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
			$gget = Visitant::convertDateToDataBase(["date_save"=>$_GET["date_save"]]);

			foreach ($gget as $key => $value) {
				$_GET[$key] = $value;
			}
		} 
		if ( (isset($_GET["date_fim"]) && $_GET["date_fim"] != '')) 
		{
			$gget = Visitant::convertDateToDataBase(["date_fim"=>$_GET["date_fim"]]);

			foreach ($gget as $key => $value) {
				$_GET[$key] = $value;
			}
		} 

		foreach ($_GET as $key => $value) {
			$company[$key] = $value;
		}
		$company["visitants"]	= "visitants";
		$visitants = Visitant::selectRegister($company);
		
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

		$ppost = Visitant::convertDateToDataBase(["daydate"=>$_POST["daydate"]]);

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
		$classifications = Visitant::listClassification();
		
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
			$ppost = Visitant::convertDateToDataBase(["daydate"=>$_POST["daydate"], "dt_save"=>$_POST["dt_save"]]);
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
		$company["dtbuy"] 		= NULL;
		$company["dtsell"] 		= NULL;
		$company["name_person"] = NULL;
		$company["search"] 		= NULL;
		$msg = ["state"=>'VAZIO', "msg"=> 'VAZIO'];		
		
		if ((isset($_GET["msg"]) && $_GET["msg"] != '')) {
			$mess = explode(':', $_GET["msg"]);
			$msg = ["state"=>$mess[0], "msg"=> $mess[1]];
			$_GET["msg"] = '';
		} 

		if ((isset($_GET["daydate"]) && $_GET["daydate"] != '')) {
			$gget = Visitant::convertDateToDataBase(["daydate"=>$_GET["daydate"]]);

			foreach ($gget as $key => $value) {
				$_GET[$key] = $value;
			}
		} 
		if ( (isset($_GET["date_fim"]) && $_GET["date_fim"] != '')) 
		{
			$gget = Visitant::convertDateToDataBase(["date_fim"=>$_GET["date_fim"]]);

			foreach ($gget as $key => $value) {
				$_GET[$key] = $value;
			}
		}
		
		$residual	= Residual::selectRegister($company);
		
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
		
		$ppost = Residual::convertDateToDataBase(["daydate"=>$_POST["daydate"]]);
		
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
			$ppost = Visitant::convertDateToDataBase(["daydate"=>$_POST["daydate"]]);
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
/*										Rotas do Admin									*/
/*======================================================================================*/

	$app->get('/admin', function() {

		User::verifyLogin();
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
	});

	$app->get('/users/create', function() {
		
		User::verifyLogin();
		$page = new PageUser();
		$page->setTpl("users-create");
	});
	
	$app->post("/users/create", function (){
		User::verifyLogin();

		$user = new User();

		$date = explode(" ",date('d-m-Y H:i'));
		$dt["daydate"] = $date[0];
		$dt1["hour"] =$date[1];
		$ppost = Visitant::convertDateToDataBase(["daydate"=>$date[0]]);

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
		$user = new User();
		$user->get((int)$person_id);

		$msg = $user->delete();
		header("Location: /users?msg=$msg");
		exit;
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
