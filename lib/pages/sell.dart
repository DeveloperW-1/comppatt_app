import 'package:flutter/material.dart';
import '../modules/sidebar.dart';

class Sell extends StatelessWidget {
  const Sell({super.key});
  
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
        drawer: SideBar() // SideBar
      ),
    );
  }
}