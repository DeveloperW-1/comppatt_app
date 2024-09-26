import 'package:flutter/material.dart';

class HomePageAdmin extends StatelessWidget {
  const HomePageAdmin({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
      ),
      body: Center(
        child: Text(
          'Welcome Admin',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
