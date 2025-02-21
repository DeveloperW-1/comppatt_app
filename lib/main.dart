// ignore_for_file: prefer_const_constructors
import 'package:comppatt/pages/home_page_admin.dart';
import 'package:comppatt/pages/login.dart';
import 'package:comppatt/pages/user/home_page_user.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePageUser(),
    );
  }
}
