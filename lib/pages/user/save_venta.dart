import 'dart:io';

import 'package:comppatt/controller/clientecontroller.dart';
import 'package:comppatt/controller/servicecontroller.dart';
import 'package:comppatt/controller/ventacontroller.dart';
import 'package:comppatt/models/cliente.dart';
import 'package:comppatt/models/service.dart';
import 'package:comppatt/models/venta.dart';
import 'package:comppatt/models/ventaDetalle.dart';
import 'package:comppatt/pages/user/home_page_user.dart';
import 'package:comppatt/validate/validaciones.dart';
import 'package:flutter/material.dart';
import '../../modules/sidebar.dart';
import 'package:flutter/services.dart';

class SaveVenta extends StatefulWidget {
  const SaveVenta({super.key});

  @override
  _SaveVenta createState() => _SaveVenta();
}

class _SaveVenta extends State<SaveVenta> {
  final _formKey = GlobalKey<FormState>();

  List<Cliente> clientes = [];
  List<Service> servicios = [];

  Cliente? _clienteSeleccionado;
  Service? _servicioSeleccionado;

  final TextEditingController _cantidadServicio = TextEditingController();
  final TextEditingController _precioServicio = TextEditingController();

  int? _mesesVenta;
  final List<VentaDetalle> _detalleVenta = [];

  final List<int> _mesesDisponibles = [3, 6, 9, 12, 18];
  final TextEditingController _interesPorMes = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchClientes();
    _fetchServicios();
  }

  Future<void> _fetchClientes() async {
    final _clientes = await ClienteController().getAllClient();
    setState(() {
      clientes = _clientes;
    });
  }

  Future<void> _fetchServicios() async {
    final _servicios = await ServiceController().getAllServices();
    setState(() {
      servicios = _servicios;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Color.fromRGBO(33, 33, 33, 100),
        appBar: AppBar(
          title: Text("Guardar Venta"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Regresa a la pantalla anterior
            },
          ),
        ),
        drawer: SideBar(title: 'Jefe Departamento'),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    spacing: 10,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(),
                          SizedBox(
                              width: 200,
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: () {
                                    _mostrarModalSeleccion(
                                      titulo: 'Clientes',
                                      elementos: clientes,
                                      onSeleccionado: (cliente) {
                                        setState(() {
                                          _clienteSeleccionado = cliente;
                                        });
                                      },
                                    );
                                  },
                                  child: Text(_clienteSeleccionado?.nombre ??
                                      "Seleccionar Cliente"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromRGBO(106, 66, 171, 100),
                                  ))),
                        ],
                      ),
                      if (_clienteSeleccionado != null) ...[
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: 130,
                          children: [
                            SizedBox(
                              width: 350,
                            ),
                            Row(
                              spacing: 30,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 150,
                                  child: buildTextField(
                                      "Nombre Cliente",
                                      TextEditingController(
                                          text: _clienteSeleccionado?.nombre),
                                      enabled: false),
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 150,
                                  child: buildTextField(
                                      "Telefono",
                                      TextEditingController(
                                          text: _clienteSeleccionado?.telefono),
                                      enabled: false),
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 150,
                                  child: buildTextField(
                                      "Domicilio",
                                      TextEditingController(
                                          text:
                                              _clienteSeleccionado?.domicilio),
                                      enabled: false),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 150,
                              child: buildTextField(
                                  "CURP",
                                  TextEditingController(
                                      text: _clienteSeleccionado?.curp),
                                  enabled: false),
                            ),
                            SizedBox(
                              height: 50,
                              width: 150,
                              child: buildTextField(
                                  "RFC",
                                  TextEditingController(
                                      text: _clienteSeleccionado?.rfc),
                                  enabled: false),
                            ),
                            SizedBox(
                              height: 50,
                              width: 200,
                              child: buildTextField(
                                  "Correo Electronico",
                                  TextEditingController(
                                      text: _clienteSeleccionado
                                          ?.correoElectronico),
                                  enabled: false),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                          child: Text(""),
                        ),
                        Center(
                          child: Column(
                            spacing: 10,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 10,
                                children: [
                                  SizedBox(height: 10),
                                  SizedBox(
                                      width: 300,
                                      height: 40,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            _mostrarModalSeleccion(
                                              titulo: 'Servicio',
                                              elementos: servicios,
                                              onSeleccionado: (servicio) {
                                                setState(() {
                                                  _servicioSeleccionado =
                                                      servicio;
                                                  _precioServicio.text =
                                                      _servicioSeleccionado!
                                                          .precioVenta
                                                          .toString();
                                                  _cantidadServicio.text = '1';
                                                });
                                              },
                                            );
                                          },
                                          child: Text(_servicioSeleccionado
                                                  ?.nombre ??
                                              "Seleccionar Servicio/Producto"),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color.fromRGBO(
                                                106, 66, 171, 100),
                                          ))),
                                ],
                              ),
                              if (_servicioSeleccionado != null) ...[
                                Row(
                                  spacing: 10,
                                  children: [
                                    SizedBox(
                                      width: 460,
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 200,
                                      child: buildTextField(
                                          "Nombre del Producto",
                                          TextEditingController(
                                              text: _servicioSeleccionado
                                                  ?.nombre),
                                          enabled: false),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 100,
                                      child: buildTextField(
                                          "Precio Venta", _precioServicio),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 100,
                                      child: buildTextField(
                                          "Cantidad", _cantidadServicio,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FormatoNumerosLongitudMaxima()
                                          ]),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    SizedBox(
                                        width: 150,
                                        height: 40,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              _agregarDetalle();
                                            },
                                            child: Text("Agregar"),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color.fromRGBO(
                                                  106, 66, 171, 100),
                                            ))),
                                  ],
                                ),
                                Row(
                                  spacing: 10,
                                  children: [
                                    SizedBox(
                                      width: 460,
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 460,
                                      child: buildTextField(
                                          "Descripcion del Producto/Servicio",
                                          TextEditingController(
                                              text: _servicioSeleccionado
                                                  ?.descripcion),
                                          enabled: false),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 10,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 150,
                                      child: DropdownButtonFormField<int>(
                                        value: _mesesVenta,
                                        decoration:
                                            InputDecoration(labelText: "Meses"),
                                        items: _mesesDisponibles.map((mes) {
                                          return DropdownMenuItem<int>(
                                            value: mes,
                                            child: Text("$mes meses"),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            _mesesVenta = value;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 150,
                                      child: buildTextField(
                                          "Interes por Mes (%)",
                                          _interesPorMes),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 100,
                                      child: TextFormField(
                                        controller: TextEditingController(
                                          text: _detalleVenta.isNotEmpty &&
                                                  _mesesVenta != null
                                              ? _calcularTotalConIntereses()
                                                  .toStringAsFixed(2)
                                              : '0.00',
                                        ),
                                        enabled: false,
                                        decoration: InputDecoration(
                                            labelText: "Total a Pagar"),
                                      ),
                                    ),
                                    SizedBox(
                                        width: 150,
                                        height: 40,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              _submitForm();
                                            },
                                            child: Text("Registrar Venta"),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color.fromRGBO(
                                                  106, 66, 171, 100),
                                            )))
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 50,
                                  children: [
                                    _detalleVenta.isNotEmpty
                                        ? _buildDetalleTable()
                                        : const Text(
                                            "No hay detalles agregados."),
                                  ],
                                )
                                // SizedBox(
                                //   height: 50,
                                //   width: 100,
                                //   child: TextFormField(
                                //     controller: TextEditingController(
                                //       text: _detalleVenta.isNotEmpty
                                //           ? _calcularTotalVenta()
                                //               .toStringAsFixed(2)
                                //           : '0.00',
                                //     ),
                                //     enabled: false,
                                //     decoration: InputDecoration(
                                //         labelText: "Total a Pagar"),
                                //   ),
                                // )
                              ]
                            ],
                          ),
                        )
                      ]
                    ],
                  ),
                ),
              )),
        ), // SideBar
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return; // Detener si el formulario no es válido
    }

    if (_detalleVenta.isEmpty) {
      _showDialog("Error", "Detalles Vacios");
      return;
    }
    try {
      DateTime fechaVenta = DateTime.now();
      DateTime fechaCorte = DateTime(
          fechaVenta.year, fechaVenta.month + _mesesVenta!, fechaVenta.day);

      Venta venta = Venta(
          montoTotal: _calcularTotalConIntereses(),
          plazoMeses: _mesesVenta!,
          fechaVenta: fechaVenta,
          fechaCorte: fechaCorte,
          tazaIntereses: double.parse(_interesPorMes.text),
          cliente: _clienteSeleccionado?.curp);

      await Ventacontroller().saveVenta(venta, _detalleVenta);
      _showDialog("Confirmación", "La Venta se registro correctamente");
      setState(() {
        _clienteSeleccionado = null;
        _servicioSeleccionado = null;
        _detalleVenta.clear();
        _interesPorMes.clear();
        _mesesVenta = null;
      });
    } catch (e) {
      _showDialog('Error', 'Hubo un problema al guardar los detalles: $e');
      print(e);
    }
  }

  double _calcularTotalVenta() {
    return _detalleVenta.fold(
      0.0,
      (suma, detalle) => suma + (detalle.subtotal ?? 0.0),
    );
  }

  double _calcularTotalConIntereses() {
    final totalBase = _calcularTotalVenta();
    final interes = double.tryParse(_interesPorMes.text) ?? 0.0;
    final meses = _mesesVenta ?? 1;

    // Fórmula para calcular el total con intereses
    final totalConIntereses =
        (totalBase + (((interes / 100) * totalBase) * meses));

    return totalConIntereses;
  }

  void _agregarDetalle() {
    if (_servicioSeleccionado == null || _servicioSeleccionado == null) {
      _showDialog('Error', 'Selecciona un servicio.');
      return;
    }

    final cantidaServicios = double.tryParse(_cantidadServicio.text);

    final precioVenta = _servicioSeleccionado?.precioVenta;

    final detalle = VentaDetalle(
        fechaVenta: DateTime.now(),
        idServicio: _servicioSeleccionado?.id,
        subtotal: (double.parse(_precioServicio.text) * cantidaServicios!),
        cantidadServicios: int.parse(_cantidadServicio.text));
    setState(() {
      _detalleVenta.add(detalle);
    });
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

  void _eliminarDetalle(int index) {
    setState(() {
      _detalleVenta.removeAt(index);
    });
  }

  Widget _buildDetalleTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('ID Servicio')),
        DataColumn(label: Text('Cantidad')),
        DataColumn(label: Text('Precio de Venta')),
        DataColumn(label: Text('Subtotal')),
        DataColumn(label: Text('Acciones')), // Nueva columna para acciones
      ],
      rows: _detalleVenta.asMap().entries.map((entry) {
        final index = entry.key;
        final detalle = entry.value;
        return DataRow(cells: [
          DataCell(Text(detalle.idServicio.toString())),
          DataCell(Text(detalle.cantidadServicios.toString())),
          DataCell(Text(_precioServicio.text)),
          DataCell(Text(detalle.subtotal.toString())),
          DataCell(
            // Botón para eliminar
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                _eliminarDetalle(index);
              },
            ),
          ),
        ]);
      }).toList(),
    );
  }

  void _mostrarModalSeleccion(
      {required String titulo,
      required List<dynamic> elementos,
      required void Function(dynamic) onSeleccionado}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
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
}
