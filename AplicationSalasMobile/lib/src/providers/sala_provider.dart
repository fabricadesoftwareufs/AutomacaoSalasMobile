import 'package:aplicationsalasmobile/src/datasources/sala_datasource.dart';
import 'package:aplicationsalasmobile/src/models/bloco_response_model.dart';
import 'package:aplicationsalasmobile/src/models/sala_join_bloco_model.dart';
import 'package:aplicationsalasmobile/src/models/sala_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class SalaProvider extends ChangeNotifier {
  final Dio dio;

  SalaProvider(this.dio);

  Future<List<SalaJoinBlocoModel>> getSalas() async {
    ISalaDatasource salaDataSource = SalaDataSourceImpl(dio: dio);
    final List<SalaResponseModel> listaSalas = await salaDataSource.getSalas();
    final List<BlocoResponseModel> listaBlocos = await salaDataSource.getBlocos();
    List<SalaJoinBlocoModel> listaSalasBlocos = [];
    String bloco = '';
    int idBloco = 0;
    for (int i = 0; i < listaSalas.length; i++) {
      bloco = listaBlocos
          .where((element) {
            idBloco = element.id;
            return element.id == listaSalas[i].blocoId;
          })
          .first
          .titulo;
      listaSalasBlocos
          .add(SalaJoinBlocoModel(id: listaSalas[i].id + idBloco, bloco: bloco, sala: listaSalas[i].titulo));
    }
    return listaSalasBlocos;
  }
}
