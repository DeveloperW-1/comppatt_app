class Compra {
  final int? id;
  final double montoTotal;
  final DateTime fecha;

  Compra({required this.montoTotal, required this.fecha, this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'MontoTotal': montoTotal,
      'Fecha': fecha.toIso8601String(), // Formatear la fecha
    };
  }

  factory Compra.fromMap(Map<String, dynamic> map) {
    return Compra(
      id: map['id'] as int?,
      montoTotal: double.parse(map['MontoTotal']),
      fecha: DateTime.parse(map['Fecha']),
    );
  }
}
