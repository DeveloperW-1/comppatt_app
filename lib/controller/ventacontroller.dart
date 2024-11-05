import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:comppatt/models/venta.dart';

class Ventacontroller {
  Future<String> saveVenta(Venta venta) async {
    var url = Uri.parse("http://localhost:3000/Venta/Guardar");

    var body = jsonEncode(venta.toMap());

    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      // Si la solicitud es exitosa
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // Si ocurre algún error en la respuesta
        throw Exception('Error al guardar la Venta: ${response.statusCode}');
      }
    } catch (error) {
      // Si ocurre algún error en la solicitud
      throw Exception('Error al realizar la solicitud: $error');
    }
  }

  Future<List<Venta>> getVentas() async {
    var url = Uri.parse("http://localhost:3000/Ventas");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

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
}
