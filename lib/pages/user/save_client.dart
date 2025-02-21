import 'package:comppatt/controller/clientecontroller.dart';
import 'package:comppatt/models/cliente.dart';
import 'package:comppatt/modules/sidebar.dart';
import 'package:comppatt/pages/user/home_page_user.dart';
import 'package:flutter/material.dart';
import 'package:comppatt/validate/validaciones.dart';
import 'package:flutter/services.dart';

class AddClientForm extends StatefulWidget {
  final Cliente? cliente; // Parámetro opcional para editar
  final String title;
  const AddClientForm({super.key, this.cliente, required this.title});

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
  void initState() {
    super.initState();
    if (widget.cliente != null) {
      _nombreController.text = widget.cliente!.nombre;
      _telefonoController.text = widget.cliente!.telefono;
      _correoController.text = widget.cliente!.correoElectronico;
      _rfcController.text = widget.cliente!.rfc;
      _curpController.text = widget.cliente!.curp;
      _domicilioController.text = widget.cliente!.domicilio;
      _diasCreditoController.text = widget.cliente!.diasCredito.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Color.fromRGBO(33, 33, 33, 100),
        appBar: AppBar(
          title: Text("Guardar Cliente"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Regresa a la pantalla anterior
            },
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: buildTextField(
                      'Nombre',
                      _nombreController,
                      inputFormatters: [FormatoLetrasEspacios()],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa Nombre';
                        } else if (RegExp(r'[0-9]').hasMatch(value)) {
                          return 'El nombre no debe contener números';
                        }
                        return null;
                      },
                    ),
                  ),
                  Center(
                    child: buildTextField(
                      'Teléfono',
                      _telefonoController,
                      inputFormatters: [FormatoNumerosLongitudMaxima()],
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa Teléfono';
                        } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'El teléfono debe contener solo números';
                        }
                        return null;
                      },
                    ),
                  ),
                  Center(
                    child: buildTextField(
                      'Correo',
                      _correoController,
                      inputFormatters: [CorreoTextFormatter()],
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Center(
                    child: buildTextField(
                      'RFC',
                      _rfcController,
                      inputFormatters: [RFCTextFormatter()],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa RFC';
                        } else if (value.length != 13) {
                          return 'El RFC debe tener 13 caracteres';
                        }
                        return null;
                      },
                    ),
                  ),
                  Center(
                    child: buildTextField(
                      'CURP',
                      _curpController,
                      inputFormatters: [CURPTextFormatter()],
                      enabled: widget.cliente == null,
                    ),
                  ),
                  Center(
                    child: buildTextField(
                      'Domicilio',
                      _domicilioController,
                      inputFormatters: [AddressTextFormatter()],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa Domicilio';
                        }
                        return null;
                      },
                    ),
                  ),
                  Center(
                    child: buildTextField(
                      'Días Crédito',
                      _diasCreditoController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [DaysCreditTextFormatter()],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa Días Crédito';
                        } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Los días de crédito deben ser solo números';
                        }
                        return null;
                      },
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _submitForm(context),
                      child: Text(widget.cliente == null
                          ? 'Agregar Cliente'
                          : 'Actualizar Cliente'),
                    ),
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

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    bool enabled = true,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters, // Agregamos el parámetro
  }) {
    return SizedBox(
      height: 80,
      width: 400,
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters, // Aplicamos los formatters
        decoration: InputDecoration(labelText: label),
        validator: validator,
      ),
    );
  }

  Future<void> _submitForm(context) async {
    if (!_formKey.currentState!.validate()) {
      return; // Detener si el formulario no es válido
    }

    Cliente clientData = Cliente(
      nombre: _nombreController.text,
      telefono: _telefonoController.text,
      correoElectronico: _correoController.text,
      rfc: _rfcController.text,
      curp: _curpController.text,
      domicilio: _domicilioController.text,
      diasCredito: int.parse(_diasCreditoController.text),
    );

    try {
      bool response;
      if (widget.cliente != null) {
        // Actualizar cliente existente
        response = await ClienteController().updateCliente(clientData);
      } else {
        // Agregar nuevo cliente
        response = await ClienteController().saveCliente(clientData);
      }

      if (response) {
        _showDialog(
            'Confirmación',
            widget.cliente == null
                ? 'Cliente Guardado Exitosamente'
                : 'Cliente Actualizado Exitosamente', () {
          Navigator.pop(context,
              true); // Cerrar el diálogo y regresar a la página anterior
        });
      } else {
        _showDialog('Error', 'No se pudo guardar el cliente');
      }
    } catch (e) {
      _showDialog('Error', 'Ocurrió un error: $e');
    }
  }

  void _showDialog(String title, String message, [VoidCallback? onConfirm]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                if (title == 'Confirmación') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePageUser()));
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
