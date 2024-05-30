import 'package:mysql_client/mysql_client.dart';


Future<void> dbConnector(String queryState) async {
  print("Connecting to mysql server...");

  final conn = await MySQLConnection.createConnection(
    host: 'host',
    port: 0, 
    userName: 'userName',
    password: 'password',
    databaseName: 'databaseName',
  );

  await conn.connect();

  print("Connected");

  IResultSet? result;
  int id = 1;
 
  if (queryState == 'selectAll') {
    result = await conn.execute("SELECT * FROM memberTable");
  } else if (queryState == 'select') {
    result = await conn.execute(
        "SELECT * FROM memberTable where id = :idNumber", {"idNumber": id});
  }
 
  if (result != null && result.isNotEmpty) {
    for (final row in result.rows) {
      print(row.assoc());
    }
  }
  
  await conn.close();
}