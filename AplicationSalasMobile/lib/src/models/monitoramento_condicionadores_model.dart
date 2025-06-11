import 'package:salas_mobile/src/models/equipamento_navigation_model.dart';

class MonitoramentoCondicionadoresModel {
  final int id;
  bool estado;
  final int idEquipamento; // MUDANÇA: equipamentoId -> idEquipamento
  final int idOperacao; // NOVO CAMPO
  final String dataHora; // NOVO CAMPO
  final int idUsuario; // NOVO CAMPO
  final int temperatura; // NOVO CAMPO
  final bool salaParticular; // MUDANÇA: agora pode ser null
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