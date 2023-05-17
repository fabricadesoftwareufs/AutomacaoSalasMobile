import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';

Widget Empty_Widget({required String titulo, required String descricao}){
  return EmptyWidget(
    packageImage: PackageImage.Image_3,
    title: titulo,
    subTitle: descricao,
    titleTextStyle: const TextStyle(
      fontSize: 20,
      color: Color(0xff9da9c7),
      fontWeight: FontWeight.w500,
    ),
    subtitleTextStyle: const TextStyle(
      fontSize: 14,
      color: Color(0xffabb8d6),
    ),
  );
}