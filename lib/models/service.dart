enum TipoServicio {
  servicio, // Servicios proporcionados por la empresa
  producto, // Productos adquiridos de terceros
}

class Service {
  final int? id;
  final String descripcion; // Descripción del servicio o producto
  final String nombre; // Nombre del servicio o producto
  final TipoServicio tipo; // Define si es un servicio o producto
  final double precioVenta; // Precio de venta
  final double iva; // ID del proveedor, solo aplica para productos

  Service({
    this.id,
    required this.descripcion,
    required this.nombre,
    required this.tipo,
    required this.precioVenta,
    required this.iva,
  });

  // Método para convertir un Map a un objeto Service
  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      id: map['id'],
      descripcion: map['Descripcion'] ?? ' ',
      nombre: map['Nombre'] ?? ' ',
      tipo: TipoServicio.values.firstWhere(
        (e) => e.toString().split('.').last.toLowerCase() == map['Tipo'].toLowerCase(),
        orElse: () => TipoServicio.servicio, // Valor predeterminado si no se encuentra
      ),
      precioVenta: double.parse(map['PrecioVenta'].toString()) ?? 0.0,
      iva: double.parse(map['IVA'])
    );
  }
  // Método para convertir un objeto Service a un Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Descripcion': descripcion,
      'Nombre': nombre,
      'Tipo': tipo.toString().split('.').last,
      'PrecioVenta': precioVenta,
      'IVA' : iva
    };
  }
}
