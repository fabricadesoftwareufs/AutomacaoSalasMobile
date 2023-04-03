import 'package:flutter/material.dart';

Widget buttonWidget({required String text}) {
  return Row(
    children: [
      Expanded(
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(5))
            ),
          ),
          onPressed: () {},
          child: Text(text, style: TextStyle(color: Colors.black))
        ),
      ),
    ],
  );
}