enum TipoServicio {
  servicio, // Servicios proporcionados por la empresa
  producto, // Productos adquiridos de terceros
}

class Service {
  final String descripcion; // Descripción del servicio o producto
  final String nombre; // Nombre del servicio o producto
  final TipoServicio tipo; // Define si es un servicio o producto
  final int? precioCompra; // Precio de compra, opcional para servicios
  final int precioVenta; // Precio de venta
  final int? proveedor; // ID del proveedor, solo aplica para productos

  Service({
    required this.descripcion,
    required this.nombre,
    required this.tipo,
    this.precioCompra, // Opcional para servicios
    required this.precioVenta,
    this.proveedor, // Opcional
  });

  // Método para convertir un Map a un objeto Service
  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      descripcion: map['Descripcion'] ?? '',
      nombre: map['Nombre'] ?? '',
      tipo: TipoServicio.values.firstWhere(
        (e) => e.toString().split('.').last.toLowerCase() == map['Tipo'].toLowerCase(),
        orElse: () => TipoServicio.servicio, // Valor predeterminado si no se encuentra
      ),
      precioCompra: map['PrecioCompra'] != null
          ? int.tryParse(map['PrecioCompra'].toString())
          : 0, // Opcional si es servicio
      precioVenta: int.tryParse(map['PrecioVenta'].toString()) ?? 0,
      proveedor: map['idProveedor'] != null
          ? int.tryParse(map['idProveedor'].toString())
          : null, // Opcional si no se aplica
    );
  }
  // Método para convertir un objeto Service a un Map
  Map<String, dynamic> toMap() {
    return {
      'Descripcion': descripcion,
      'Nombre': nombre,
      'Tipo': tipo.toString().split('.').last,
      'PrecioCompra': tipo == TipoServicio.producto ? precioCompra : null,
      'PrecioVenta': precioVenta,
      'idProveedor': tipo == TipoServicio.producto ? proveedor : null,
    };
  }
}
