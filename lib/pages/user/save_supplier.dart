import 'package:comppatt/controller/proveedorcontroller.dart';
import 'package:comppatt/models/proveedor.dart';
import 'package:comppatt/modules/sidebar.dart';
import 'package:flutter/material.dart';

class AddProveedorForm extends StatefulWidget {
  final Proveedor? proveedor; // Proveedor existente (para editar)
  final String title;

  const AddProveedorForm({super.key, this.proveedor, required this.title});

  @override
  _AddProveedorFormState createState() => _AddProveedorFormState();
}

class _AddProveedorFormState extends State<AddProveedorForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _contactoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.proveedor != null) {
      // Si es edición, inicializamos los controladores con los datos del proveedor
      _nombreController.text = widget.proveedor!.nombre;
      _contactoController.text = widget.proveedor!.contacto;
      _direccionController.text = widget.proveedor!.direccion;
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _contactoController.dispose();
    _direccionController.dispose();
    super.dispose();
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

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return; // Detener si el formulario no es válido
    }

    // Crear o actualizar proveedor
    Proveedor proveedor = Proveedor(
      nombre: _nombreController.text,
      contacto: _contactoController.text,
      direccion: _direccionController.text,
    );

    bool response;
    if (widget.proveedor == null) {
      response = await ProveedorController().saveProveedor(proveedor);
    } else {
      response = await ProveedorController().saveProveedor(proveedor);
    }

    if (response) {
      _showDialog(
          'Confirmación',
          widget.proveedor == null
              ? 'Proveedor Guardado Exitosamente'
              : 'Proveedor Actualizado Exitosamente');
      // _formKey.currentState!.reset();
    } else {
      _showDialog('Advertencia', 'No se pudo completar la operación');
    }
  }

  Widget buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return SizedBox(
      height: 80,
      width: 400,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingresa $label';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Color.fromRGBO(33, 33, 33, 100),
        drawer: SideBar(title: widget.title),
        appBar: AppBar(
          title: Text("Guardar Proveedor"),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(),
                buildTextField("Nombre del Proveedor", _nombreController),
                buildTextField(
                    "Contacto (Teléfono o Correo)", _contactoController),
                buildTextField("Dirección", _direccionController),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(widget.proveedor == null
                      ? 'Agregar Proveedor'
                      : 'Actualizar Proveedor'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
