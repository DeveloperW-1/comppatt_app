import 'package:comppatt/controller/clientecontroller.dart';
import 'package:comppatt/models/cliente.dart';
import 'package:comppatt/modules/sidebar.dart';
import 'package:flutter/material.dart';

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
                    child: buildTextField('Nombre', _nombreController),
                  ),
                  Center(
                    child: buildTextField('Teléfono', _telefonoController),
                  ),
                  Center(
                    child: buildTextField('Correo', _correoController),
                  ),
                  Center(
                    child: buildTextField('RFC', _rfcController),
                  ),
                  Center(
                    child: buildTextField('CURP', _curpController,
                        enabled: widget.cliente == null),
                  ),
                  Center(
                    child: buildTextField('Domicilio', _domicilioController),
                  ),
                  Center(
                    child:
                        buildTextField('Días Crédito', _diasCreditoController),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: _submitForm,
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

  Widget buildTextField(String label, TextEditingController controller,
      {bool enabled = true}) {
    return SizedBox(
      height: 80,
      width: 400,
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(labelText: label),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingresa $label';
          }
          return null;
        },
      ),
    );
  }

  Future<void> _submitForm() async {
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
                : 'Cliente Actualizado Exitosamente');
        // _formKey.currentState!.reset();
      } else {
        _showDialog('Advertencia', 'No se pudo completar la operación');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${error.toString()}')),
      );
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
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
}
