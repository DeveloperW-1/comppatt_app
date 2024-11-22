import 'package:comppatt/modules/sidebar.dart';
import 'package:comppatt/modules/table_proveedores.dart';
import 'package:flutter/material.dart';
// import 'package:comppatt/controller/clientecontroller.dart';
// import 'package:comppatt/models/cliente.dart';

class ViewSupplier extends StatelessWidget {
  final String title;
  const ViewSupplier({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(),
        drawer: SideBar(
          title: title,
        ),
        body: TableProveedores(title: title),
      ),
    );
  }
}