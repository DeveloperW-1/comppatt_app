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
      id: map['id'] != null ? int.parse(map['id'].toString()) : null,
      montoTotal: map['Monto_Total'] != null ? double.parse(map['Monto_Total'].toString()) : 0.0,
      plazoMeses: map['Plazo_Meses'] != null ? int.parse(map['Plazo_Meses'].toString()) : 0,
      fechaVenta: map['Fecha_Venta'] != null ? DateTime.parse(map['Fecha_Venta']) : DateTime.now(),
      fechaCorte: map['Fecha_Corte'] != null ? DateTime.parse(map['Fecha_Corte']) : DateTime.now(),
      tazaIntereses: map['Taza_Intereses'] != null ? double.parse(map['Taza_Intereses'].toString()) : 0.0,
      cliente: map['Cliente'] != null ? map['Cliente'].toString() : null,
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