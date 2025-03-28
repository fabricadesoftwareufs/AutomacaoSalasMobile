import 'package:empty_widget_pro/empty_widget_pro.dart';
import 'package:flutter/material.dart';

Widget Empty_Widget({required String titulo, required String descricao}){
  return EmptyWidget(
    packageImage: PackageImage.Image_3,
    title: titulo,
    subTitle: descricao,
    titleTextStyle: const TextStyle(
      fontSize: 17,
      color: Color(0xff9da9c7),
      fontWeight: FontWeight.w500,
    ),
    subtitleTextStyle: const TextStyle(
      fontSize: 12,
      color: Color(0xffabb8d6),
    ),
  );
}