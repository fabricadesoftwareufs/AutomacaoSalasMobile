import 'package:flutter/material.dart';

Widget CircleDayWeek({Color? cor = const Color(0xff3d31dd), required String day}){
  return Card(
    elevation: 5,
    // shadowColor: Colors.blue.shade100,
    color: cor,
    child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        // margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: cor,
            borderRadius: BorderRadius.circular(50)
        ),
        child: Text(day, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500))
    ),
  );
}