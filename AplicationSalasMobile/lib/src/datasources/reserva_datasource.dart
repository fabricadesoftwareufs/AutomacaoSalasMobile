import 'package:aplicationsalasmobile/src/models/reserva_usuario_response_model.dart';
import 'package:dio/dio.dart';

import '../providers/reserva_provider.dart';

abstract class IReservaDatasource {
  Future<List<ReservaUsuarioResponseModel>> getReservaUsuario(String diaSemana, int idUsuario);

  Future<String> cancelarReserva(int idReserva, ReservaProvider reservaProvider);
}

class ReservaDataSourceImpl extends IReservaDatasource {
  final Dio dio;

  ReservaDataSourceImpl({required this.dio});

  @override
  Future<List<ReservaUsuarioResponseModel>> getReservaUsuario(String diaSemana, int idUsuario) async {
    try {
      Response res = await dio.get("/HorarioSala/getReservasByUsuario/$diaSemana/$idUsuario");
      List<ReservaUsuarioResponseModel> lista = (res.data['result']['salasUsuario'] as List<dynamic>).map((e) => ReservaUsuarioResponseModel.fromJson(e)).toList();
      return lista;
    } on DioError {
      return [];
    }
  }

  @override
  Future<String> cancelarReserva(int idReserva,ReservaProvider reservaProvider) async {
    try {
      Response res = await dio.delete("/HorarioSala/cancelarReserva/$idReserva");
      reservaProvider.listaReservasUsuario.removeWhere((element) => element.horarioSala.id == idReserva);
      return res.data["message"];
    } on DioError catch (e) {
      if(e.response?.statusCode == 500) {
        return e.response?.data['message'];
      }
      return "";
    }
  }
}