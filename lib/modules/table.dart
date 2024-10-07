
import 'package:flutter/material.dart';

class MyTable extends StatelessWidget {
  MyTable({super.key});
  final List<Map<String, dynamic>> data = [
    {
      "name": "Jerome Bell",
      "debt": 10,
      "country": "Nepal",
      "email": "jackson.graham@example.com",
      "dueDate": "30/4/2025",
      "phone": "(205) 555-0100"
    },
    {
      "name": "Cameron Williamson",
      "debt": 2,
      "country": "Netherlands",
      "email": "deanna.curtis@example.com",
      "dueDate": "30/4/2025",
      "phone": "(671) 555-0100"
    },
    // Más datos aquí
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          DataTable(
            columns: const [
              DataColumn(label: Text('Nombre')),
              DataColumn(label: Text('Adeudos')),
              DataColumn(label: Text('Dirección')),
              DataColumn(label: Text('Correo Electrónico')),
              DataColumn(label: Text('Fecha Corte')),
              DataColumn(label: Text('Num. Teléfono')),
              DataColumn(label: Text('Acciones')),
            ],
            rows: data
                .map((item) => DataRow(cells: [
                      DataCell(Text(item['name'])),
                      DataCell(Text(item['debt'].toString())),
                      DataCell(Text(item['country'])),
                      DataCell(Text(item['email'])),
                      DataCell(Text(item['dueDate'])),
                      DataCell(Text(item['phone'])),
                      DataCell(ElevatedButton(
                        child: Text("Abono"),
                        onPressed: () {
                          // como prueba se muestra un mensaje, Posteriormenete se hara referencia a la pantalla de Abonos
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text('Acciones'),
                                    content:
                                        Text('Redirigiendo a Abonos'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  ));
                        },
                      )),
                    ]))
                .toList(),
          ),
        ],
      ),
    );
  }
}
