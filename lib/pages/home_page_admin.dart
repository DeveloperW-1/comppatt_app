import 'package:comppatt/modules/table.dart';
import 'package:flutter/material.dart';
import '../modules/sidebar.dart';

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
