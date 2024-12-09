import 'package:comppatt/controller/proveedorcontroller.dart';
import 'package:comppatt/models/proveedor.dart';
// import 'package:comppatt/modules/table_venta.dart';
import 'package:flutter/material.dart';

class TableProveedores extends StatefulWidget {
  final String title;

  const TableProveedores({super.key, required this.title});

  @override
  _TableProveedores createState() => _TableProveedores();
}

class _TableProveedores extends State<TableProveedores> {
  List<Proveedor> servicios = [];

  @override
  void initState() {
    super.initState();
    fetchProveedores(); // Cargar la lista inicial de servicios
  }

  // Función para obtener los servicios desde el servidor
  Future<void> fetchProveedores() async {
    try {
      var fetchedproveedores = await ProveedorController().getProveedores();
      setState(() {
        servicios = fetchedproveedores;
      });
    } catch (e) {
      print('Error al cargar los proveedores: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Color.fromRGBO(33, 33, 33, 100),
        body: FutureBuilder<List<Proveedor>>(
          future: ProveedorController()
              .getProveedores(), // Se cargan las ventas del cliente
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child:
                      CircularProgressIndicator()); // Mostrar spinner de carga
            }

            if (snapshot.hasError) {
              return Center(
                  child: Text('Error al cargar los proveedores: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay proveedores disponibles'));
            }

            // Mostrar la tabla de proveedores
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
                        'Contacto',
                      )),
                      DataColumn(
                          label: Text(
                        'Direccion',
                      )),
                    ],
                    rows: servicios
                        .map((item) => DataRow(
                              cells: [
                                DataCell(Text(item.nombre)),
                                DataCell(Text(item.contacto)),
                                DataCell(Text(item.direccion))
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
