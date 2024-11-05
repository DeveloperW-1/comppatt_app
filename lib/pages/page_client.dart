import 'package:comppatt/models/venta.dart';
import 'package:comppatt/modules/sidebar.dart';
import 'package:comppatt/modules/table_venta.dart';
import 'package:flutter/material.dart';
import 'package:comppatt/controller/clientecontroller.dart';

class PageClient extends StatelessWidget {
  final String curp;
  final String title;

  const PageClient({super.key, required this.curp, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
        // backgroundColor: Colors.transparent,
        // foregroundColor: Colors.white,
        // title: const Text('Ventas'),
      ),
      // backgroundColor: const Color.fromRGBO(142, 142, 142, 1),
      drawer: SideBar(title: title,),
      body: FutureBuilder<List<Venta>>(
        future: ClienteController().getVentasByID(curp), // Se cargan las ventas del cliente
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Mostrar spinner de carga
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error al cargar las ventas: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay ventas disponibles'));
          }

          // Los datos están disponibles
          var ventas = snapshot.data!;

          // Mostrar la tabla de ventas
          return TableVenta(ventas: ventas);
        },
      ),
      ),
      
    );
  }
}
