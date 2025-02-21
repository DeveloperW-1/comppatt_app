import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


  Widget buildTextField(
    String label,
    TextEditingController controller, {
    bool enabled = true,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters, // Agregamos el parámetro
  }) {
    return SizedBox(
      height: 80,
      width: 400,
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters, // Aplicamos los formatters
        decoration: InputDecoration(labelText: label),
        validator: validator,
      ),
    );
  }