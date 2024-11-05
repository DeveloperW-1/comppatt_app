import 'package:comppatt/pages/user/home_page_user.dart';
import 'package:comppatt/pages/user/save_client.dart';
import 'package:comppatt/pages/user/save_venta.dart';
import 'package:flutter/material.dart';
// import '../pages/sell.dart';
// 
class SideBar extends StatefulWidget {
  final String
      title; // Parámetro que recibirá el título (Administrador o Jefe de Departamento)

  const SideBar({super.key, required this.title});

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromRGBO(33, 33, 33, 100),
      child: Container(
        color: Color.fromRGBO(31, 29, 29, 80),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Header (Optional)
            DrawerHeader(
              decoration: BoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget
                        .title, // Usamos el parámetro title para mostrar el título
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(142, 142, 142, 100),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.search, color: Colors.white),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Buscar',
                              hintStyle: TextStyle(color: Colors.white54),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Opciones visibles para todos
            ListTile(
              title: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePageUser()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(21, 21, 21, 100),
                  ),
                  child: const Text('Inicio')),
            ),
            // Condicional para mostrar opciones si no es Jefe de Departamento
            if (widget.title != 'Jefe Departamento') ...[
              ListTile(
                title: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(21, 21, 21, 100),
                    ),
                    child: const Text('Reportes')),
              ),
              ListTile(
                title: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(21, 21, 21, 100),
                    ),
                    child: const Text('Consultas')),
              ),
            ],
            // Opciones específicas para Jefe Departamento
            if (widget.title == 'Jefe Departamento') ...[
              ListTile(
                title: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SaveVenta()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(21, 21, 21, 100),
                    ),
                    child: const Text('Ventas')),
              ),
              ListTile(
                title: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(21, 21, 21, 100),
                    ),
                    child: const Text('Cliente Particular')),
              ),
              ListTile(
                title: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(21, 21, 21, 100),
                    ),
                    child: const Text('Abonos')),
              ),
            ],
            ListTile(
              title: const Text('Utilerías'),
              textColor: Colors.white,
              trailing: Icon(
                isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: Colors.white,
              ),
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
            ),
            if (isExpanded)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.title == 'Jefe Departamento') ...[
                      ListTile(
                        title: const Text('Agregar Producto'),
                        textColor: Colors.white,
                        onTap: () {
                          // Acción
                        },
                      ),
                        ListTile(
                        title: const Text('Agregar Cliente'),
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddClientForm()));
                        },
                      ),
                      ListTile(
                        title: const Text('Agregar Servicio'),
                        textColor: Colors.white,
                        onTap: () {
                          // Acción
                        },
                      ),
                      ListTile(
                        title: const Text('Inventario'),
                        textColor: Colors.white,
                        onTap: () {
                          // Acción
                        },
                      ),
                    ] else ...[
                      // Otras opciones si no es Jefe Departamento (opciones de utilerías para admin)
                      ListTile(
                        title: const Text('Ventas'),
                        textColor: Colors.white,
                        onTap: () {
                          // Acción
                        },
                      ),
                      ListTile(
                        title: const Text('Abonos'),
                        textColor: Colors.white,
                        onTap: () {
                          // Acción
                        },
                      ),
                      ListTile(
                        title: const Text('Cliente Particular'),
                        textColor: Colors.white,
                        onTap: () {
                          // Acción
                        },
                      ),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
