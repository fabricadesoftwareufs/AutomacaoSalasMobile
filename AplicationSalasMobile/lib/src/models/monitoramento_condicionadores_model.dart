import 'package:salas_mobile/src/models/equipamento_navigation_model.dart';

class MonitoramentoCondicionadoresModel {
  final int id;
  bool estado;
  final int idEquipamento;
  final int idOperacao;
  final String dataHora;
  final int idUsuario;
  final int temperatura;
  final bool salaParticular;
  final EquipamentoNavigationModel equipamentoNavigationModel;

  MonitoramentoCondicionadoresModel({
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

  factory MonitoramentoCondicionadoresModel.fromJson(Map<String, dynamic> map) {
    return MonitoramentoCondicionadoresModel(
      id: map["id"],
      estado: map["estado"],
      idEquipamento: map["idEquipamento"],
      idOperacao: map["idOperacao"] ?? 0,
      dataHora: map["dataHora"] ?? "",
      idUsuario: map["idUsuario"] ?? 0,
      temperatura: map["temperatura"] ?? 0,
      salaParticular: map["salaParticular"] ?? false,
      equipamentoNavigationModel: map["idEquipamentoNavigation"] != null
          ? EquipamentoNavigationModel.fromJson(map["idEquipamentoNavigation"])
          : EquipamentoNavigationModel.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'estado': estado,
      'idEquipamento': idEquipamento,
      'idOperacao': idOperacao,
      'dataHora': dataHora,
      'idUsuario': idUsuario,
      'temperatura': temperatura,
      'salaParticular': salaParticular,
      'idEquipamentoNavigation': equipamentoNavigationModel.toJson(),
    };
  }

  factory MonitoramentoCondicionadoresModel.empty() => MonitoramentoCondicionadoresModel(
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