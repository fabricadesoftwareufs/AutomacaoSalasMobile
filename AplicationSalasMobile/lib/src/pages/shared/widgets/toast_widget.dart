import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showCustomToast({required FToast fToast, required String titulo, required Color cor}) {
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    margin: const EdgeInsets.only(bottom: 30),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: cor,
    ),
    child: Text(
      titulo, textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white),
    ),
  );

  fToast.showToast(
    child: toast,
    toastDuration: const Duration(seconds: 3),
  );
}