<?php 
	session_start();
	require_once("vendor/autoload.php");

	use \Slim\Slim;
	use \PRJM010\Page;
	use \PRJM010\PageAdmin;
	use \PRJM010\PageUser;
	use \PRJM010\PageVisitant;
	use \PRJM010\PagePerson;
	use \PRJM010\Model\User;
	use \PRJM010\Model\Visitant;
	use \PRJM010\Model\Person;

	date_default_timezone_set('America/Sao_Paulo');	
	
	$app = new Slim();

	$app->config('debug', true);

/*======================================================================================*/
/*										Rotas do Visitants								*/
/*======================================================================================*/
	$app->get('/', function() {
		User::verifyLogin();
		$company["name_person"]	= NULL;
		$company["date_save"] 	= NULL;
		$company["date_save"] 	= date('Y-m-d');
		$company["date_fim"] 	= date('Y-m-d');
		$company["visitants"]	= "visitants";
		$company["search"]		= NULL;

		exit;
		
		$visitants = Visitant::selectRegister($company);
		
		$page = new PageVisitant();
			
		$page->setTpl("visitant", array(
			"visitants"	=> $visitants[0],
			"pgs"		=> $visitants[1]
		));
		
	});

	$app->get('/visitant', function() {
			
		User::verifyLogin();

		$company["name_person"]	= NULL;
		$company["visitants"]	= NULL;
		$company["search"]		= NULL;
		$company["date_fim"] 	= NULL;
		$company["date_save"] 	= NULL;
		

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
		$visitants 	= Visitant::selectRegister($company);
		
		$page = new PageVisitant();
		$page->setTpl("visitant", array(
			"visitants"	=> $visitants[0],
			"pgs"		=> $visitants[1]
		));
	});

	$app->get('/visitant/create', function() {
		User::verifyLogin();
		$classification = Visitant::listClassification();
		
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
			"classifications" =>$classification
		));
	});
	$app->post('/visitant/create', function() {
		User::verifyLogin();
		
		$visitant = new Visitant();

		$_POST = Visitant::convertDateToDataBase($_POST);

		$_POST["user_id"] = $_SESSION["User"]["user_id"];

		$visitant->setData($_POST);
		$visitant->save();
		// echo '<pre>';
		// print_r($visitant);
		// echo '</pre>';
		// exit;
		
		header("Location: /visitant/create");
		exit;
	});


	$app->get('/visitant/:person_id', function($person_id) {
		
		User::verifyLogin();
		$classifications = Visitant::listClassification();

		$visitant = new Visitant();
		$visitant->getById($person_id);
		
		//$visitant = Visitant::convertDateToView($visitant);
		// echo '<pre>';
		// print_r($visitant);
		// echo '</pre>';
		// exit;
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

	$app->post("/visitant/:person_id", function ($person_id){
		User::verifyLogin();
			
		$visitant = new Visitant();

		if (isset($_POST)) {
			$ppost = Visitant::convertDateToDataBase(["daydate"=>$_POST["daydate"]]);
			foreach ($ppost as $key => $value) {
				$_POST[$key] = $value;
			}
			$_POST["user_id"] = $_SESSION["User"]["user_id"];
		}
		
		$visitant->getById($person_id);
		$visitant->setData($_POST);
		// echo '<pre>';
		// print_r($visitant);
		// echo '</pre>';
		// exit;
		$msg = $visitant->update();
		header("Location: /visitant?sgcompany=".$_POST["sgcompany"]."&dtbuy=&dtsell=&search=Search&limit=10&msg=".$msg);
		exit;
	});
/*======================================================================================*/
/*										Rotas das Ações									*/
/*======================================================================================*/
	

	$app->get('/acoes-estoque', function() {
		User::verifyLogin();
		//$param = "";
		$company["sgcompany"]	= NULL;
		$company["dtbuy"] 		= NULL;
		$company["dtsell"] 		= NULL;
		$company["listestoque"]	= NULL;

		if ((isset($_GET["dtbuy"]) && $_GET["dtbuy"] != '') || (isset($_GET["dtsell"]) && $_GET["dtsell"] != '')) {
			$_GET = Acao::convertDateToDataBase($_GET);
		}
		foreach ($_GET as $key => $value) {
			$company[$key] = $value;
		}
		
		$company["listestoque"]	= "listestoque";
		$action	= Acao::selectRegister($company);
		
		$page = new PageAcoes([
			"acoes"=> $action[0]
		]);
		$page->setTpl("acoes-estoque", array(
			"acoes"=> $action[0],
			"pgs"=> $action[1],
		));
		
	});
	
	$app->get('/acoes', function() {
		User::verifyLogin();
		$company["sgcompany"]	= NULL;
		$company["dtbuy"] 		= NULL;
		$company["dtsell"] 		= NULL;
		$company["listacoes"]	= NULL;
		$company["search"]		= NULL;

		if ((isset($_GET["dtbuy"]) && $_GET["dtbuy"] != '') || (isset($_GET["dtsell"]) && $_GET["dtsell"] != '')) {
			$_GET = Acao::convertDateToDataBase($_GET);
		}
		foreach ($_GET as $key => $value) {
			$company[$key] = $value;
		}
		
		$company["listacoes"] 	= "listacoes";
		
		$action 	= Acao::selectRegister($company);
	
		$page = new PageAcoes();
		$page->setTpl("acoes", array(
			"acoes"	=> $action[0],
			"pgs"	=> $action[1]
		));
		
	});
	
	$app->get('/acoes/create', function() {
		User::verifyLogin();
		
		$voltar = ["voltar"=>"acoes"];
		if (isset($_GET["acoes"])) {
			$voltar = ["voltar"=>"acoes"];
		}
		if (isset($_GET["notas"])) {
			$voltar = ["voltar"=>"notas"];
		}
		$page = new PageAcoes();

		if (isset($_GET["compra"])) {
			$page->setTpl("acoes-create", array(
				"voltar"=>$voltar
			));
		}
		
		
	});

	$app->post("/acoes/create", function (){
		User::verifyLogin();
		
		$acao = new Acao();
		if (isset($_POST["tax"])) {
			$tax = explode(" ",$_POST["tax"]);
			$_POST["tax"] = $tax[0];
		}

		$_POST = Acao::convertDateToDataBase($_POST);

		$_POST["iduser"] = $_SESSION["User"]["iduser"];
		
   		$_POST["tptransaction"] = "C";


		$acao->setData($_POST);

		$acao->save();
		//var_dump($acao);exit;
		$tipo = "compra";
		
		header("Location: /acoes/create?$tipo=$tipo");
		exit;
	});
	
	$app->get("/acoes/:idinvestiment/delete", function ($idinvestiment){
		User::verifyLogin();
		$acao = new Acao();
		$acao->getByBuy($idinvestiment);
		$array = (array) $acao;

		foreach ($array as $key => $value) {
			$company = $value["sgcompany"];
		}
		$acao->delete();
		header("Location: /acoes?sgcompany=".$company."&dtbuy=&dtsell=&search=Search");
		exit;
	});

	$app->get("/acoes/:idinvestiment", function($idinvestiment) {
		User::verifyLogin();
		$acoes = new Acao();
		$acoes->getByBuy($idinvestiment);
		
		$acoes = Acao::convertDateToView($acoes);

		$page = new PageAcoes();
		
		$page ->setTpl("acoes-update", array(
			"acoes"=>$acoes->getValues()
		));
	});

/*======================================================================================*/
/*										Rotas das Notas									*/
/*======================================================================================*/
	
	$app->get('/notas', function() {
		User::verifyLogin();
		$company["sgcompany"]	= NULL;
		$company["dtbuy"] 		= NULL;
		$company["dtsell"] 		= NULL;
		$company["search"] 		= NULL;
		
		if ((isset($_GET["dtbuy"]) && $_GET["dtbuy"] != '') || (isset($_GET["dtsell"]) && $_GET["dtsell"] != '')) {
			$_GET = Acao::convertDateToDataBase($_GET);
		}
		foreach ($_GET as $key => $value) {
			$company[$key] = $value;
		}
		
		$page = new PageAcoes();
		if (isset($_GET["search"])) {
			$company["search"] 		= "Search";
			
			$action 	= Acao::selectRegister($company);
			// echo '</pre>';
            // print_r($action);
            // echo '<pre>';
            
            // exit;
			if (isset($action) && $action != '') {
				$page->setTpl("/notas", array(
					"acoes"=>$action[0],
					"pgs"=>$action[1]
				));
			}

		} else // Fim do Search
		{
			$company["notas"]	= "notas";
			$action 	= Acao::selectRegister($company);
			
			$page->setTpl("notas", array(
				"acoes"=> $action[0],
				"pgs"=> $action[1]
			));
		}
		
	});
	
	$app->get("/notas/:idinvestiment", function($idinvestiment) {
		User::verifyLogin();
		$acoes = new Acao();
		$acoes->getByBuy($idinvestiment);
		
		$page = new PageAcoes();
		
		$page ->setTpl("acoes-update", array(
			"acoes"=>$acoes->getValues()
		));
	});
	
	$app->post("/notas/:idinvestiment", function ($idinvestiment){
		User::verifyLogin();
		$acoes = new Acao();
		// $act = new Acao();
		// $action 	= Acao::listAllIds();
		
		// for ($i=0; $i < COUNT($action); $i++) { 
		// 	$act->getByBuy($action[$i]['idinvestiment']);
		// 	$act->update();
		// }
		// echo '</pre>';
		// print_r($act);
		// echo '<pre>';
		
		// exit;
		if (isset($_POST["tax"])) {
			$tax = explode(" ",$_POST["tax"]);
			$_POST["tax"] = $tax[0];
		}
		if (isset($_POST)) {
			$_POST = Acao::convertDateToDataBase($_POST);
			$_POST["iduser"] = $_SESSION["User"]["iduser"];
		}
		
		$acoes->getByBuy($idinvestiment);
		$acoes->setData($_POST);
		$msg = $acoes->update();
		// echo '<pre>';
		// print_r($act);
		// echo '</pre>';
		// exit;
		header("Location: /notas?sgcompany=".$_POST["sgcompany"]."&dtbuy=&dtsell=&search=Search&limit=10&msg=".$msg);
		exit;
	});
	
/*======================================================================================*/
/*										Rotas do Person									*/
/*======================================================================================*/

	$app->get('/persons', function() {

		User::verifyLogin();
		$persons = Person::listAll();
		$page = new PagePerson();
		$page->setTpl("index", array(
			"persons"=> $persons
		));
	});

	$app->get("/persons/:idperson/delete", function ($idperson){
		User::verifyLogin();
		$person = new Person();
		$person->get((int)$idperson);
		$person->delete();
		header("Location: /persons");
		exit;
	});

	$app->get("/persons/:idperson", function($idperson) {
		User::verifyLogin();
		$persons = new Person();
 
		$persons->get((int)$idperson);
		$page = new PagePerson();
		
		$page ->setTpl("person-update", array(
			"persons"=>$persons->getValues()
		));
	});

	$app->post("/persons/:idperson", function ($idperson){
		User::verifyLogin();
		$persons = new Person();
		
		$persons->get((int)$idperson);
		$persons->setData($_POST);
		
		$persons->update();
		header("Location: /persons");
		exit;
	});

/*======================================================================================*/
/*										Rotas do Admin									*/
/*======================================================================================*/

	$app->get('/admin', function() {

		User::verifyLogin();
		$users = User::listAll();
		$page = new PageUser();
		$page->setTpl("users", array(
			"users"=> $users
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
		
		User::login($_POST["login"], $_POST["password"]);
		
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
		$page = new PageUser();
		$page->setTpl("users", array(
			"users"=> $users
		));
	});

	$app->get('/users/create', function() {
		
		User::verifyLogin();
		$page = new PageUser();
		$page->setTpl("users-create");
	});
	
	$app->get("/users/:iduser/delete", function ($iduser){
		User::verifyLogin();
		$user = new User();
		$user->get((int)$iduser);

		$user->delete();
		header("Location: /users");
		exit;
	});

	$app->get("/users/:iduser", function($iduser) {
		User::verifyLogin();
		$user = new User();
 
		$user->get((int)$iduser);
		
		$page = new PageUser();
		
		$page ->setTpl("users-update", array(
			"user"=>$user->getValues()
		));
	});

	$app->post("/users/create", function (){
		User::verifyLogin();

		$user = new User();

		$_POST["inadmin"] = (isset($_POST["inadmin"])) ? 1 : 0;

		$_POST['despassword'] = password_hash($_POST["despassword"], PASSWORD_DEFAULT, [
			
			"cost"=>12
			
			]);

		$user->setData($_POST);

		$user->save();

		header("Location: /users");
			exit;
	});
	
	$app->post("/users/:iduser", function ($iduser){
		User::verifyLogin();
		$user = new User();
		$_POST["inadmin"] = (isset($_POST["inadmin"])) ? 1 : 0;
		
		$user->get((int)$iduser);
		$user->setData($_POST);
		
		$user->update();
		
		header("Location: /users");
		exit;
		
	});
	
	
	$app->run();

?>
