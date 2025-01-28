class Venta {
  final int? id;
  final double montoTotal;
  final int plazoMeses;
  final DateTime fechaVenta;
  final DateTime fechaCorte;
  final double tazaIntereses;
  final String? cliente;

  Venta({
    this.id,
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
      id: int.parse(map['ID']),
      montoTotal: double.parse(map['Monto_Total']),
      plazoMeses: int.parse(map['Plazo_Meses']),
      fechaVenta: DateTime.parse(map['Fecha_Venta']),
      fechaCorte: DateTime.parse(map['Fecha_Corte']),
      tazaIntereses: double.parse(map['Taza_Intereses']),
      cliente: map['Cliente'].toString(),
    );
  }

  // Serialización al mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Monto_Total': montoTotal,
      'Plazo_Meses': plazoMeses,
      'Fecha_Venta': fechaVenta.toIso8601String(),
      'Fecha_Corte': fechaCorte.toIso8601String(),
      'Taza_Intereses': tazaIntereses,
      'Cliente': cliente,
    };
  }
}
