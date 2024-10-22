import 'package:comppatt/modules/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:comppatt/controller/clientecontroller.dart';
import 'package:comppatt/models/cliente.dart';
import 'package:comppatt/modules/table.dart';

class HomePageAdmin extends StatelessWidget {
  const HomePageAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
        // title: const Text('Clientes'),
      ),
      backgroundColor: Color.fromRGBO(142, 142, 142, 100),
      drawer: SideBar(),
      body: FutureBuilder<List<Cliente>>(
        future: ClienteController().getAllClient(),  // Cargamos los datos de la API
        builder: (context, snapshot) {
          // Verifica si el snapshot tiene un estado de carga
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());  // Muestra un loader mientras se cargan los datos
          }

          // Verifica si hubo un error
          if (snapshot.hasError) {
            return Center(child: Text("Error al cargar los clientes: ${snapshot.error}"));
          }

          // Verifica si los datos son nulos o vacíos
          if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay clientes disponibles"));
          }

          // Pasamos la lista de clientes a MyTable solo si hay datos
          var clientes = snapshot.data!;
          return MyTable(clientes: clientes);
        },
      ),
    );
  }
}
