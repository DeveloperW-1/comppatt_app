import 'package:comppatt/pages/page_client.dart';
import 'package:flutter/material.dart';
import 'package:comppatt/models/cliente.dart';

class MyTable extends StatelessWidget {
  final List<Cliente> clientes;  // Recibe la lista de clientes como parámetro

  const MyTable({super.key, required this.clientes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Color.fromRGBO(0, 0, 0, 100), 
        child: ListView(
          children: [
            DataTable(
              columns: const [
                DataColumn(
                  label: Text(
                    'Nombre', 
                    style: TextStyle(color: Color.fromARGB(255, 174, 174, 174))
                  )
                ),
                DataColumn(
                  label: Text(
                    'Telefono', 
                    style: TextStyle(color: Color.fromARGB(255, 174, 174, 174))
                  )
                ),
                DataColumn(
                  label: Text(
                    'Correo Electronico', 
                    style: TextStyle(color: Color.fromARGB(255, 174, 174, 174))
                  )
                ),
                DataColumn(
                  label: Text(
                    'RFC', 
                    style: TextStyle(color: Color.fromARGB(255, 174, 174, 174))
                  )
                ),
                DataColumn(
                  label: Text(
                    'CURP', 
                    style: TextStyle(color: Color.fromARGB(255, 174, 174, 174))
                  )
                ),
                DataColumn(
                  label: Text(
                    'Domicilio', 
                    style: TextStyle(color: Color.fromARGB(255, 174, 174, 174))
                  )
                ),
                DataColumn(
                  label: Text(
                    'Dias Credito', 
                    style: TextStyle(color: Color.fromARGB(255, 174, 174, 174))
                  )
                ),
                DataColumn(
                  label: Text(
                    'Acciones', 
                    style: TextStyle(color: Color.fromARGB(255, 174, 174, 174))
                  )
                ),
              ],
              rows: clientes.map((item) => DataRow(
                cells: [
                  DataCell(
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 150), // Limita el ancho a 150px
                      child: Text(item.nombre, 
                        style: const TextStyle(color: Colors.white),
                        overflow: TextOverflow.visible, // Para saltar al siguiente renglón
                      ),
                    )
                  ),
                  DataCell(
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 100),
                      child: Text(item.telefono, 
                        style: const TextStyle(color: Colors.white),
                        overflow: TextOverflow.visible,
                      ),
                    )
                  ),
                  DataCell(
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 200), // Limita ancho del correo
                      child: Text(item.correoElectronico, 
                        style: const TextStyle(color: Colors.white),
                        overflow: TextOverflow.visible,
                      ),
                    )
                  ),
                  DataCell(
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 100),
                      child: Text(item.rfc, 
                        style: const TextStyle(color: Colors.white),
                        overflow: TextOverflow.visible,
                      ),
                    )
                  ),
                  DataCell(
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 150),
                      child: Text(item.curp, 
                        style: const TextStyle(color: Colors.white),
                        overflow: TextOverflow.visible,
                      ),
                    )
                  ),
                  DataCell(
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 250),
                      child: Text(item.domicilio, 
                        style: const TextStyle(color: Colors.white),
                        overflow: TextOverflow.visible,
                      ),
                    )
                  ),
                  DataCell(
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 80),
                      child: Text(item.diasCredito.toString(), 
                        style: const TextStyle(color: Colors.white),
                        overflow: TextOverflow.visible,
                      ),
                    )
                  ),
                  DataCell(
                    ElevatedButton(
                      child: const Text("Abono"),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(item.curp),
                            content: const Text("Abono"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(builder: (context) => PageClient(curp: item.curp))
                                  );
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ),
                ],
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
