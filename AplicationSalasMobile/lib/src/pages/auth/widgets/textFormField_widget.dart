import 'package:flutter/material.dart';

TextFormField TextFormFieldWidget({required String name, required TextEditingController controller}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      hintText: name,
      labelText: name
    ),
  );
}