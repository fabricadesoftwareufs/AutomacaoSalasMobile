import 'package:aplicationsalasmobile/src/models/equipamento_navigation_model.dart';

class MonitoramentoCondicionadoresModel {
  final int id;
  final bool estado;
  final int equipamentoId;
  final bool salaParticular;
  final EquipamentoNavigationModel equipamentoNavigationModel;

  MonitoramentoCondicionadoresModel(
      {required this.id,
        required this.estado,
        required this.equipamentoId,
        required this.salaParticular,
        required this.equipamentoNavigationModel});

  factory MonitoramentoCondicionadoresModel.fromJson(Map<String, dynamic> map) {
    return MonitoramentoCondicionadoresModel(
        id: map["id"],
        estado: map["estado"],
        equipamentoId: map["equipamentoId"],
        salaParticular: map["salaParticular"],
        equipamentoNavigationModel: map["equipamentoNavigation"] != null
            ? EquipamentoNavigationModel.fromJson(map["equipamentoNavigation"])
            : EquipamentoNavigationModel.empty()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'estado': estado,
      'equipamentoId': equipamentoId,
      'salaParticular': salaParticular,
      if(equipamentoNavigationModel != null)
        'equipamentoNavigation': equipamentoNavigationModel.toJson(),
    };
  }

  factory MonitoramentoCondicionadoresModel.empty() => MonitoramentoCondicionadoresModel(id: 0, estado: false, equipamentoId: 0, salaParticular: false, equipamentoNavigationModel: EquipamentoNavigationModel.empty());
}
