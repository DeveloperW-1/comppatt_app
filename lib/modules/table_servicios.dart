import 'dart:io';

import 'package:comppatt/controller/servicecontroller.dart';
import 'package:comppatt/models/service.dart'; // import 'package:comppatt/modules/table_venta.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf/widgets.dart' as pw;

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

  Future<void> generatePDF(
      List<Service> servicios, BuildContext context) async {
    try {
      final pdf = pw.Document();

      // Crear el contenido del PDF
      pdf.addPage(
        pw.Page(
          build: (context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Reporte de servicios',
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
                      pw.Text('Nombre',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Descripcion',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Tipo',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Precio Venta',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('IVA',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                    ],
                  ),
                  // Filas de datos
                  ...servicios.map(
                    (servicios) => pw.TableRow(
                      children: [
                        pw.Text(servicios.id.toString()),
                        pw.Text(servicios.nombre),
                        pw.Text(servicios.descripcion),
                        pw.Text(servicios.tipo.name),
                        pw.Text(servicios.precioVenta.toString()),
                        pw.Text(servicios.iva.toString())
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
        dialogTitle: 'Guardar Reporte de servicios',
        fileName: 'reporte_servicios.pdf',
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
        body: FutureBuilder<List<Service>>(
          future: ServiceController()
              .getAllServices(), // Se cargan las ventas del servicios
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child:
                      CircularProgressIndicator()); // Mostrar spinner de carga
            }

            if (snapshot.hasError) {
              return Center(
                  child:
                      Text('Error al cargar los servicios: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay servicios disponibles'));
            }

            // Mostrar la tabla de servicios
            return Container(
              // color: Colors.black,
              padding: EdgeInsets.only(top: 50, left: 45, right: 100),
              child: ListView(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await generatePDF(servicios, context);
                    },
                    child: Text('Guardar Reporte'),
                  ),
                  DataTable(
                    columns: const [
                      DataColumn(
                          label: Text(
                        'ID',
                      )),
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
                        'Precio Venta',
                      )),
                      DataColumn(
                          label: Text(
                        'IVA',
                      )),
                    ],
                    rows: servicios
                        .map((item) => DataRow(
                              cells: [
                                DataCell(Text(item.id.toString())),
                                DataCell(Text(item.nombre)),
                                DataCell(Text(item.descripcion)),
                                DataCell(Text(item.tipo.name)),
                                DataCell(Text(item.precioVenta.toString())),
                                DataCell(Text(item.iva.toString())),
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
