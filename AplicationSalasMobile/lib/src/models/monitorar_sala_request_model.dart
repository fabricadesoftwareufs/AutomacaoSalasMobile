class MonitorarSalaRequestModel {
  final int id;
  final bool estado;
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
}