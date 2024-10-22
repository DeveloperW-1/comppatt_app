import 'package:flutter/material.dart';
// import '../pages/sell.dart';
import '../pages/home_page_admin.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

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
          // ListTile(
          //   title: ElevatedButton(
          //     onPressed: () {
          //           Navigator.push(context, MaterialPageRoute(builder: (context) => Sell()));
          //     },
          //     child: Text('Ventas'),
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Color.fromRGBO(21, 21, 21, 100),
          //     ),
          //   ),
          // ),
          ListTile(
            title: Text('Utilerías'),
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
                  ListTile(
                    title: Text('Ventas'),
                    textColor: Colors.white,
                    onTap: () {
                    },
                  ),
                  ListTile(
                    title: Text('Abonos'),
                    textColor: Colors.white,
                    onTap: () {
                    },
                  ),
                  ListTile(
                    title: Text('Cliente Particular'),
                    textColor: Colors.white,
                    onTap: () {
                    },
                  ),
                  ListTile(
                    title: Text('Inventario'),
                    textColor: Colors.white,
                    onTap: () {
                    },
                  ),
                  ListTile(
                    title: Text('Agregar...'),
                    textColor: Colors.white,
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
