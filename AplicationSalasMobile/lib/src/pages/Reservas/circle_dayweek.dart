import 'package:flutter/material.dart';

Widget CircleDayWeek({Color? cor, required String day}) {
  return Builder(
      builder: (context) {
        final circleColor = cor ?? Theme.of(context).colorScheme.primary;

        return Card(
          elevation: 5,
          shadowColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade800
              : Colors.blue.shade100,
          color: circleColor,
          child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: circleColor,
                  borderRadius: BorderRadius.circular(50)
              ),
              child: Text(
                  day,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500
                  )
              )
          ),
        );
      }
  );
}