import 'package:aplicationsalasmobile/src/models/bloco_model.dart';
import 'package:aplicationsalasmobile/src/models/sala_model.dart';
import 'package:aplicationsalasmobile/src/models/salas_usuario_response_model.dart';
import 'package:dio/dio.dart';

abstract class ISalaDatasource {
  Future<List<SalaModel>> getSalas();
  Future<List<BlocoModel>> getBlocos();
  Future<List<SalasUsuarioResponseModel>> salasUsuario(int idUsuario);
}

class SalaDataSourceImpl extends ISalaDatasource {
  final Dio dio;

  SalaDataSourceImpl({required this.dio});

  Future<List<SalasUsuarioResponseModel>> salasUsuario(int idUsuario) async {
    try {
      Response res = await dio.get("/SalaParticular/getSalasExclusivasByUsuario/$idUsuario");
      List<SalasUsuarioResponseModel> lista = (res.data["result"]["salasUsuario"] as List<dynamic>).map((e) {
        return SalasUsuarioResponseModel.fromJson(e);
      }).toList();
      return lista;
    } on DioError catch(e) {
      return [];
    }
  }

  Future<List<SalaModel>> getSalas() async {
    try {
      Response res = await dio.get("/Sala");
      List<SalaModel> lista = (res.data as List<dynamic>).map((e) => SalaModel.fromJson(e)).toList();
      return lista;
    } on DioError catch(e) {
      return [];
    }
  }

  Future<List<BlocoModel>> getBlocos() async {
    try {
      Response res = await dio.get("/Bloco");
      List<BlocoModel> lista = (res.data['result'] as List<dynamic>).map((e) => BlocoModel.fromJson(e)).toList();
      return lista;
    } on DioError catch(e) {
      return [];
    }
  }
}