import 'dart:io';

import 'package:comppatt/controller/clientecontroller.dart';
import 'package:comppatt/models/cliente.dart';
import 'package:pdf/pdf.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf/widgets.dart' as pw;

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
    fetchclientes();
  }

  Future<void> generatePDF(List<Cliente> clientes, BuildContext context) async {
    try {
      final pdf = pw.Document();

      // Crear el contenido del PDF
      pdf.addPage(
        pw.Page(
          build: (context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Reporte de Clientes',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  // Encabezado de la tabla
                  pw.TableRow(
                    children: [
                      pw.Text('Nombre',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Telefono',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Correo Electronico',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('RFC',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('CURP',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Domicilio',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Dias Credito',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                  // Filas de datos
                  ...clientes.map(
                    (cliente) => pw.TableRow(
                      children: [
                        pw.Text(cliente.nombre),
                        pw.Text(cliente.telefono),
                        pw.Text(cliente.correoElectronico),
                        pw.Text(cliente.rfc),
                        pw.Text(cliente.curp),
                        pw.Text(cliente.domicilio),
                        pw.Text(cliente.diasCredito.toString()),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      // Usar FilePicker para abrir el explorador de archivos
      String? savePath = await FilePicker.platform.saveFile(
        dialogTitle: 'Guardar Reporte de Clientes',
        fileName: 'reporte_clientes.pdf',
        allowedExtensions: ['pdf'], // Restringir a solo archivos PDF
        type: FileType.custom,
      );

      if (savePath == null) {
        // El usuario canceló la operación
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Operación cancelada")),
        );
        return;
      }

      // Guardar el archivo en la ubicación seleccionada
      final file = File(savePath);
      await file.writeAsBytes(await pdf.save());

      // Confirmación de guardado
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Reporte guardado en: $savePath")),
      );
    } catch (e) {
      // Manejo de errores
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al generar el PDF: $e")),
      );
    }
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
                  child:
                      Text('Error al cargar los clientes: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay clientes disponibles'));
            }

            // Mostrar la tabla de clientes
            return Container(
              // color: Colors.black,
              padding: EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Center(),
                  SizedBox(
                      height: 50,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () async {
                          await generatePDF(cliente, context);
                        },
                        child: Text('Guardar Reporte'),
                      )),
                  SizedBox(
                      child: DataTable(
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
                  ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
