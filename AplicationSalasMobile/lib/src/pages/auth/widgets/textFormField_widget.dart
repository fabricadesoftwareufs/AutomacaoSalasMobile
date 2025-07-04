import 'package:flutter/material.dart';

Widget TextFormFieldWidget({
  required String name,
  required TextEditingController controller,
  bool isPasswordVisible = false,
  required ValueChanged<bool> selecionado
}) {
  return Builder(
      builder: (context) {
        return TextFormField(
          controller: controller,
          keyboardType: (name.toLowerCase() == "cpf")
              ? TextInputType.number
              : TextInputType.text,
          obscureText: isPasswordVisible,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          decoration: InputDecoration(
            hintText: name,
            labelText: name,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
            labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8), fontWeight: FontWeight.w400),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary),
            ),
            prefixIcon: (name.toLowerCase() == "cpf")
                ? Icon(Icons.person, color: Theme.of(context).colorScheme.primary)
                : Icon(Icons.lock, color: Theme.of(context).colorScheme.primary),
            suffixIcon: (name.toLowerCase() == "cpf")
                ? null
                : IconButton(
              icon: Icon(
                (isPasswordVisible) ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
              onPressed: () {
                selecionado(!isPasswordVisible);
              },
            ),
          ),
        );
      }
  );
}