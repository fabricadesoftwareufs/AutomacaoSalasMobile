import 'package:aplicationsalasmobile/src/models/bloco_model.dart';
import 'package:aplicationsalasmobile/src/models/horario_sala_model.dart';
import 'package:aplicationsalasmobile/src/models/monitoramento_condicionadores_model.dart';
import 'package:aplicationsalasmobile/src/models/monitoramento_luzes_model.dart';
import 'package:aplicationsalasmobile/src/models/sala_exclusiva_model.dart';
import 'package:aplicationsalasmobile/src/models/sala_model.dart';

class ReservaUsuarioResponseModel {
  final SalaModel sala;
  final SalaExclusivaModel salaExclusiva;
  final MonitoramentoLuzesModel monitoramentoLuzes;
  final MonitoramentoCondicionadoresModel monitoramentoCondicionadores;
  final BlocoModel bloco;
  final HorarioSalaModel horarioSala;

  ReservaUsuarioResponseModel({ required this.sala, required this.salaExclusiva, required this.monitoramentoLuzes, required this.monitoramentoCondicionadores,
    required this.bloco, required this.horarioSala });

  factory ReservaUsuarioResponseModel.fromJson(Map<String, dynamic> map) {
    return ReservaUsuarioResponseModel(
      sala: map['sala'] != null
          ? SalaModel.fromJson(map['sala'])
          : SalaModel.empty(),
      salaExclusiva: map['salaExclusiva'] != null
        ? SalaExclusivaModel.fromJson(map['SalaExclusivaModel'])
        : SalaExclusivaModel.empty(),
      monitoramentoLuzes: map['monitoramentoLuzes'] != null
        ? MonitoramentoLuzesModel.fromJson(map['monitoramentoLuzes'])
        : MonitoramentoLuzesModel.empty(),
      monitoramentoCondicionadores: map['monitoramentoCondicionadores'] != null
        ? MonitoramentoCondicionadoresModel.fromJson(map['monitoramentoCondicionadores'])
        : MonitoramentoCondicionadoresModel.empty(),
      bloco: map['bloco'] != null
        ? BlocoModel.fromJson(map['bloco'])
        : BlocoModel.empty(),
      horarioSala: map['horarioSala'] != null
        ? HorarioSalaModel.fromJson(map['horarioSala'])
        : HorarioSalaModel.empty()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if(sala != null)
        'sala': sala.toJson(),
      if(salaExclusiva != null)
        'salaExclusiva': salaExclusiva,
      if(monitoramentoLuzes != null)
        'monitoramentoLuzes': monitoramentoLuzes.toJson(),
      if(monitoramentoCondicionadores != null)
        'monitoramentoCondicionadores': monitoramentoCondicionadores.toJson(),
      if(bloco != null)
        'bloco': bloco.toJson(),
      if(horarioSala != null)
        'horarioSala': horarioSala.toJson(),
    };
  }

  factory ReservaUsuarioResponseModel.empty() => ReservaUsuarioResponseModel(sala: SalaModel.empty(), salaExclusiva: SalaExclusivaModel.empty(), monitoramentoLuzes: MonitoramentoLuzesModel.empty(), monitoramentoCondicionadores: MonitoramentoCondicionadoresModel.empty(), bloco: BlocoModel.empty(), horarioSala: HorarioSalaModel.empty());
}