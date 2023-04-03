import 'package:aplicationsalasmobile/src/models/bloco_response_model.dart';
import 'package:aplicationsalasmobile/src/models/sala_response_model.dart';
import 'package:dio/dio.dart';

abstract class ISalaDatasource {
  Future<List<SalaResponseModel>> getSalas();
  Future<List<BlocoResponseModel>> getBlocos();
}

class SalaDataSourceImpl extends ISalaDatasource {
  final Dio dio;

  SalaDataSourceImpl({required this.dio});

  Future<List<SalaResponseModel>> getSalas() async {
    try {
      Response res = await dio.get("/Sala");
      List<SalaResponseModel> lista = (res.data as List<dynamic>).map((e) => SalaResponseModel.fromJson(e)).toList();
      return lista;
    } on DioError catch(e) {
      return [];
    }
  }

  Future<List<BlocoResponseModel>> getBlocos() async {
    try {
      Response res = await dio.get("/Bloco");
      List<BlocoResponseModel> lista = (res.data['result'] as List<dynamic>).map((e) => BlocoResponseModel.fromJson(e)).toList();
      return lista;
    } on DioError catch(e) {
      return [];
    }
  }
}