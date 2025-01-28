class DetalleCompra {
  final int? id; // ID autoincremental en la base de datos
  final int? compraId; // ID de la compra a la que pertenece este detalle
  final int? servicioId; // ID del servicio relacionado
  final int? proveedorId; // ID del proveedor relacionado
  final int cantidad; // Cantidad del producto o servicio
  final double precioUnitario; // Precio por unidad
  final double iva; // IVA aplicado
  final double subtotal; // Subtotal calculado (cantidad * precioUnitario + IVA)

  DetalleCompra({
    this.id,
    this.compraId,
     this.servicioId,
     this.proveedorId,
    required this.cantidad,
    required this.precioUnitario,
    required this.iva,
    required this.subtotal,
  });

  /// Convierte la instancia de DetalleCompra a un mapa (para la BD)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idCompra': compraId,
      'idServicio': servicioId,
      'idProveedor': proveedorId,
      'Cantidad': cantidad,
      'PrecioUnitario': precioUnitario,
      'IVA': iva,
      'Subtotal': subtotal,
    };
  }

  /// Crea una instancia de DetalleCompra a partir de un mapa (desde la BD)
  factory DetalleCompra.fromMap(Map<String, dynamic> map) {
    return DetalleCompra(
      id: map['id'] as int?,
      compraId: map['idCompra'] as int,
      servicioId: map['idServicio'] as int,
      proveedorId: map['idProveedor'] as int,
      cantidad: map['Cantidad'] as int,
      precioUnitario: double.parse(map['PrecioUnitario']),
      iva: double.parse(map['IVA']),
      subtotal: double.parse(map['Importe']),
    );
  }
}
