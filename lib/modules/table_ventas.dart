import 'dart:io';
import 'package:comppatt/controller/ventacontroller.dart';
import 'package:comppatt/models/venta.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf/widgets.dart' as pw;

class TableVentas extends StatefulWidget {
  final String title;

  const TableVentas({super.key, required this.title});

  @override
  _TableVentas createState() => _TableVentas();
}

class _TableVentas extends State<TableVentas> {
  List<Venta> ventas = [];

  @override
  void initState() {
    super.initState();
    fetchVentas(); // Cargar la lista inicial de ventas
  }

  Future<void> generatePDF(List<Venta> ventas, BuildContext context) async {
    try {
      final pdf = pw.Document();

      // Crear el contenido del PDF
      pdf.addPage(
        pw.Page(
          build: (context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Reporte de ventas',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  // Encabezado de la tabla
                  pw.TableRow(
                    children: [
                      pw.Text('ID',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Monto Total',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Plazo Meses',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Fecha Venta',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Fecha Corte',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Taza Intereses',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Cliente',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                  // Filas de datos
                  ...ventas.map(
                    (venta) => pw.TableRow(
                      children: [
                        pw.Text(venta.id.toString()),
                        pw.Text(venta.montoTotal.toString()),
                        pw.Text(venta.plazoMeses.toString()),
                        pw.Text(venta.fechaVenta.toIso8601String()),
                        pw.Text(venta.fechaCorte.toIso8601String()),
                        pw.Text(venta.tazaIntereses.toString()),
                        pw.Text(venta.cliente.toString()),
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
        dialogTitle: 'Guardar Reporte de ventas',
        fileName: 'reporte_ventas.pdf',
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

  // Función para obtener las ventas desde el servidor
  Future<void> fetchVentas() async {
    try {
      var fetchedVentas = await Ventacontroller().getVentas();
      setState(() {
        ventas = fetchedVentas;
      });
    } catch (e) {
      print('Error al cargar las ventas: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Color.fromRGBO(33, 33, 33, 100),
        body: FutureBuilder<List<Venta>>(
          future: Ventacontroller().getVentas(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child:
                      CircularProgressIndicator()); // Mostrar spinner de carga
            }

            if (snapshot.hasError) {
              return Center(
                  child: Text('Error al cargar las ventas: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay ventas disponibles'));
            }

            // Mostrar la tabla de ventas
            return Container(
              padding: EdgeInsets.only(top: 50, left: 45, right: 100),
              child: ListView(
                children: [
                  ElevatedButton(onPressed: () async {
                    await generatePDF(snapshot.data!, context);
                  }, child: Text("Guardar Reporte")),
                  DataTable(
                    columns: const [
                      DataColumn(
                          label: Text(
                        'ID',
                      )),
                      DataColumn(
                          label: Text(
                        'Monto Total',
                      )),
                      DataColumn(
                          label: Text(
                        'Plazo Meses',
                      )),
                      DataColumn(
                          label: Text(
                        'Fecha Venta',
                      )),
                      DataColumn(
                          label: Text(
                        'Fecha Corte',
                      )),
                      DataColumn(
                          label: Text(
                        'Taza Intereses',
                      )),
                      DataColumn(
                          label: Text(
                        'Cliente',
                      )),
                    ],
                    rows: snapshot.data!
                        .map((item) => DataRow(
                              cells: [
                                DataCell(Text(item.id.toString())),
                                DataCell(Text(item.montoTotal.toString())),
                                DataCell(Text(item.plazoMeses.toString())),
                                DataCell(Text(item.fechaVenta.toIso8601String())),
                                DataCell(Text(item.fechaCorte.toIso8601String())),
                                DataCell(Text(item.tazaIntereses.toString())),
                                DataCell(Text(item.cliente.toString())),
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