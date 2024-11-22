import 'package:comppatt/modules/table_servicios.dart';
import 'package:comppatt/pages/home_page_admin.dart';
import 'package:comppatt/pages/user/home_page_user.dart';
import 'package:comppatt/pages/user/save_client.dart';
import 'package:comppatt/pages/user/save_service.dart';
import 'package:comppatt/pages/user/save_supplier.dart';
import 'package:comppatt/pages/user/save_venta.dart';
import 'package:comppatt/pages/user/view_services.dart';
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
                ],
              ),
            ),
            // Opciones visibles para todos
            if (widget.title == "Jefe Departamento") ...[
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
            ] else ...{
              ListTile(
                title: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePageAdmin()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(21, 21, 21, 100),
                    ),
                    child: const Text('Inicio')),
              )
            },
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
                    child: const Text('Venta')),
              ),
              ListTile(
                title: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(21, 21, 21, 100),
                    ),
                    child: const Text('Cliente Particular')),
              )
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
                        title: const Text('Agregar Cliente'),
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddClientForm(title: widget.title,)));
                        },
                      ),
                      ListTile(
                        title: const Text('Agregar Servicio'),
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddServiceForm(title: widget.title)));
                        },
                      ),
                      ListTile(
                        title: const Text('Agregar Proveedor'),
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddProveedorForm(title: widget.title)));
                        },
                      ),
                      ListTile(
                        title: const Text('Inventario de Proveedores'),
                        textColor: Colors.white,
                        onTap: () {
                          // Acción
                        },
                      ),
                      ListTile(
                        title: const Text('Inventario de Servicios'),
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewServices(title: widget.title,)));
                        },
                      ),
                    ] else ...[
                      // Otras opciones si no es Jefe Departamento (opciones de utilerías para admin)
                      ListTile(
                        title: const Text('Venta'),
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
