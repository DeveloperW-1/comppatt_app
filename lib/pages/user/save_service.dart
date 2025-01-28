import 'package:comppatt/modules/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:comppatt/models/service.dart';
import 'package:comppatt/controller/servicecontroller.dart';

class AddServiceForm extends StatefulWidget {
  final Service? service;
  final String title;

  const AddServiceForm({Key? key, this.service, required this.title})
      : super(key: key);

  @override
  _AddServiceFormState createState() => _AddServiceFormState();
}

class _AddServiceFormState extends State<AddServiceForm> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  // final _precioCompraController = TextEditingController();
  final _precioVentaController = TextEditingController();
  final _ivaController = TextEditingController();
  String? _tipoSeleccionado;

  // Proveedor? _proveedorSeleccionado;
  // List<Proveedor> _proveedores = [];
  // bool _camposHabilitados = false; // Nueva bandera para habilitar/deshabilitar campos

  @override
  void initState() {
    super.initState();
    // _cargarProveedores();
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

  // Future<void> _cargarProveedores() async {
  //   try {
  //     final proveedores = await ProveedorController().getProveedores();
  //     setState(() {
  //       _proveedores = proveedores;
  //     });

  //     if (proveedores.isEmpty) {
  //       _mostrarDialogoSinProveedores();
  //     }
  //   } catch (e) {
  //     print("Error cargando proveedores: $e");
  //   }
  // }

  // void _mostrarDialogoSinProveedores() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false, // Evita cerrar el diálogo tocando fuera
  //     builder: (context) => AlertDialog(
  //       title: Text('Sin Proveedores'),
  //       content: Text(
  //           'No se encontraron proveedores en la base de datos. ¿Deseas agregar uno nuevo?'),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => AddProveedorForm(
  //                   title: widget.title,
  //                 ),
  //               ),
  //             );
  //           },
  //           child: Text('Agregar Proveedor'),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //           child: Text('Continuar'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return; // Detener si el formulario no es válido
    }

    Service nuevoServicio = Service(
        nombre: _nombreController.text,
        descripcion: _descripcionController.text,
        precioVenta: double.parse(_precioVentaController.text),
        tipo: _tipoSeleccionado == 'Servicio' ? TipoServicio.servicio : TipoServicio.producto,
        iva: double.parse(_ivaController.text));

    try {
      bool response = false;
      if (widget.service == null) {
        response = await ServiceController().saveService(nuevoServicio);
      }
      if (response) {
        _showDialog(
            'Confirmación',
            widget.service == null
                ? 'Servicio Guardado'
                : 'Servicio Actualizado');
        _formKey.currentState!.reset();
        setState(() {});
      } else {
        _showDialog('Advertencia', 'No se pudo completar la operación');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Widget buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, bool enabled = true}) {
    return SizedBox(
      height: 80,
      width: 400,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        enabled: enabled,
        decoration: InputDecoration(labelText: label),
        validator: (value) {
          if (enabled && (value == null || value.isEmpty)) {
            return 'Por favor ingresa $label';
          }
          if (enabled &&
              keyboardType == TextInputType.number &&
              int.tryParse(value!) == null) {
            return 'Por favor ingresa un número válido';
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
        appBar: AppBar(
          title: Text("Guardar Servicio"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Regresa a la pantalla anterior
            },
          ),
        ),
        drawer: SideBar(title: widget.title),
        body: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                    width: 200,
                    child: DropdownButtonFormField<String>(
                      value: _tipoSeleccionado,
                      onChanged: (value) {
                        setState(() {
                          _tipoSeleccionado = value;
                        });
                      },
                      items: ["Servicio", "Producto"]
                          .map((tipo) => DropdownMenuItem(
                                value: tipo,
                                child: Text(tipo),
                              ))
                          .toList(),
                      decoration: InputDecoration(labelText: "Tipo"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor selecciona un tipo";
                        }
                        return null;
                      },
                    ),
                  ),
                  buildTextField("Nombre", _nombreController),
                  buildTextField("Descripción", _descripcionController),
                  buildTextField("Precio Venta", _precioVentaController,
                      keyboardType: TextInputType.number),
                  buildTextField("IVA", _ivaController),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(widget.service == null
                        ? 'Agregar Servicio'
                        : 'Actualizar Servicio'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
