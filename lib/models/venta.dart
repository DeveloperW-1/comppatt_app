import 'package:comppatt/models/cliente.dart';

class Venta {
  final int id;
  final double montoTotal;
  final int plazoMeses;
  final DateTime fechaVenta;
  final DateTime fechaCorte;
  final double tazaIntereses;
  final Cliente cliente;

  Venta({
    required this.id,
    required this.montoTotal,
    required this.plazoMeses,
    required this.fechaVenta,
    required this.fechaCorte,
    required this.tazaIntereses,
    required this.cliente,
  });

  factory Venta.fromMap(Map<String, dynamic> map) {
    return Venta(
      id: map['ID'],
      montoTotal: map['Monto_Total'],
      plazoMeses: map['Plazo_Meses'],
      fechaVenta: DateTime.parse(map['Fecha_Venta']),
      fechaCorte: DateTime.parse(map['Fecha_Corte']),
      tazaIntereses: map['Taza_Intereses'],
      cliente: map['Cliente'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'Monto_Total': montoTotal,
      'Plazo_Meses': plazoMeses,
      'Fecha_Venta': fechaVenta.toIso8601String(),
      'Fecha_Corte': fechaCorte.toIso8601String(),
      'Taza_Intereses': tazaIntereses,
      'Cliente': cliente,
    };
  }
}
