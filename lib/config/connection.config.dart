import 'package:mysql1/mysql1.dart';

class Database {
  static final Database _instance = Database._internal();

  factory Database() {
    return _instance;
  }

  Database._internal();

  // Configuración de la conexión
  Future<MySqlConnection> getConnection() async {
    final settings = ConnectionSettings(
      host: 'localhost', // Cambia a tu host si es necesario
      port: 3306,        // Puerto por defecto de MySQL
      user: 'root', // Tu usuario de MySQL
      password: '', // Tu contraseña de MySQL
      db: 'comppatt',     // Nombre de tu base de datos
    );
    
    return await MySqlConnection.connect(settings);
  }
}
