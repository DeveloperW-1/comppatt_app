import 'package:comppatt/controller/compracontroller.dart';
import 'package:comppatt/models/compraDetalle.dart';
import 'package:comppatt/pages/user/home_page_user.dart';
import 'package:comppatt/validate/validaciones.dart';
import 'package:flutter/material.dart';
import 'package:comppatt/controller/proveedorcontroller.dart';
import 'package:comppatt/controller/servicecontroller.dart';
import 'package:comppatt/models/compra.dart';
import 'package:comppatt/models/proveedor.dart';
import 'package:comppatt/models/service.dart';
import 'package:comppatt/modules/sidebar.dart';
import 'package:comppatt/validate/components.dart';

class AddCompraForm extends StatefulWidget {
  final Compra? compra;
  final String title;

  const AddCompraForm({super.key, this.compra, required this.title});

  @override
  _AddCompraFormState createState() => _AddCompraFormState();
}

class _AddCompraFormState extends State<AddCompraForm> {
  final _formKey = GlobalKey<FormState>();
  List<Service> _productos = [];
  List<Proveedor> _proveedores = [];
  final List<DetalleCompra> _detalleCompra =
      []; // Donde se guarda en tiempo de memoria, los detalles

  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _precioUnitarioController =
      TextEditingController();
  final TextEditingController _ivaController = TextEditingController();

  Proveedor? _proveedorSeleccionado;
  Service? _productoSeleccionado;

  @override
  void initState() {
    super.initState();
    _fetchProveedores();
    _fetchServicios();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(33, 33, 33, 100),
        drawer: SideBar(title: widget.title),
        appBar: AppBar(
          title: const Text("Registrar Compra"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Center(),
                  SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _mostrarModalSeleccion(
                            titulo: "Selecciona un proveedor",
                            elementos: _proveedores,
                            onSeleccionado: (proveedor) {
                              setState(() {
                                _proveedorSeleccionado = proveedor;
                              });
                            },
                          );
                        },
                        child: Text(_proveedorSeleccionado?.nombre ??
                            "Seleccionar Proveedor"),
                      )),
                  SizedBox(height: 20),
                  SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _mostrarModalSeleccion(
                            titulo: "Selecciona un servicio",
                            elementos: _productos,
                            onSeleccionado: (servicio) {
                              setState(() {
                                _productoSeleccionado = servicio;
                              });
                            },
                          );
                        },
                        child: Text(_productoSeleccionado?.nombre ??
                            "Seleccionar Servicio"),
                      )),
                  SizedBox(height: 20),
                  buildTextField("Cantidad", _cantidadController,
                      inputFormatters: [FormatoNumerosLongitudMaxima()],
                      keyboardType: TextInputType.number),
                  buildTextField("Precio Unitario", _precioUnitarioController,
                      inputFormatters: [FormatoNumerosLongitudMaxima()],
                      keyboardType: TextInputType.number),
                  buildTextField("IVA", _ivaController,
                      inputFormatters: [IVAFormatter()],
                      keyboardType: TextInputType.number),
                  SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _agregarDetalle,
                        child: const Text("Agregar Detalle"),
                      )),
                  const SizedBox(height: 20),
                  _detalleCompra.isNotEmpty
                      ? _buildDetalleTable()
                      : const Text("No hay detalles agregados."),
                  _detalleCompra.isNotEmpty
                      ? SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _guardarDetallesEnBD,
                            child: const Text("Guardar Detalles"),
                          ))
                      : const Text(""),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _fetchProveedores() async {
    final proveedores = await ProveedorController().getProveedores();
    setState(() {
      _proveedores = proveedores;
    });
  }

  Future<void> _fetchServicios() async {
    final productos = await ServiceController().getAllProducts();
    setState(() {
      _productos = productos;
    });
  }

  void _mostrarModalSeleccion(
      {required String titulo,
      required List<dynamic> elementos,
      required void Function(dynamic) onSeleccionado}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        if (elementos.isEmpty) {
          return const Center(child: Text("No hay elementos disponibles"));
        }
                return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(titulo, style: const TextStyle(fontSize: 18)),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: elementos.length,
                itemBuilder: (context, index) {
                  final elemento = elementos[index];
                  return ListTile(
                    title: Text(elemento.nombre),
                    onTap: () {
                      onSeleccionado(elemento);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _guardarDetallesEnBD() async {
    if (_detalleCompra.isEmpty) {
      _showDialog('Error', 'No hay detalles para guardar.');
      return;
    }

    try {
      final total = _detalleCompra.fold(
        0.0,
        (sum, detalle) => sum + detalle.subtotal,
      );
      final compra = Compra(
        montoTotal: total,
        fecha: DateTime.now(),
      );
      await CompraController().saveCompraWithDetails(compra, _detalleCompra);
      _showDialog("Confirmación", "La Compra se registro correctamente");
      setState(() {
        _detalleCompra.clear();
        _proveedorSeleccionado = null;
        _productoSeleccionado = null;
        _cantidadController.clear();
        _precioUnitarioController.clear();
        _ivaController.clear();
      });
    } catch (error) {
      _showDialog('Error', 'Hubo un problema al guardar los detalles: $error');
      print(error);
    }
  }

  void _agregarDetalle() {
    if (_proveedorSeleccionado == null || _productoSeleccionado == null) {
      _showDialog('Error', 'Selecciona un proveedor y un servicio.');
      return;
    }

    final cantidad = int.tryParse(_cantidadController.text);
    final precioUnitario = double.tryParse(_precioUnitarioController.text);
    final iva = double.tryParse(_ivaController.text);

    if (cantidad == null || precioUnitario == null || iva == null) {
      _showDialog('Error', 'Todos los campos deben tener valores válidos.');
      return;
    }

    final detalle = DetalleCompra(
      servicioId: _productoSeleccionado!.id,
      proveedorId: _proveedorSeleccionado!.id,
      cantidad: cantidad,
      precioUnitario: precioUnitario,
      iva: iva,
      subtotal:
          (cantidad * precioUnitario) + (iva * (cantidad * precioUnitario)),
    );

    // final detalle = detalleCom{
    //   'proveedor': _proveedorSeleccionado!.nombre,
    //   'servicio': _productoSeleccionado!.nombre,
    //   'cantidad': cantidad,
    //   'precioUnitario': precioUnitario,
    //   'iva': iva,
    //   'subtotal':
    //       (cantidad * precioUnitario) + (iva * (cantidad * precioUnitario)),
    // };

    setState(() {
      _detalleCompra.add(detalle);
      _cantidadController.clear();
      _precioUnitarioController.clear();
      _ivaController.clear();
    });
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
              if (title == 'Confirmación') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePageUser()));
              } else {
                Navigator.of(context).pop();
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetalleTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Proveedor')),
        DataColumn(label: Text('Servicio')),
        DataColumn(label: Text('Cantidad')),
        DataColumn(label: Text('Precio Unitario')),
        DataColumn(label: Text('IVA')),
        DataColumn(label: Text('Subtotal')),
      ],
      rows: _detalleCompra.map((detalle) {
        final proveedor =
            _proveedores.firstWhere((p) => p.id == detalle.proveedorId).nombre;
        final servicio =
            _productos.firstWhere((s) => s.id == detalle.servicioId).nombre;
        return DataRow(cells: [
          DataCell(Text(proveedor)),
          DataCell(Text(servicio)),
          DataCell(Text(detalle.cantidad.toString())),
          DataCell(Text(detalle.precioUnitario.toString())),
          DataCell(Text(detalle.iva.toString())),
          DataCell(Text(detalle.subtotal.toString())),
        ]);
      }).toList(),
    );
  }
}
