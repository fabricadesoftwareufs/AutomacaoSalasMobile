import 'package:salas_mobile/src/models/equipamento_navigation_model.dart';

class MonitoramentoLuzesModel {
  final int id;
  bool estado;
  final int equipamentoId;
  final bool salaParticular;
  final EquipamentoNavigationModel equipamentoNavigationModel;

  MonitoramentoLuzesModel(
      {required this.id,
      required this.estado,
      required this.equipamentoId,
      required this.salaParticular,
      required this.equipamentoNavigationModel});

  factory MonitoramentoLuzesModel.fromJson(Map<String, dynamic> map) {
    return MonitoramentoLuzesModel(
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
      'equipamentoNavigation': equipamentoNavigationModel.toJson(),
    };
  }
  
  factory MonitoramentoLuzesModel.empty() => MonitoramentoLuzesModel(id: 0, estado: false, equipamentoId: 0, salaParticular: false, equipamentoNavigationModel: EquipamentoNavigationModel.empty());
}
