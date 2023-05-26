import 'package:aplicationsalasmobile/src/models/bloco_model.dart';
import 'package:aplicationsalasmobile/src/models/monitorar_sala_request_model.dart';
import 'package:aplicationsalasmobile/src/models/sala_model.dart';
import 'package:aplicationsalasmobile/src/models/salas_usuario_response_model.dart';
import 'package:dio/dio.dart';

abstract class ISalaDatasource {
  Future<List<SalaModel>> getSalas();

  Future<List<BlocoModel>> getBlocos();

  Future<List<SalasUsuarioResponseModel>> salasUsuario(int idUsuario);

  Future<String> putMonitorarSala(MonitorarSalaRequestModel monitoraSala, String token);
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
    } on DioError {
      return [];
    }
  }

  @override
  Future<List<SalaModel>> getSalas() async {
    try {
      Response res = await dio.get("/Sala");
      List<SalaModel> lista = (res.data as List<dynamic>).map((e) => SalaModel.fromJson(e)).toList();
      return lista;
    } on DioError {
      return [];
    }
  }

  @override
  Future<List<BlocoModel>> getBlocos() async {
    try {
      Response res = await dio.get("/Bloco");
      List<BlocoModel> lista = (res.data['result'] as List<dynamic>).map((e) => BlocoModel.fromJson(e)).toList();
      return lista;
    } on DioError {
      return [];
    }
  }

  @override
  Future<String> putMonitorarSala(MonitorarSalaRequestModel monitoraSala, String token) async {
    try {
      // token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3NlcmlhbG51bWJlciI6IjE3IiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy91c2VyZGF0YSI6IjAxNTUzNzY4NTMxIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiJNaWxlbmEiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9kYXRlb2ZiaXJ0aCI6IjEwLzMxLzIwMDAgMTI6MDA6MDAgQU0iLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJBRE1JTiIsImV4cCI6MTY4NTE1NDM0NCwiaXNzIjoiU2FsYXNVZnNXZWJBcGkubmV0IiwiYXVkIjoiU2FsYXNVZnNXZWJBcGkubmV0In0.uYbJLj571vQnz3PrhYXK2pXlj4STcXG6bvqnK4_7-wM";
      dio.options.headers["Authorization"] = "Bearer $token";
      Response res = await dio.put("/Monitoramento/MonitorarSala",
          data: monitoraSala.toJson(),
      );
      return res.data["message"];
    } on DioError catch (e) {
      if(e.response?.statusCode == 500) {
        return e.response?.data['message'];
      }
      return "Monitoramento não pode ser realizado!";
    }
  }
}
