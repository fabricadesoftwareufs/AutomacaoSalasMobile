import 'package:aplicationsalasmobile/src/datasources/reserva_datasource.dart';
import 'package:aplicationsalasmobile/src/models/reserva_usuario_response_model.dart';
import 'package:aplicationsalasmobile/src/models/status_code_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ReservaProvider extends ChangeNotifier {
  final Dio dio;
  List<ReservaUsuarioResponseModel> listaReservasUsuario = [];

  ReservaProvider(this.dio);

  Future<List<ReservaUsuarioResponseModel>> reservasUsuario(String diaSemana, int idUsuario) async {
    IReservaDatasource reservasDataSource = ReservaDataSourceImpl(dio: dio);
    listaReservasUsuario = await reservasDataSource.getReservaUsuario(diaSemana, idUsuario);
    notifyListeners();
    return listaReservasUsuario;
  }

  Future<StatusCodeResponse> cancelarReservaUsuario(int idReserva) async {
    listaReservasUsuario.forEach((element) {element.toJson();});
    IReservaDatasource reservasDataSource = ReservaDataSourceImpl(dio: dio);

    StatusCodeResponse deletarReserva = await reservasDataSource.cancelarReserva(idReserva, this);

    notifyListeners();
    return deletarReserva;
  }
}