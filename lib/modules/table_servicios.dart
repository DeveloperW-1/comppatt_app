import 'package:comppatt/controller/servicecontroller.dart';
import 'package:comppatt/models/service.dart';// import 'package:comppatt/modules/table_venta.dart';
import 'package:flutter/material.dart';

class TableServicios extends StatefulWidget {
  final String title;

  const TableServicios({super.key, required this.title});

  @override
  _TableServicios createState() => _TableServicios();
}

class _TableServicios extends State<TableServicios> {
  List<Service> servicios = [];

  @override
  void initState() {
    super.initState();
    fetchservicios(); // Cargar la lista inicial de servicios
  }

  // Función para obtener los servicios desde el servidor
  Future<void> fetchservicios() async {
    try {
      var fetchedservicios = await ServiceController().getAllServices();
      setState(() {
        servicios = fetchedservicios;
      });
    } catch (e) {
      print('Error al cargar los servicios: $e');
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
                      'Descripcion',
                    )),
                    DataColumn(
                        label: Text(
                      'Tipo',
                    )),
                    DataColumn(
                        label: Text(
                      'Precio Compra',
                    )),
                    DataColumn(
                        label: Text(
                      'Precio Venta',
                    )),
                    DataColumn(
                        label: Text(
                      'ID del Proveedor',
                    )),
                  ],
                  rows: servicios
                      .map((item) => DataRow(
                            cells: [
                              DataCell(Text(item.nombre)),
                              DataCell(Text(item.descripcion)),
                              DataCell(Text(item.tipo.name)),
                              DataCell(Text(item.precioCompra.toString())),
                              DataCell(Text(item.precioVenta.toString())),
                              DataCell(Text(item.proveedor.toString())),
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
