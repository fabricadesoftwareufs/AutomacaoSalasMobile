import 'package:salas_mobile/src/models/equipamento_navigation_model.dart';

class MonitoramentoLuzesModel {
  final int id;
  bool estado;
  final int idEquipamento;
  final int idOperacao;
  final String dataHora;
  final int idUsuario;
  final int temperatura;
  final bool salaParticular;
  final EquipamentoNavigationModel equipamentoNavigationModel;

  MonitoramentoLuzesModel({
    required this.id,
    required this.estado,
    required this.idEquipamento,
    required this.idOperacao,
    required this.dataHora,
    required this.idUsuario,
    required this.temperatura,
    required this.salaParticular,
    required this.equipamentoNavigationModel,
  });

  factory MonitoramentoLuzesModel.fromJson(Map<String, dynamic> map) {
    return MonitoramentoLuzesModel(
      id: map["id"],
      estado: map["estado"],
      idEquipamento: map["idEquipamento"], // MUDANÇA
      idOperacao: map["idOperacao"] ?? 0,
      dataHora: map["dataHora"] ?? "",
      idUsuario: map["idUsuario"] ?? 0,
      temperatura: map["temperatura"] ?? 0,
      salaParticular: map["salaParticular"] ?? false,
      equipamentoNavigationModel: map["idEquipamentoNavigation"] != null // MUDANÇA
          ? EquipamentoNavigationModel.fromJson(map["idEquipamentoNavigation"])
          : EquipamentoNavigationModel.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'estado': estado,
      'idEquipamento': idEquipamento, // MUDANÇA
      'idOperacao': idOperacao,
      'dataHora': dataHora,
      'idUsuario': idUsuario,
      'temperatura': temperatura,
      'salaParticular': salaParticular,
      'idEquipamentoNavigation': equipamentoNavigationModel.toJson(), // MUDANÇA
    };
  }

  factory MonitoramentoLuzesModel.empty() => MonitoramentoLuzesModel(
    id: 0,
    estado: false,
    idEquipamento: 0,
    idOperacao: 0,
    dataHora: "",
    idUsuario: 0,
    temperatura: 0,
    salaParticular: false,
    equipamentoNavigationModel: EquipamentoNavigationModel.empty(),
  );
}