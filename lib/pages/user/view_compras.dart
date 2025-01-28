import 'package:comppatt/modules/sidebar.dart';
import 'package:comppatt/modules/table_clientes.dart';
import 'package:comppatt/modules/table_compras.dart';
import 'package:flutter/material.dart';
// import 'package:comppatt/controller/clientecontroller.dart';
// import 'package:comppatt/models/cliente.dart';

class ViewCompras extends StatelessWidget {
  final String title;
  const ViewCompras({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Reporte de Compras"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Regresa a la pantalla anterior
            },
          ),
        ),
        drawer: SideBar(
          title: title,
        ),
        body: TableCompras(title: title),
      ),
    );
  }
}
