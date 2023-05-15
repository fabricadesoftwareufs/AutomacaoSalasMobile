import 'package:aplicationsalasmobile/src/models/reserva_usuario_response_model.dart';
import 'package:dio/dio.dart';

abstract class IReservaDatasource {
  Future<List<ReservaUsuarioResponseModel>> getReservaUsuario(String diaSemana, int idUsuario);
}

class ReservaDataSourceImpl extends IReservaDatasource {
  final Dio dio;

  ReservaDataSourceImpl({required this.dio});

  Future<List<ReservaUsuarioResponseModel>> getReservaUsuario(String diaSemana, int idUsuario) async {
    try {
      Response res = await dio.get("/HorarioSala/getReservasByUsuario/$diaSemana/$idUsuario");
      List<ReservaUsuarioResponseModel> lista = (res.data['result']['salasUsuario'] as List<dynamic>).map((e) => ReservaUsuarioResponseModel.fromJson(e)).toList();
      return lista;
    } on DioError catch (e) {
      return [];
    }
  }
}