import 'dart:convert';

import 'package:comppatt/models/compra.dart';
import 'package:comppatt/models/compraDetalle.dart';
import 'package:http/http.dart' as http;

class CompraController {
  final String baseUrl = "http://localhost:3000";

  /// Guarda una compra con sus detalles.
  Future<String> saveCompraWithDetails(
      Compra compra, List<DetalleCompra> detalles) async {
    var url = Uri.parse("$baseUrl/Compra/Guardar");

    // Construir el cuerpo de la solicitud que incluye la compra y sus detalles.
    var body = jsonEncode({
      "compra": compra.toMap(),
      "detalles": detalles.map((detalle) => detalle.toMap()).toList(),
    });

    print("Solicitud enviada: $body");

    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200) {
        print("Compra guardada exitosamente: ${response.body}");
        return response.body;
      } else {
        print("Error al guardar la compra: ${response.body}");
        return response.body;
      }
    } catch (error) {
      throw Exception('Error al conectar con la API: $error');
    }
  }

  /// Obtiene todas las compras.
  Future<List<Compra>> getAllCompra() async {
    var url = Uri.parse("$baseUrl/Compra");

    try {
      var response =
          await http.get(url, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        var data = json['compras'] as List;

        List<Compra> records =
            data.map((json) => Compra.fromMap(json)).toList();

        return records;
      } else {
        print("Error al obtener las compras: ${response.body}");
        return [];
      }
    } catch (error) {
      throw Exception('Error al conectar con la API: $error');
    }
  }

  Future<List<DetalleCompra>> getAllCompraDetalles(String id) async {
    var url = Uri.parse("$baseUrl/Compra/Detalle/" + id);

    try {
      var response =
          await http.get(url, headers: {"Content-Type": "application/json"});

      var json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = json['detalles'] as List;

        List<DetalleCompra> records =
            data.map((json) => DetalleCompra.fromMap(json)).toList();

        return records;
      } else {
        print("Error al obtener los detalle de compra: ${response.body}");
        return [];
      }
    } catch (error) {
      throw Exception('Error al conectar con la API: $error');
    }
  }

  /// Guarda un detalle de compra individual (en caso de que se necesite por separado).
  Future<bool> guardarDetalleCompra(DetalleCompra detalleCompra) async {
    var url = Uri.parse("$baseUrl/CompraDetalle/Guardar");

    var body = jsonEncode(detalleCompra.toMap());

    print("Detalle enviado: $body");

    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200) {
        print("Detalle guardado exitosamente: ${response.body}");
        return true;
      } else {
        print("Error al guardar el detalle de compra: ${response.body}");
        return false;
      }
    } catch (error) {
      throw Exception('Error al conectar con la API: $error');
    }
  }
}
