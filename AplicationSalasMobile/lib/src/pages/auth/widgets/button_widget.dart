import 'package:flutter/material.dart';

Widget buttonWidget({required String text}) {
  return Row(
    children: [
      Expanded(
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(5))
            ),
          ),
          onPressed: () {},
          child: Text(text, style: const TextStyle(color: Colors.black))
        ),
      ),
    ],
  );
}