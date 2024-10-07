class Cliente {
  final String nombre;
  final String telefono;
  final String correoElectronico;
  final String rfc;
  final String curp;
  final String domicilio;
  final int diasCredito;

  Cliente({
    required this.nombre,
    required this.telefono,
    required this.correoElectronico,
    required this.rfc,
    required this.curp,
    required this.domicilio,
    required this.diasCredito,
  });

  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      nombre: map['Nombre'],
      telefono: map['Telefono'],
      correoElectronico: map['Correo_Electronico'],
      rfc: map['RFC'],
      curp: map['CURP'],
      domicilio: map['Domicilio'],
      diasCredito: map['Dias_Credito'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Nombre': nombre,
      'Telefono': telefono,
      'Correo_Electronico': correoElectronico,
      'RFC': rfc,
      'CURP': curp,
      'Domicilio': domicilio,
      'Dias_Credito': diasCredito,
    };
  }
}
