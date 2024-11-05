// import 'package:comppatt/models/cliente.dart';
import 'package:comppatt/pages/user/home_page_user.dart';
import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'home_page_admin.dart';
// import '../config/connection.config.dart';
// import 'package:mysql1/mysql1.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Inicio de Sesion',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Usuario',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contraseña',
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // getCliente();
                  if (_usernameController.text == 'admin' &&
                      _passwordController.text == 'pass') {
                    _usernameController.clear();
                    _passwordController.clear();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePageAdmin()));
                  } else if (_usernameController.text == 'user' &&
                      _passwordController.text == 'pass') {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePageUser()));
                  } else {
                    _usernameController.clear();
                    _passwordController.clear();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Login Failed'),
                        content: Text('Invalid username or password'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.black, // Button color
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(
                  'Ingresar',
                  style: TextStyle(fontSize: 18),
                  selectionColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
