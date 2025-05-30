import 'package:comppatt/models/venta.dart';
import 'package:flutter/material.dart';

class TableVenta extends StatelessWidget {
  final List<Venta> ventas; // Recibe la curp del cliente

  const TableVenta({super.key, required this.ventas});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
          backgroundColor: Color.fromRGBO(33, 33, 33, 100),
          body: Container(
        padding: EdgeInsets.only(top: 50, left: 45, right: 100),
        child: ListView(
          children: [
            DataTable(
              columns: const [
                DataColumn(
                    label: Text('ID',
                        style: TextStyle(
                            color: Color.fromARGB(255, 174, 174, 174)))),
                DataColumn(
                    label: Text('Monto Total',
                        style: TextStyle(
                            color: Color.fromARGB(255, 174, 174, 174)))),
                DataColumn(
                    label: Text('Plazo Meses',
                        style: TextStyle(
                            color: Color.fromARGB(255, 174, 174, 174)))),
                DataColumn(
                    label: Text('Fecha Venta',
                        style: TextStyle(
                            color: Color.fromARGB(255, 174, 174, 174)))),
                DataColumn(
                    label: Text('Fecha Corte',
                        style: TextStyle(
                            color: Color.fromARGB(255, 174, 174, 174)))),
                DataColumn(
                    label: Text('Taza Interes',
                        style: TextStyle(
                            color: Color.fromARGB(255, 174, 174, 174)))),
                DataColumn(
                    label: Text('Abono',
                        style: TextStyle(
                            color: Color.fromARGB(255, 174, 174, 174))))
              ],
              rows: ventas
                  .map((item) => DataRow(
                        cells: [
                          DataCell(Text(item.id.toString(),
                              style: const TextStyle(color: Colors.white))),
                          DataCell(Text((item.montoTotal.toString()),
                              style: const TextStyle(color: Colors.white))),
                          DataCell(Text(item.plazoMeses.toString(),
                              style: const TextStyle(color: Colors.white))),
                          DataCell(Text(item.fechaVenta.toString(),
                              style: const TextStyle(color: Colors.white))),
                          DataCell(Text(item.fechaCorte.toString(),
                              style: const TextStyle(color: Colors.white))),
                          DataCell(Text(item.tazaIntereses.toString(),
                              style: const TextStyle(color: Colors.white))),
                          DataCell(ElevatedButton(
                            child: const Text("=>"),
                            onPressed: () {
                              // showDialog(
                              //   context: context,
                              //   builder: (context) => AlertDialog(
                              //     title: Text(item.curp),
                              //     content: const Text("Abono"),
                              //     actions:
                              //     <Widget>[
                              //       TextButton(
                              //         onPressed: () {
                              //           Navigator.push(context, MaterialPageRoute(builder: (context) => PageClient(curp: item.curp)));
                              //         },
                              //         child: const Text('OK'),
                              //       ),
                              //     ],
                              //   ),
                              // );
                            },
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
