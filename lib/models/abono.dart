class Abono {
  final int id;
  final DateTime fecha;
  final int cantidad;

  Abono({
    required this.id,
    required this.fecha,
    required this.cantidad,
  });

  factory Abono.fromMap(Map<String, dynamic> map) {
    return Abono(
      id: map['ID'],
      fecha: DateTime.parse(map['Fecha']),
      cantidad: map['Cantidad'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'Fecha': fecha.toIso8601String(),
      'Cantidad': cantidad,
    };
  }
}
