import 'dart:async';
import 'dart:convert';
import 'package:comppatt/models/service.dart';
import 'package:http/http.dart' as http;

class ServiceController {
  // POST: Crear un servicio
  Future<bool> saveService(Service service) async {
    var url = Uri.parse("http://localhost:3000/Servicio/Guardar");

    var body = jsonEncode(service.toMap());

    print(body);

    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200) {
        return true; // Servicio creado exitosamente
      } else {
        print("Error al guardar el servicio: ${response.body}");
        return false;
      }
    } catch (error) {
      throw Exception('Error al conectar con la API: $error');
    }
  }

  // // PUT: Actualizar un servicio
  // Future<bool> updateService(Service service) async {
  //   var url = Uri.parse("http://localhost:3000/servicio/${service.id}");

  //   var body = jsonEncode(service.toMap());

  //   try {
  //     var response = await http.put(
  //       url,
  //       headers: {"Content-Type": "application/json"},
  //       body: body,
  //     );

  //     if (response.statusCode == 200) {
  //       return true; // Servicio actualizado exitosamente
  //     } else {
  //       print("Error al actualizar el servicio: ${response.body}");
  //       return false;
  //     }
  //   } catch (error) {
  //     throw Exception('Error al conectar con la API: $error');
  //   }
  // }

  // GET: Obtener todos los servicios
  Future<List<Service>> getAllServices() async {
    var url = Uri.parse("http://localhost:3000/servicios");

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body) as List;

        List<Service> services =
            json.map((item) => Service.fromMap(item)).toList();
        return services;
      } else {
        throw Exception('Error al cargar los servicios: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error al conectar con la API: $error');
    }
  }
}
