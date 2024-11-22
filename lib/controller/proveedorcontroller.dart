import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:comppatt/models/proveedor.dart';

class ProveedorController {
  /// Método para agregar o actualizar un proveedor
  Future<bool> saveProveedor(Proveedor proveedor) async {
    var url = Uri.parse("http://localhost:3000/Proveedor/Guardar");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(proveedor.toMap()),
      );

      if (response.statusCode == 200) {
        return true; // Éxito al guardar o actualizar
      } else {
        print('Error al guardar proveedor: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Excepción al guardar proveedor: $e');
      return false;
    }
  }

  /// Método para obtener todos los proveedores
  Future<List<Proveedor>> getProveedores() async {
var url = Uri.parse("http://localhost:3000/Proveedores");
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var  json = jsonDecode(response.body);

        if (json['proveedores'] != null) {
        var data = json['proveedores'] as List;

        List<Proveedor> records =
            data.map((item) => Proveedor.fromMap(item)).toList();
        return records;
      }else{
        return [];
      }
      }else {
        print('Error al obtener proveedores: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Excepción al obtener proveedores: $e');
      return [];
    }
  }
}
