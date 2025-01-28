class VentaDetalle {
  final int? id;
  final DateTime fechaVenta;
  final int? cantidadServicios;
  final int? idServicio;
  final int? idVenta;
  final int? idAbono;
  final double? subtotal;

  VentaDetalle({
    this.subtotal,
    this.id,
    required this.fechaVenta,
     this.cantidadServicios,
    this.idServicio,
    this.idVenta,
    this.idAbono,
  });

  factory VentaDetalle.fromMap(Map<String, dynamic> map) {
    return VentaDetalle(
      id: map['ID'],
      subtotal: map['Subtotal'],
      fechaVenta: DateTime.parse(map['Fecha_Venta']),
      cantidadServicios: map['Cantidad_Servicios'],
      idServicio: map['IDServicio'],
      idVenta: map['IDVenta'],
      idAbono: map['IDAbono'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'Subtotal': subtotal,
      'Fecha_Venta': fechaVenta.toIso8601String(),
      'Cantidad_Servicios': cantidadServicios,
      'IDServicio': idServicio,
      'IDVenta': idVenta,
      'IDAbono': idAbono,
    };
  }
}
