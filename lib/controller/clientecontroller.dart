import 'dart:convert';
import 'package:comppatt/models/venta.dart';
import 'package:http/http.dart' as http;
import 'package:comppatt/models/cliente.dart';


class ClienteController {
  Future<List<Cliente>> getAllClient() async {
    var url = Uri.parse("http://localhost:3000/Clientes");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      // Verifica si 'clientes' está presente y no es null
      if (json['clientes'] != null) {
        var data = json['clientes'] as List;

        // Convierte la lista de mapas en una lista de objetos Cliente
        List<Cliente> records =
            data.map((item) => Cliente.fromMap(item)).toList();
        return records;
      } else {
        // Si 'clientes' es null, retorna una lista vacía
        return [];
      }
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

// Tomando en cuenta que ID hace referencia a la CURP del cliente
  Future<List<Cliente>> getClienteByID(String id) async {
    var url = Uri.parse("http://localhost:3000/Cliente/" + id);

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      // Verifica si 'clientes' está presente y no es null
      if (json['cliente'] != null) {
        var data = json['cliente'] as List;

        // Convierte la lista de mapas en una lista de objetos Cliente
        List<Cliente> records =
            data.map((item) => Cliente.fromMap(item)).toList();
        return records;
      } else {
        // Si 'clientes' es null, retorna una lista vacía
        return [];
      }
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

Future<List<Venta>> getVentasByID(String id) async {
    var url = Uri.parse("http://localhost:3000/Cliente/Venta/" + id);

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      // print(json);

      // Verifica si 'clientes' está presente y no es null
      if (json['ventas'] != null) {
        var data = json['ventas'] as List;

        // Convierte la lista de mapas en una lista de objetos Cliente
        List<Venta> records =
            data.map((item) => Venta.fromMap(item)).toList();
        return records;
      } else {
        // Si 'clientes' es null, retorna una lista vacía
        return [];
      }
    } else {
      throw Exception('Error al cargar los datos');
    }
  }
  // Future<List<Venta>> getVentas() async{

  // }
}
