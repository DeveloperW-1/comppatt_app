import 'package:comppatt/models/cliente.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MyTable extends StatelessWidget {
  MyTable({super.key});

  Future<List<Cliente>> getData() async {
    var url = Uri.parse("http://localhost:3000/allCliente");

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<Cliente>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Sin Datos'));
          }

          var data = snapshot.data!;

          return ListView(
            children: [
              DataTable(
                columns: const [
                  DataColumn(label: Text('Nombre')),
                  DataColumn(label: Text('Telefono')),
                  DataColumn(label: Text('Correo Electronico')),
                  DataColumn(label: Text('RFC')),
                  DataColumn(label: Text('CURP')),
                  DataColumn(label: Text('Domicilio')),
                  DataColumn(label: Text('Dias Credito')),
                  DataColumn(label: Text('Acciones')),
                ],
                rows: data
                    .map((item) => DataRow(cells: [
                          DataCell(Text(item.nombre)),
                          DataCell(Text(item.telefono)),
                          DataCell(Text(item.correoElectronico)),
                          DataCell(Text(item.rfc)),
                          DataCell(Text(item.curp)),
                          DataCell(Text(item.domicilio)),
                          DataCell(Text(item.diasCredito.toString())),
                          DataCell(ElevatedButton(
                            child: const Text("Abono"),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Acciones'),
                                  content: const Text('Redirigiendo a Abonos'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )),
                        ]))
                    .toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}
