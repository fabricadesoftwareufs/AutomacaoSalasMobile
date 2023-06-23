import 'package:flutter/material.dart';

TextFormField TextFormFieldWidget({required String name, required TextEditingController controller, bool isPasswordVisible = false, required ValueChanged<bool> selecionado}) {
  return TextFormField(
    controller: controller,
    keyboardType: (name.toLowerCase() == "cpf")
      ?TextInputType.number
      :TextInputType.text,
    obscureText: isPasswordVisible,
    decoration: InputDecoration(
      hintText: name,
      labelText: name,
      labelStyle: TextStyle(color: Colors.black87, fontWeight: FontWeight.w400),
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.black54),
      ),
      // enabledBorder: OutlineInputBorder(
      //   borderSide: BorderSide(width: 2, color: Color(0xff277ebe)),
      // ),
      prefixIcon: (name.toLowerCase() == "cpf")
        ?Icon(Icons.person, color: Color(0xff277ebe))
        :Icon(Icons.lock, color: Color(0xff277ebe)),
      suffixIcon: (name.toLowerCase() == "cpf")
        ?Container(width: 0)
        :IconButton(
          icon: (isPasswordVisible)
            ?Icon(Icons.visibility)
            :Icon(Icons.visibility_off),
          onPressed: () {
            selecionado(isPasswordVisible = !isPasswordVisible);
          },
        ),
    ),
  );
}