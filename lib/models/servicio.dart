class Servicio {
  final int id;
  final String descripcion;
  final int precio;
  final String nombre;
  final String tipo;

  Servicio({
    required this.id,
    required this.descripcion,
    required this.precio,
    required this.nombre,
    required this.tipo,
  });

  factory Servicio.fromMap(Map<String, dynamic> map) {
    return Servicio(
      id: map['ID'],
      descripcion: map['Descripcion'],
      precio: map['Precio'],
      nombre: map['Nombre'],
      tipo: map['Tipo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'Descripcion': descripcion,
      'Precio': precio,
      'Nombre': nombre,
      'Tipo': tipo,
    };
  }
}
