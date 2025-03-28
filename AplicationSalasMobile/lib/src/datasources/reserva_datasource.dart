import 'package:salas_mobile/src/models/reserva_usuario_response_model.dart';
import 'package:salas_mobile/src/models/status_code_response.dart';
import 'package:dio/dio.dart';

import '../providers/reserva_provider.dart';

abstract class IReservaDatasource {
  Future<List<ReservaUsuarioResponseModel>> getReservaUsuario(String diaSemana, int idUsuario);

  Future<StatusCodeResponse> cancelarReserva(int idReserva, ReservaProvider reservaProvider);
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
    } on DioException {
      return [];
    }
  }

  @override
  Future<StatusCodeResponse> cancelarReserva(int idReserva,ReservaProvider reservaProvider) async {
    try {
      Response res = await dio.delete("/HorarioSala/cancelarReserva/$idReserva");
      reservaProvider.listaReservasUsuario.removeWhere((element) => element.horarioSala.id == idReserva);
      return StatusCodeResponse(statusCode: 200, mensagem: res.data["message"]); // res.data["message"];
    } on DioException catch (e) {
      if(e.response?.statusCode == 401) {
        return StatusCodeResponse(statusCode: 401, mensagem: "Sem permissão!");
      } else if(e.response?.statusCode == 500) {
        return StatusCodeResponse(statusCode: 500, mensagem: e.response?.data['message']); // e.response?.data['message'];
      }
      return StatusCodeResponse(statusCode: 500, mensagem: "Reserva não pode ser cancelada!");
    }
  }
}