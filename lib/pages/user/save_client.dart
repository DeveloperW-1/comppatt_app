import 'package:comppatt/modules/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:comppatt/controller/clientecontroller.dart';
import 'package:comppatt/models/cliente.dart';

class AddClientForm extends StatefulWidget {
  @override
  _AddClientFormState createState() => _AddClientFormState();
}

class _AddClientFormState extends State<AddClientForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _rfcController = TextEditingController();
  final TextEditingController _curpController = TextEditingController();
  final TextEditingController _domicilioController = TextEditingController();
  final TextEditingController _diasCreditoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 80,
                      width: 400,
                      child: TextFormField(
                        controller: _nombreController,
                        decoration: InputDecoration(labelText: 'Nombre'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa un nombre';
                          }
                          return value;
                        },
                      )),
                  SizedBox(
                      height: 80,
                      width: 400,
                      child: TextFormField(
                        controller: _telefonoController,
                        decoration: InputDecoration(labelText: 'Telefono'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa un telefono';
                          }
                          return value;
                        },
                      )),
                  SizedBox(
                      height: 80,
                      width: 400,
                      child: TextFormField(
                        controller: _correoController,
                        decoration: InputDecoration(labelText: 'Correo'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa correo';
                          }
                          return value;
                        },
                      )),
                  SizedBox(
                      height: 80,
                      width: 400,
                      child: TextFormField(
                        controller: _rfcController,
                        decoration: InputDecoration(labelText: 'RFC'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa RFC';
                          }
                          return null;
                        },
                      )),
                  SizedBox(
                      height: 80,
                      width: 400,
                      child: TextFormField(
                        controller: _curpController,
                        decoration: InputDecoration(labelText: 'CURP'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa un CURP';
                          }
                          return null;
                        },
                      )),
                  Center(
                    child: SizedBox(
                        height: 80,
                        width: 400,
                        child: TextFormField(
                          controller: _domicilioController,
                          decoration: InputDecoration(labelText: 'Domicilio'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa un Domicilio';
                            }
                            return null;
                          },
                        )),
                  ),
                  Center(
                    child: SizedBox(
                        height: 80,
                        width: 400,
                        child: TextFormField(
                          controller: _diasCreditoController,
                          decoration:
                              InputDecoration(labelText: 'Dias Credito'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa los Dias Credito';
                            }
                            return null;
                          },
                        )),
                  ),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Agregar Cliente'),
                  )
                ],
              ),
            ),
          ),
        ),
        drawer: SideBar(
          title: 'Jefe Departamento',
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    // Crear el objeto Cliente
    Cliente newClient = Cliente(
      nombre: _nombreController.value.text,
      telefono: _telefonoController.value.text,
      correoElectronico: _correoController.value.text,
      rfc: _rfcController.value.text,
      curp: _curpController.value.text,
      domicilio: _domicilioController.value.text,
      diasCredito: int.parse(_diasCreditoController.value.text),
    );

    try {
      // print("Guardando cliente...");
      if (await ClienteController().saveCliente(newClient)) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Confirmacion'),
            content: Text('Cliente Guardado Exitosamente'),
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
        _formKey.currentState!.reset();
      }else
      {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Advertencia'),
            content: Text('El Cliente no se pudo Guardar'),
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
      // print("Cliente guardado exitosamente.");
      // Mostrar mensaje de éxito y limpiar el formulario
    } catch (error) {
      // Mostrar mensaje de error
      print("Error al guardar el cliente: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al guardar el cliente: ${error.toString()}'),
        ),
      );
    }
  }
}
