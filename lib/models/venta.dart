class Venta {
  final int id;
  final String montoTotal;
  final int plazoMeses;
  final DateTime fechaVenta;
  final DateTime fechaCorte;
  final double tazaIntereses;
  final String cliente;

  Venta({
    required this.id,
    required this.montoTotal,
    required this.plazoMeses,
    required this.fechaVenta,
    required this.fechaCorte,
    required this.tazaIntereses,
    required this.cliente,
  });

  // Deserialización desde el mapa
  factory Venta.fromMap(Map<String, dynamic> map) {
    return Venta(
      id: map['ID'],
      montoTotal: map['Monto_Total'].toString(),
      plazoMeses: map['Plazo_Meses'],
      fechaVenta: DateTime.parse(map['Fecha_Venta']),
      fechaCorte: DateTime.parse(map['Fecha_Corte']),
      tazaIntereses: map['Taza_Intereses'],
      cliente: map['Cliente'],
    );
  }

  // Serialización al mapa
  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'Monto_Total': montoTotal.toString(),
      'Plazo_Meses': plazoMeses,
      'Fecha_Venta': fechaVenta.toIso8601String(),
      'Fecha_Corte': fechaCorte.toIso8601String(),
      'Taza_Intereses': tazaIntereses,
      'Cliente': cliente,
    };
  }
}
