import 'package:comppatt/controller/clientecontroller.dart';
import 'package:comppatt/models/cliente.dart';
import 'package:flutter/material.dart';

class TablaClientes extends StatefulWidget {
  final String title;

  const TablaClientes({super.key, required this.title});

  @override
  _TablaClientes createState() => _TablaClientes();
}

class _TablaClientes extends State<TablaClientes> {
  List<Cliente> cliente = [];

  @override
  void initState() {
    super.initState();
    fetchclientes(); // Cargar la lista inicial de cliente
  }

  // Función para obtener los cliente desde el servidor
  Future<void> fetchclientes() async {
    try {
      List<Cliente> fetchclientes = await ClienteController().getAllClient();
      setState(() {
        cliente = fetchclientes;
      });
    } catch (e) {
      print('Error al cargar los clientes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Color.fromRGBO(33, 33, 33, 100),
        body: FutureBuilder<List<Cliente>>(
          future: ClienteController()
              .getAllClient(), // Se cargan las ventas del cliente
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child:
                      CircularProgressIndicator()); // Mostrar spinner de carga
            }

            if (snapshot.hasError) {
              return Center(
                  child: Text('Error al cargar los clientes: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay clientes disponibles'));
            }

            // Mostrar la tabla de clientes
            return Container(
              // color: Colors.black,
              padding: EdgeInsets.only(top: 50, left: 45, right: 100),
              child: ListView(
                children: [
                  DataTable(
                    columns: const [
                      DataColumn(
                          label: Text(
                        'Nombre',
                      )),
                      DataColumn(
                          label: Text(
                        'Telefono',
                      )),
                      DataColumn(
                          label: Text(
                        'Correo Electronico',
                      )),
                      DataColumn(
                          label: Text(
                        'RFC',
                      )),
                      DataColumn(
                          label: Text(
                        'CURP',
                      )),
                      DataColumn(
                          label: Text(
                        'Domicilio',
                      )),
                      DataColumn(
                          label: Text(
                        'Dias Credito',
                      )),
                    ],
                    rows: cliente
                        .map((item) => DataRow(
                              cells: [
                                DataCell(Text(item.nombre)),
                                DataCell(Text(item.telefono)),
                                DataCell(Text(item.correoElectronico)),
                                DataCell(Text(item.rfc)),
                                DataCell(Text(item.curp)),
                                DataCell(Text(item.domicilio)),
                                DataCell(Text((item.diasCredito).toString())),
                              ],
                            ))
                        .toList(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
