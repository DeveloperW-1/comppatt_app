import 'package:flutter/material.dart';

class HomePageAdmin extends StatelessWidget {
  const HomePageAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
        ),
        drawer: MyDrawer(), // SideBar
        body: MyTable(),
      ),
    );
  }
}

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
          // Botones de Reportes y Consultas
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
          // Opciones del Menú (Utilerías, Ventas, Abonos, etc.)
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
                      // Acción para Ventas
                    },
                  ),
                  ListTile(
                    title: Text('Abonos'),
                    onTap: () {
                      // Acción para Abonos
                    },
                  ),
                  ListTile(
                    title: Text('Cliente Particular'),
                    onTap: () {
                      // Acción para Cliente Particular
                    },
                  ),
                  ListTile(
                    title: Text('Inventario'),
                    onTap: () {
                      // Acción para Inventario
                    },
                  ),
                  ListTile(
                    title: Text('Agregar...'),
                    onTap: () {
                      // Acción para Agregar
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

class MyTable extends StatelessWidget {
  MyTable({super.key});
  final List<Map<String, dynamic>> data = [
    {
      "name": "Jerome Bell",
      "debt": 10,
      "country": "Nepal",
      "email": "jackson.graham@example.com",
      "dueDate": "30/4/2025",
      "phone": "(205) 555-0100"
    },
    {
      "name": "Cameron Williamson",
      "debt": 2,
      "country": "Netherlands",
      "email": "deanna.curtis@example.com",
      "dueDate": "30/4/2025",
      "phone": "(671) 555-0100"
    },
    // Más datos aquí
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          DataTable(
            columns: const [
              DataColumn(label: Text('Nombre')),
              DataColumn(label: Text('Adeudos')),
              DataColumn(label: Text('Dirección')),
              DataColumn(label: Text('Correo Electrónico')),
              DataColumn(label: Text('Fecha Corte')),
              DataColumn(label: Text('Num. Teléfono')),
              DataColumn(label: Text('Acciones')),
            ],
            rows: data
                .map((item) => DataRow(cells: [
                      DataCell(Text(item['name'])),
                      DataCell(Text(item['debt'].toString())),
                      DataCell(Text(item['country'])),
                      DataCell(Text(item['email'])),
                      DataCell(Text(item['dueDate'])),
                      DataCell(Text(item['phone'])),
                      DataCell(Icon(Icons.arrow_forward)),
                    ]))
                .toList(),
          ),
        ],
      ),
    );
  }
}
