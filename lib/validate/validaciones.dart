import 'package:flutter/services.dart';

class FormatoLetrasEspacios extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Permite solo letras (mayúsculas y minúsculas) y espacios
    String filteredText =
        newValue.text.replaceAll(RegExp(r'[^a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]'), '');

    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}

class FormatoNumerosLongitudMaximaIVA extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String filteredText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (filteredText.length > 3) {
      filteredText = filteredText.substring(0, 3);
    }
    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}

// Solo números, máximo 10 dígitos (para teléfono)
class FormatoNumerosLongitudMaxima extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String filteredText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (filteredText.length > 10) {
      filteredText = filteredText.substring(0, 10);
    }
    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}

// RFC (13 caracteres, solo mayúsculas y números)
class RFCTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String filteredText = newValue.text.replaceAll(RegExp(r'[^A-Z0-9]'), '');
    if (filteredText.length > 13) {
      filteredText = filteredText.substring(0, 13);
    }
    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}

class IVAFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String filteredText = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');

    // Limitar el valor máximo a 16
    double value = double.tryParse(filteredText) ?? 0.0;
    if (value > 16) value = 16.0; 

    // Asegurarse de que solo haya un punto decimal
    // if (filteredText.contains('.')) {
    //   List<String> parts = filteredText.split('.');
    //   if (parts.length > 2) {
    //     filteredText = parts[0] + '.' + parts[1];
    //   }  
    // }

    return TextEditingValue(
      text: value.toString(),
      selection: TextSelection.collapsed(offset: filteredText.toString().length),
    );
  }
}

// CURP (18 caracteres, solo mayúsculas y números)
class CURPTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String filteredText = newValue.text.replaceAll(RegExp(r'[^A-Z0-9]'), '');
    if (filteredText.length > 18) {
      filteredText = filteredText.substring(0, 18);
    }
    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}

// Solo números y máximo 365 días (para días de crédito)
class DaysCreditTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String filteredText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    int value = int.tryParse(filteredText) ?? 0;
    if (value > 365) value = 365;
    return TextEditingValue(
      text: value.toString(),
      selection: TextSelection.collapsed(offset: value.toString().length),
    );
  }
}

class CorreoTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String filteredText = newValue.text.replaceAll(RegExp(r'[^\w\s.@]'), '');
    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}

// Filtrar caracteres especiales en domicilio
class AddressTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String filteredText = newValue.text.replaceAll(RegExp(r'[^\w\s,#]'), '');

    if (filteredText.length > 50) {
      filteredText = filteredText.substring(0, 50);
    }

    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}
