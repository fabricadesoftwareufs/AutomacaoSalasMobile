import 'package:flutter/material.dart';

Widget buttonWidget({required String text}) {
  return Builder(
      builder: (context) {
        return Row(
          children: [
            Expanded(
              child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Theme.of(context).colorScheme.outline),
                        borderRadius: const BorderRadius.all(Radius.circular(5))
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                      text,
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface)
                  )
              ),
            ),
          ],
        );
      }
  );
}