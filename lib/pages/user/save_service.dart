import 'package:comppatt/controller/proveedorcontroller.dart';
import 'package:comppatt/modules/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:comppatt/models/proveedor.dart';
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
  final _precioCompraController = TextEditingController();
  final _precioVentaController = TextEditingController();
  String? _tipoSeleccionado;
  Proveedor? _proveedorSeleccionado;
  List<Proveedor> _proveedores = [];
  bool _camposHabilitados =
      false; // Nueva bandera para habilitar/deshabilitar campos

  @override
  void initState() {
    super.initState();
    _cargarProveedores();
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

  Future<void> _cargarProveedores() async {
    try {
      final proveedores = await ProveedorController().getProveedores();
      setState(() {
        _proveedores = proveedores;
      });
    } catch (e) {
      print("Error cargando proveedores: $e");
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return; // Detener si el formulario no es válido
    }

    Service nuevoServicio = Service(
      nombre: _nombreController.text,
      descripcion: _descripcionController.text,
      precioCompra: _tipoSeleccionado == "Producto"
          ? int.parse(_precioCompraController.text)
          : 1,
      precioVenta: int.parse(_precioVentaController.text),
      tipo: _tipoSeleccionado == "Producto"
          ? TipoServicio.producto
          : TipoServicio.servicio,
      proveedor:
          _tipoSeleccionado == "Producto" ? _proveedorSeleccionado?.id : null,
    );

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
        setState(() {
          _camposHabilitados = false; // Resetear campos
        });
      } else {
        _showDialog('Advertencia', 'No se pudo completar la operación');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _actualizarEstadoCampos(String tipo) {
    setState(() {
      _camposHabilitados = true; // Habilita los campos al seleccionar un tipo
      _tipoSeleccionado = tipo;

      if (_tipoSeleccionado == "Servicio") {
        _proveedorSeleccionado = null; // Limpia el proveedor
      }
    });
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
          title: Text(widget.title),
        ),
        drawer: SideBar(title: widget.title),
        body: _proveedores.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                          width: 400,
                          child: DropdownButtonFormField<String>(
                            value: _tipoSeleccionado,
                            onChanged: (value) {
                              if (value != null) {
                                _actualizarEstadoCampos(value);
                              }
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
                        buildTextField("Nombre", _nombreController,
                            enabled: _camposHabilitados),
                        buildTextField("Descripción", _descripcionController,
                            enabled: _camposHabilitados),
                        buildTextField("Precio Compra", _precioCompraController,
                            keyboardType: TextInputType.number,
                            enabled: _tipoSeleccionado == "Producto"),
                        buildTextField("Precio Venta", _precioVentaController,
                            keyboardType: TextInputType.number,
                            enabled: _camposHabilitados),
                        SizedBox(
                          height: 80,
                          width: 400,
                          child: DropdownButtonFormField<Proveedor>(
                            value: _proveedorSeleccionado,
                            onChanged: _tipoSeleccionado == "Servicio"
                                ? null
                                : (nuevoProveedor) {
                                    setState(() {
                                      _proveedorSeleccionado = nuevoProveedor;
                                    });
                                  },
                            items: _proveedores
                                .map((proveedor) => DropdownMenuItem(
                                      value: proveedor,
                                      child: Text(proveedor.nombre),
                                    ))
                                .toList(),
                            decoration: InputDecoration(labelText: "Proveedor"),
                            validator: (value) {
                              if (_tipoSeleccionado == "Producto" &&
                                  (value == null || value.nombre.isEmpty)) {
                                return "Por favor selecciona un proveedor";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _camposHabilitados ? _submitForm : null,
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
