class Cliente {
  final int? id;
  final String nombre;
  final String telefono;
  final String correoElectronico;
  final String rfc;
  final String curp;
  final String domicilio;
  final int diasCredito;

  Cliente({
    this.id,
    required this.nombre,
    required this.telefono,
    required this.correoElectronico,
    required this.rfc,
    required this.curp,
    required this.domicilio,
    required this.diasCredito
  });

  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      id: map['id'],
      nombre: map['Nombre'] ?? 'Sin nombre',  // Maneja el caso nulo
      telefono: map['Telefono'] ?? 'Sin teléfono',
      correoElectronico: map['Correo_Electronico'] ?? 'Sin correo',
      rfc: map['RFC'] ?? 'Sin RFC',
      curp: map['CURP'] ?? 'Sin CURP',
      domicilio: map['Domicilio'] ?? 'Sin',
      diasCredito: map['Dias_Credito'] ?? 1  // Asegura que sea un entero
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Nombre': nombre,
      'Telefono': telefono,
      'Correo_Electronico': correoElectronico,
      'RFC': rfc,
      'CURP': curp,
      'Domicilio': domicilio,
      'Dias_Credito': diasCredito
    };
  }
}
