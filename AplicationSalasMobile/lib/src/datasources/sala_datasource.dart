import 'package:salas_mobile/src/models/bloco_model.dart';
import 'package:salas_mobile/src/models/monitorar_sala_request_model.dart';
import 'package:salas_mobile/src/models/sala_model.dart';
import 'package:salas_mobile/src/models/salas_usuario_response_model.dart';
import 'package:salas_mobile/src/models/status_code_response.dart';
import 'package:dio/dio.dart';

abstract class ISalaDatasource {
  Future<List<SalaModel>> getSalas();

  Future<List<BlocoModel>> getBlocos();

  Future<List<SalasUsuarioResponseModel>> salasUsuario(int idUsuario);

  Future<StatusCodeResponse> putMonitorarSala(MonitorarSalaRequestModel monitoraSala, String token);
}

class SalaDataSourceImpl extends ISalaDatasource {
  final Dio dio;

  SalaDataSourceImpl({required this.dio});

  @override
  Future<List<SalasUsuarioResponseModel>> salasUsuario(int idUsuario) async {
    try {
      Response res = await dio.get("/SalaParticular/getSalasExclusivasByUsuario/$idUsuario");
      List<SalasUsuarioResponseModel> lista = (res.data["result"]["salasUsuario"] as List<dynamic>).map((e) {
        return SalasUsuarioResponseModel.fromJson(e);
      }).toList();
      return lista;
    } on DioException {
      return [];
    }
  }

  @override
  Future<List<SalaModel>> getSalas() async {
    try {
      Response res = await dio.get("/Sala");
      List<SalaModel> lista = (res.data as List<dynamic>).map((e) => SalaModel.fromJson(e)).toList();
      return lista;
    } on DioException {
      return [];
    }
  }

  @override
  Future<List<BlocoModel>> getBlocos() async {
    try {
      Response res = await dio.get("/Bloco");
      List<BlocoModel> lista = (res.data['result'] as List<dynamic>).map((e) => BlocoModel.fromJson(e)).toList();
      return lista;
    } on DioException {
      return [];
    }
  }

  @override
  Future<StatusCodeResponse> putMonitorarSala(MonitorarSalaRequestModel monitoraSala, String token) async {
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      Response res = await dio.put("/Monitoramento/MonitorarSala",
          data: monitoraSala.toJson(),
      );
      return StatusCodeResponse(statusCode: 200, mensagem: res.data["message"]);
    } on DioException catch (e) {
      if(e.response?.statusCode == 401) {
        return StatusCodeResponse(statusCode: 401, mensagem: "Sem permissão!");
      } else if(e.response?.statusCode == 500) {
        return StatusCodeResponse(statusCode: 500, mensagem: e.response?.data['message']);
      }
      return StatusCodeResponse(statusCode: 404, mensagem: "Monitoramento não pode ser realizado!");
    }
  }
}
