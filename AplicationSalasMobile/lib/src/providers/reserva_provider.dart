import 'package:aplicationsalasmobile/src/datasources/reserva_datasource.dart';
import 'package:aplicationsalasmobile/src/models/reserva_usuario_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ReservaProvider extends ChangeNotifier {
  final Dio dio;
  List<ReservaUsuarioResponseModel> listaReservasUsuario = [];

  ReservaProvider(this.dio);

  Future<void> reservasUsuario(String diaSemana, int idUsuario) async {
    IReservaDatasource reservasDataSource = ReservaDataSourceImpl(dio: dio);
    listaReservasUsuario = await reservasDataSource.getReservaUsuario(diaSemana, idUsuario);
    notifyListeners();
  }

  Future<String> cancelarReservaUsuario(int idReserva) async {
    print("IDRSERVA: $idReserva");

    listaReservasUsuario.forEach((element) {element.toJson();});
    IReservaDatasource reservasDataSource = ReservaDataSourceImpl(dio: dio);

    String deletarReserva = await reservasDataSource.cancelarReserva(idReserva, this);

    notifyListeners();
    return deletarReserva;
  }
}