class MonitorarSalaRequestModel {
  final int id;
  late bool estado;
  final int salaId;
  final int equipamentoId;
  final bool salaParticula;

  MonitorarSalaRequestModel({required this.id, required this.estado, required this.salaId, required this.equipamentoId, required this.salaParticula});

  factory MonitorarSalaRequestModel.fromJson(Map<String, dynamic> map) {
    return MonitorarSalaRequestModel(
      id: map['id'],
      estado: map['estado'],
      salaId: map['salaId'],
      equipamentoId: map['equipamentoId'],
      salaParticula: map['salaParticular'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'estado': estado,
      'salaId': salaId,
      'equipamentoId': equipamentoId,
      'salaParticular': salaParticula,
    };
  }

  factory MonitorarSalaRequestModel.empty() => MonitorarSalaRequestModel(id: 0, estado: false, salaId: 0, equipamentoId: 0, salaParticula: false);
}