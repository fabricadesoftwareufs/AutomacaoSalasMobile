import 'package:aplicationsalasmobile/src/datasources/sala_datasource.dart';
import 'package:aplicationsalasmobile/src/models/salas_usuario_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class SalaProvider extends ChangeNotifier {
  final Dio dio;

  SalaProvider(this.dio);

  Future<List<SalasUsuarioResponseModel>> salasUsuario(int idUsuario) async {
    ISalaDatasource salaDataSource = SalaDataSourceImpl(dio: dio);

    final List<SalasUsuarioResponseModel> listaSalasUsuario = await salaDataSource.salasUsuario(idUsuario);
    return listaSalasUsuario;
  }
}
