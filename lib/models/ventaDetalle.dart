import 'package:comppatt/models/abono.dart';
import 'package:comppatt/models/servicio.dart';
import 'package:comppatt/models/venta.dart';

class VentaDetalle {
  final int id;
  final DateTime fechaVenta;
  final int cantidadServicios;
  final Servicio idServicio;
  final Venta idVenta;
  final Abono idAbono;

  VentaDetalle({
    required this.id,
    required this.fechaVenta,
    required this.cantidadServicios,
    required this.idServicio,
    required this.idVenta,
    required this.idAbono,
  });

  factory VentaDetalle.fromMap(Map<String, dynamic> map) {
    return VentaDetalle(
      id: map['ID'],
      fechaVenta: DateTime.parse(map['Fecha_Venta']),
      cantidadServicios: map['Cantidad_Servicios'],
      idServicio: map['IDServicio'],
      idVenta: map['IDVenta'],
      idAbono: map['IDAbono'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'Fecha_Venta': fechaVenta.toIso8601String(),
      'Cantidad_Servicios': cantidadServicios,
      'IDServicio': idServicio,
      'IDVenta': idVenta,
      'IDAbono': idAbono,
    };
  }
}