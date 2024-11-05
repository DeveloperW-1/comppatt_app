import 'package:flutter/material.dart';
import '../../modules/sidebar.dart';

class SaveVenta extends StatelessWidget {
  const SaveVenta({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
        ),
        drawer: SideBar(title: 'Jefe Departamento',) // SideBar
      ),
    );
  }
}