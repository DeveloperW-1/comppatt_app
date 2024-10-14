import 'package:flutter/material.dart';
import '../pages/sell.dart';
import '../pages/home_page_admin.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Color.fromRGBO(33, 33, 33, 100),
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
                  'Admin',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(142, 142, 142, 100),
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
          ListTile(
            title: ElevatedButton(
              onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageAdmin()));
              },
              child: Text('Inicio'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(21, 21, 21, 100),
              ),
            ),
          ),
          ListTile(
            title: ElevatedButton(
              onPressed: () {},
              child: Text('Reportes'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(21, 21, 21, 100),
              ),
            ),
          ),
          ListTile(
            title: ElevatedButton(
              onPressed: () {},
              child: Text('Consultas'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(21, 21, 21, 100),
              ),
            ),
          ),
          ListTile(
            title: ElevatedButton(
              onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Sell()));
              },
              child: Text('Ventas'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(21, 21, 21, 100),
              ),
            ),
          ),
          ListTile(
            title: Text('Utilerías'),
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
                  ListTile(
                    title: Text('Ventas'),
                    onTap: () {
                    },
                  ),
                  ListTile(
                    title: Text('Abonos'),
                    onTap: () {
                    },
                  ),
                  ListTile(
                    title: Text('Cliente Particular'),
                    onTap: () {
                    },
                  ),
                  ListTile(
                    title: Text('Inventario'),
                    onTap: () {
                    },
                  ),
                  ListTile(
                    title: Text('Agregar...'),
                    onTap: () {
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    ));
  }
}
