class Proveedor {
  final String nombre;
  final String contacto; // Puede ser teléfono o correo electrónico
  final String direccion;
  final int? id;

  Proveedor({
    this.id,
    required this.nombre,
    required this.contacto,
    required this.direccion,
  });


  // Método para convertir de Map a Proveedor
  factory Proveedor.fromMap(Map<String, dynamic> map) {
    return Proveedor(
      id: map['id'],
      nombre: map['Nombre'],
      contacto: map['Contacto'],
      direccion: map['Direccion'],
    );
  }

  // Método para convertir de Proveedor a Map
  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'nombre': nombre,
      'contacto': contacto,
      'direccion': direccion,
    };
  }
}