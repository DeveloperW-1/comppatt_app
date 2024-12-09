import 'package:flutter/material.dart';
import '../../modules/sidebar.dart';

class SaveVenta extends StatefulWidget {
  const SaveVenta({super.key});

  @override
  _SaveVenta createState() => _SaveVenta();
}

class _SaveVenta extends State<SaveVenta> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Color.fromRGBO(33, 33, 33, 100),
        appBar: AppBar(
          title: Text("Guardar Venta"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Regresa a la pantalla anterior
            },
          ),
        ),
        drawer: SideBar(title: 'Jefe Departamento'),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: SizedBox(
                              width: 400,
                              height: 50,
                              child: TextFormField(
                                  decoration: InputDecoration(
                                labelText: 'ID Cliente',
                                filled: true,
                                fillColor: Colors.grey[800],
                              )))),
                      SizedBox(width: 100),
                      Center(
                          child: SizedBox(
                              width: 200,
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Buscar"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromRGBO(106, 66, 171, 100),
                                  ))))
                    ],
                  )
                ],
              ),
            ),
          )),
        ), // SideBar
      ),
    );
  }
}
