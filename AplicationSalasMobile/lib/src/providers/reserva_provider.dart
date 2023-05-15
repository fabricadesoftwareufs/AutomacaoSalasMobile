import 'package:aplicationsalasmobile/src/datasources/reserva_datasource.dart';
import 'package:aplicationsalasmobile/src/models/reserva_usuario_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ReservaProvider extends ChangeNotifier {
  final Dio dio;

  ReservaProvider(this.dio);

  Future<List<ReservaUsuarioResponseModel>> reservasUsuario(String diaSemana, int idUsuario) async {
    IReservaDatasource reservasDataSource = ReservaDataSourceImpl(dio: dio);

    final List<ReservaUsuarioResponseModel> listaReservasUsuario = await reservasDataSource.getReservaUsuario(diaSemana, idUsuario);
    return listaReservasUsuario;
  }
}