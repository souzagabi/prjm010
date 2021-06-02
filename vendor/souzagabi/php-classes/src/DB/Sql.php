<?php 

	namespace PRJM010\DB;

	class Sql {

		const HOSTNAME = "127.0.0.1";
		const USERNAME = "root";
		const PASSWORD = "@Prjm010!!2021";
		//const PASSWORD = "@V1s@r3!!2021";
		const DBNAME = "PRJM010";
		//const USERNAME = "PRJM010";
		//const PASSWORD = "prjm010";
		//const DBNAME = "D:\ADJClientes\Visare\PrjManutencao\db\PRJM010.FDB";

		private $conn;

		public function __construct()
		{
			// $this->conn = new \PDO(
			// 	"firebird:dbname=".Sql::DBNAME.";host=".Sql::HOSTNAME, 
			// 	Sql::USERNAME,
			// 	Sql::PASSWORD
			// );
			$this->conn = new \PDO(
				"mysql:dbname=".Sql::DBNAME.";host=".Sql::HOSTNAME, 
				Sql::USERNAME,
				Sql::PASSWORD
			);

		}

		private function setParams($statement, $parameters = array())
		{
			foreach ($parameters as $key => $value) {
				
				$this->bindParam($statement, $key, $value);
			}
		}

		private function bindParam($statement, $key, $value)
		{
			$statement->bindParam($key, $value);
		}

		public function query($rawQuery, $params = array())
		{
			$stmt = $this->conn->prepare($rawQuery);

			$this->setParams($stmt, $params);

			$stmt->execute();
		}

		public function select($rawQuery, $params = array()):array
		{
			$stmt = $this->conn->prepare($rawQuery);
			
			$this->setParams($stmt, $params);
			
			$stmt->execute();

			return $stmt->fetchAll(\PDO::FETCH_ASSOC);

		}
	}
?>
