// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';
import 'package:comppatt/models/venta.dart';
import 'package:http/http.dart' as http;
import 'package:comppatt/models/cliente.dart';

class ClienteController {
// POST: Funcion para poder crear clientes

  Future<bool> saveCliente(Cliente cliente) async {
    var url = Uri.parse("http://localhost:3000/Cliente/Guardar");

    var body = jsonEncode(cliente.toMap());

    print(body);

    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      // Si la solicitud es exitosa
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (error) {
      // Si ocurre algún error en la solicitud
      throw Exception('Error al realizar la solicitud: $error');
    }
  }

// PUT: Función para actualizar clientes
  Future<bool>  updateCliente(Cliente cliente) async {
    var url = Uri.parse("http://localhost:3000/Cliente/Actualizar");

    var body = jsonEncode(cliente.toMap());

    print(body);

    try {
      var response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      // Si la solicitud es exitosa
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (error) {
      // Si ocurre algún error en la solicitud
      throw Exception('Error al realizar la solicitud: $error');
    }
  }

  Future<bool> deleteCliente(String curp) async {
    var url = Uri.parse("http://localhost:3000/Cliente/Eliminar");

    try {
      var response = await http.delete(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"curp": curp}),
      );

      // Verifica el estado de la respuesta
      if (response.statusCode == 200) {
        return true; // Éxito en la eliminación
      } else {
        print("Error al eliminar el cliente: ${response.body}");
        return false;
      }
    } catch (error) {
      print("Error al conectar con la API: $error");
      return false;
    }
  }

// GET: Funcion para obtener todos los clientes
  Future<List<Cliente>> getAllClient() async {
    var url = Uri.parse("http://localhost:3000/Clientes");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      if (json['clientes'] != null) {
        var data = json['clientes'] as List;

        List<Cliente> records =
            data.map((item) => Cliente.fromMap(item)).toList();
        return records;
        print(records);
      } else {
        return [];
      }
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  Future<List<Venta>> getVentasByID(String id) async {
    var url = Uri.parse("http://localhost:3000/Cliente/Venta/" + id.toString());

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      print(json);

      if (json['ventas'] != null) {
        var data = json['ventas'] as List;

        List<Venta> records = data.map((item) => Venta.fromMap(item)).toList();
        print(records);
        return records;
      } else {
        return [];
      }
    } else {
      throw Exception('Error al cargar los datos');
    }
  }
}
