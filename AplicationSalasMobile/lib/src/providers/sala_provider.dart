import 'package:aplicationsalasmobile/src/datasources/sala_datasource.dart';
import 'package:aplicationsalasmobile/src/models/monitorar_sala_request_model.dart';
import 'package:aplicationsalasmobile/src/models/salas_usuario_response_model.dart';
import 'package:aplicationsalasmobile/src/models/status_code_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SalaProvider extends ChangeNotifier {
  final Dio dio;

  SalaProvider(this.dio);

  Future<List<SalasUsuarioResponseModel>> salasUsuario(int idUsuario) async {
    ISalaDatasource salaDataSource = SalaDataSourceImpl(dio: dio);

    final List<SalasUsuarioResponseModel> listaSalasUsuario = await salaDataSource.salasUsuario(idUsuario);
    return listaSalasUsuario;
  }

  Future<StatusCodeResponse> putMonitorarSala(MonitorarSalaRequestModel monitoraSala, String token) async {
    ISalaDatasource salaDataSource = SalaDataSourceImpl(dio: dio);

    final StatusCodeResponse resultado = await salaDataSource.putMonitorarSala(monitoraSala, token);
    notifyListeners();
    // print("Provider: ${resultado.statusCode}");
    return resultado;
  }

}
