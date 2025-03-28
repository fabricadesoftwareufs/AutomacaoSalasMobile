import 'package:salas_mobile/src/models/bloco_model.dart';
import 'package:salas_mobile/src/models/horario_sala_model.dart';
import 'package:salas_mobile/src/models/monitoramento_condicionadores_model.dart';
import 'package:salas_mobile/src/models/monitoramento_luzes_model.dart';
import 'package:salas_mobile/src/models/sala_exclusiva_model.dart';
import 'package:salas_mobile/src/models/sala_model.dart';

class SalasUsuarioResponseModel {
  final SalaExclusivaModel salaExclusivaModel;
  final SalaModel salaModel;
  final MonitoramentoLuzesModel monitoramentoLuzesModel;
  final MonitoramentoCondicionadoresModel monitoramentoCondicionadoresModel;
  final BlocoModel blocoModel;
  final HorarioSalaModel horarioSala;

  SalasUsuarioResponseModel(
      {required this.salaExclusivaModel,
        required this.salaModel,
        required this.monitoramentoLuzesModel,
        required this.monitoramentoCondicionadoresModel,
        required this.blocoModel,
        required this.horarioSala});

  factory SalasUsuarioResponseModel.fromJson(Map<String, dynamic> map) {
    return SalasUsuarioResponseModel(
        salaExclusivaModel: map['salaExclusiva'] != null
            ? SalaExclusivaModel.fromJson(map['salaExclusiva'])
            : SalaExclusivaModel.empty(),
        salaModel: map['sala'] != null
            ? SalaModel.fromJson(map['sala'])
            : SalaModel.empty(),
        monitoramentoLuzesModel: map['monitoramentoLuzes'] != null
            ? MonitoramentoLuzesModel.fromJson(map['monitoramentoLuzes'])
            : MonitoramentoLuzesModel.empty(),
        monitoramentoCondicionadoresModel: map['monitoramentoCondicionadores'] != null
            ? MonitoramentoCondicionadoresModel.fromJson(map['monitoramentoCondicionadores'])
            : MonitoramentoCondicionadoresModel.empty(),
        blocoModel: map['bloco'] != null
            ? BlocoModel.fromJson(map['bloco'])
            : BlocoModel.empty(),
        horarioSala: map['horarioSala'] != null
          ? HorarioSalaModel.fromJson(map['horarioSala'])
          : HorarioSalaModel.empty()
    );
  }
}