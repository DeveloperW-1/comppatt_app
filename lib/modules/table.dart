import 'package:comppatt/controller/clientecontroller.dart';
// import 'package:comppatt/modules/table_venta.dart';
import 'package:comppatt/pages/page_client.dart';
import 'package:comppatt/pages/user/save_client.dart';
import 'package:flutter/material.dart';
import 'package:comppatt/models/cliente.dart';

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
      home: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            DataTable(
              columns: const [
                DataColumn(
                    label: Text('Nombre',
                        style: TextStyle(
                            color: Color.fromARGB(255, 174, 174, 174)))),
                DataColumn(
                    label: Text('Telefono',
                        style: TextStyle(
                            color: Color.fromARGB(255, 174, 174, 174)))),
                DataColumn(
                    label: Text('Correo Electronico',
                        style: TextStyle(
                            color: Color.fromARGB(255, 174, 174, 174)))),
                DataColumn(
                    label: Text('RFC',
                        style: TextStyle(
                            color: Color.fromARGB(255, 174, 174, 174)))),
                DataColumn(
                    label: Text('CURP',
                        style: TextStyle(
                            color: Color.fromARGB(255, 174, 174, 174)))),
                DataColumn(
                    label: Text('Domicilio',
                        style: TextStyle(
                            color: Color.fromARGB(255, 174, 174, 174)))),
                DataColumn(
                    label: Text('Dias Credito',
                        style: TextStyle(
                            color: Color.fromARGB(255, 174, 174, 174)))),
                DataColumn(
                    label: Text('Acciones',
                        style: TextStyle(
                            color: Color.fromARGB(255, 174, 174, 174)))),
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
                                              AddClientForm(cliente: item,)));
                                },
                              ),
                              SizedBox(width: 5),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                child: const Text("Eliminar"),
                                onPressed: () async {
                                  bool confirm = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                            const Text("Confirmar eliminación"),
                                        content: const Text(
                                            "¿Estás seguro de que deseas eliminar este cliente?"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text("Cancelar"),
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                          ),
                                          TextButton(
                                            child: const Text("Eliminar"),
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  if (confirm) {
                                    bool success = await ClienteController()
                                        .deleteCliente(item.curp);
                                    if (success) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Cliente Eliminado Exitosamente')),
                                      );
                                      fetchClientes(); // Actualizar la lista tras la eliminación
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'No se pudo eliminar el cliente')),
                                      );
                                    }
                                  }
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
      ),
    );
  }
}
