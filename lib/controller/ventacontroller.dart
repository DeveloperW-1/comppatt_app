import 'dart:convert';
import 'package:comppatt/models/ventaDetalle.dart';
import 'package:http/http.dart' as http;
import 'package:comppatt/models/venta.dart';

class Ventacontroller {
  Future<String> saveVenta(Venta venta, List<VentaDetalle> detalles) async {
  var url = Uri.parse("http://localhost:3000/Venta/Guardar");

  var body = jsonEncode({
    'venta': venta.toMap(),
    'detalles': detalles.map((detalle) => detalle.toMap()).toList()
  });

  try {
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      // Decodifica la respuesta JSON
      var jsonResponse = jsonDecode(response.body);

      // Extrae el mensaje de éxito o información relevante
      return jsonResponse['message'] ?? 'Venta guardada exitosamente';
    } else {
      throw Exception('Error al guardar la Venta: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Error al realizar la solicitud: $error');
  }
}


  Future<List<Venta>> getVentas() async {
    var url = Uri.parse("http://localhost:3000/Ventas");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      print(json['ventas']);

      if (json['ventas'] != null) {
        var data = json['ventas'] as List;

        List<Venta> records =
            data.map((item) => Venta.fromMap(item)).toList();
            print(records);
        return records;
      } else {
        return [];
      }
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  Future<List<VentaDetalle>> getDetallesByID(int id) async {
    var url = Uri.parse("http://localhost:3000/Detalle/Venta/" + id.toString());

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      if (json['detalles'] != null) {
        var data = json['detalles'] as List;

        List<VentaDetalle> records =
            data.map((item) => VentaDetalle.fromMap(item)).toList();
        return records;
      } else {
        return [];
      }
    } else {
      throw Exception('Error al cargar los datos');
    }
  }
}
