import 'package:comppatt/modules/sidebar.dart';
import 'package:flutter/material.dart';
// import 'package:comppatt/controller/clientecontroller.dart';
// import 'package:comppatt/models/cliente.dart';
import 'package:comppatt/modules/table.dart';

class HomePageUser extends StatelessWidget {
  const HomePageUser({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Jefe de Departamento"),
        ),
        drawer: SideBar(
          title: 'Jefe Departamento',
        ),
        body: MyTable(title: "Jefe Departamento"),
      ),
    );
  }
}