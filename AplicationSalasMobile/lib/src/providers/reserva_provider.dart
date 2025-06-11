import 'package:salas_mobile/src/datasources/reserva_datasource.dart';
import 'package:salas_mobile/src/models/reserva_usuario_response_model.dart';
import 'package:salas_mobile/src/models/status_code_response.dart';
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
    for (var element in listaReservasUsuario) {element.toJson();}
    IReservaDatasource reservasDataSource = ReservaDataSourceImpl(dio: dio);

    StatusCodeResponse cancelarReserva = await reservasDataSource.cancelarReserva(idReserva, this);

    notifyListeners();
    return cancelarReserva;
  }


  Future<StatusCodeResponse> aprovarReservaUsuario(int idReserva) async {
    for (var element in listaReservasUsuario) {element.toJson();}
    IReservaDatasource reservasDataSource = ReservaDataSourceImpl(dio: dio);

    StatusCodeResponse aprovarReserva = await reservasDataSource.aprovarReserva(idReserva, this);

    notifyListeners();
    return aprovarReserva;
  }
}