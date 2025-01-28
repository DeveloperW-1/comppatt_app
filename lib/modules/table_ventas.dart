import 'dart:io';

import 'package:comppatt/controller/proveedorcontroller.dart';
import 'package:comppatt/models/proveedor.dart';
// import 'package:comppatt/modules/table_venta.dart';
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
  List<Proveedor> proveedores = [];

  @override
  void initState() {
    super.initState();
    fetchProveedores(); // Cargar la lista inicial de proveedores
  }

    Future<void> generatePDF(List<Proveedor> proveedores, BuildContext context) async {
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
                      pw.Text('Monto Total',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Telefono',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Correo Electronico',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('RFC',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                    ],
                  ),
                  // Filas de datos
                  ...proveedores.map(
                    (proveedor) => pw.TableRow(
                      children: [
                        pw.Text(proveedor.id.toString()),
                        pw.Text(proveedor.nombre),
                        pw.Text(proveedor.contacto),
                        pw.Text(proveedor.direccion)
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
        dialogTitle: 'Guardar Reporte de proveedores',
        fileName: 'reporte_proveedores.pdf',
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

  // Función para obtener los proveedores desde el servidor
  Future<void> fetchProveedores() async {
    try {
      var fetchedproveedores = await ProveedorController().getProveedores();
      setState(() {
        proveedores = fetchedproveedores;
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
              .getProveedores(), 
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
                  ElevatedButton(onPressed: () async {
                    await generatePDF(proveedores, context);
                  }, child: Text("Guardar Reporte")),
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
                    rows: proveedores
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
