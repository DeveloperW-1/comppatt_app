import 'dart:io';
import 'package:comppatt/controller/compracontroller.dart';
import 'package:comppatt/models/compra.dart';
import 'package:comppatt/models/compraDetalle.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:file_picker/file_picker.dart';

// Tabla de Compras
class TableCompras extends StatefulWidget {
  final String title;
  const TableCompras({super.key, required this.title});

  @override
  _TableComprasState createState() => _TableComprasState();
}

class _TableComprasState extends State<TableCompras> {
  List<Compra> compras = []; // Lista de compras

  @override
  void initState() {
    super.initState();
    fetchCompras(); // Cargar compras
  }

  // Simulación de datos (reemplaza con API)
  Future<void> fetchCompras() async {
    try {
      List<Compra> fetchCompras = await CompraController().getAllCompra();

      setState(() {
        compras = fetchCompras;
      });
    } catch (e) {
      print('Error al cargar las compras: $e');
    }
  }

  // Generar PDF con los detalles de la compra
  Future<void> generateDetallePDF(
      Compra compra, List<DetalleCompra> detalles) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          children: [
            pw.Text(
              "Detalles de la Compra (ID: ${compra.id})",
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 10),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                // Encabezado
                pw.TableRow(
                  children: [
                    pw.Text('Cantidad',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Precio Unitario',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('IVA',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Subtotal',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                // Detalles
                ...detalles.map(
                  (detalle) => pw.TableRow(
                    children: [
                      pw.Text(detalle.cantidad.toString()),
                      pw.Text(detalle.precioUnitario.toStringAsFixed(2)),
                      pw.Text(detalle.iva.toStringAsFixed(2)),
                      pw.Text(detalle.subtotal.toStringAsFixed(2)),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              "Monto Total: \$${compra.montoTotal.toStringAsFixed(2)}",
              style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.red),
            ),
          ],
        ),
      ),
    );

    // Guardar PDF
    String? savePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Guardar Detalles de la Compra',
      fileName: 'detalle_compra_${compra.id}.pdf',
      allowedExtensions: ['pdf'],
      type: FileType.custom,
    );

    if (savePath == null) {
      // El usuario canceló la operación
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Operación cancelada")),
      );
      return;
    }

    final file = File(savePath);
    await file.writeAsBytes(await pdf.save());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Reporte guardado en: $savePath")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Color.fromRGBO(33, 33, 33, 100),
        body: FutureBuilder<List<Compra>>(
          future: CompraController().getAllCompra(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child:
                      CircularProgressIndicator()); // Mostrar spinner de carga
            }

            if (snapshot.hasError) {
              return Center(
                  child:
                      Text('Error al cargar las compras: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay compras disponibles'));
            }

            // Mostrar la tabla de proveedores
            return Container(
              // color: Colors.black,
              padding: EdgeInsets.only(top: 50, left: 45, right: 100),
              child: ListView(
                children: [
                  // ElevatedButton(onPressed: () async {
                  //   await generatePDF(proveedores, context);
                  // }, child: Text("Guardar Reporte")),
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Monto Total')),
                      DataColumn(label: Text('Fecha')),
                      DataColumn(label: Text('Acciones')),
                    ],
                    rows: compras
                        .map(
                          (compra) => DataRow(
                            cells: [
                              DataCell(Text(compra.id.toString())),
                              DataCell(Text(
                                  "\$${compra.montoTotal.toStringAsFixed(2)}")),
                              DataCell(Text(compra.fecha.toIso8601String())),
                              DataCell(
                                ElevatedButton(
                                  onPressed: () async {
                                    List<DetalleCompra> compraDetalles =
                                        await CompraController()
                                            .getAllCompraDetalles(
                                                compra.id.toString());
                                    await generateDetallePDF(
                                        compra, compraDetalles);
                                  },
                                  child: const Text("Guardar Detalles"),
                                ),
                              ),
                            ],
                          ),
                        )
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
