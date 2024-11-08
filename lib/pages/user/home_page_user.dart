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
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          // backgroundColor: Color.fromARGB(0, 0, 0, 0),
          foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
          // title: const Text('Clientes'),
        ),
        backgroundColor: Color.fromRGBO(142, 142, 142, 100),
        drawer: SideBar(
          title: 'Jefe Departamento',
        ),
        body: MyTable(title: "Jefe Departamento"),
      ),
    );
  }
}
