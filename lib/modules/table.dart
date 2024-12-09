import 'package:comppatt/controller/clientecontroller.dart';
// import 'package:comppatt/modules/table_venta.dart';
import 'package:comppatt/pages/page_client.dart';
import 'package:comppatt/pages/user/save_client.dart';
import 'package:flutter/material.dart';
import 'package:comppatt/models/cliente.dart';
import 'package:flutter/rendering.dart';

class MyTable extends StatefulWidget {
  final String title;

  const MyTable({super.key, required this.title});

  @override
  _MyTableState createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  List<Cliente> clientes = [];

  @override
  void initState() {
    super.initState();
    fetchClientes(); // Cargar la lista inicial de clientes
  }

  // Función para obtener los clientes desde el servidor
  Future<void> fetchClientes() async {
    try {
      var fetchedClientes = await ClienteController().getAllClient();
      setState(() {
        clientes = fetchedClientes;
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
          body: Container(
            // color: Colors.black,
            padding: EdgeInsets.only(top: 50, left: 40, right: 80),
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
                    DataColumn(
                        label: Text(
                      'Acciones',
                    )),
                  ],
                  rows: clientes
                      .map((item) => DataRow(
                            cells: [
                              DataCell(Text(item.nombre)),
                              DataCell(Text(item.telefono)),
                              DataCell(Text(item.correoElectronico)),
                              DataCell(Text(item.rfc)),
                              DataCell(Text(item.curp)),
                              DataCell(Text(item.domicilio)),
                              DataCell(Text(item.diasCredito.toString())),
                              DataCell(Row(
                                children: [
                                  ElevatedButton(
                                    child: const Text("Abono"),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(item.curp),
                                          content: Text((item.curp).toString()),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PageClient(
                                                      curp: item.curp,
                                                      title: widget.title,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(width: 5),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green),
                                    child: const Text("Modificar"),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddClientForm(
                                                    cliente: item,
                                                    title: widget.title,
                                                  )));
                                    },
                                  ),
                                ],
                              )),
                            ],
                          ))
                      .toList(),
                ),
              ],
            ),
          )),
    );
  }
}
