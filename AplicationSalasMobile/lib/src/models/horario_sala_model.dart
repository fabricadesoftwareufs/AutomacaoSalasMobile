class HorarioSalaModel {
  final int id;
  final String data;
  final String horario_inicial;
  final String horario_final;
  final String status;
  final String objective;
  final int id_usuario;
  final int id_sala;

  HorarioSalaModel(
      {required this.id,
      required this.data,
      required this.horario_inicial,
      required this.horario_final,
      required this.status,
      required this.objective,
      required this.id_usuario,
      required this.id_sala});

  factory HorarioSalaModel.fromJson(Map<String, dynamic> map) {
    return HorarioSalaModel(
        id: map['id'],
        data: map['data'],
        horario_inicial: map['horario-inicial'],
        horario_final: map['horario-final'],
        status: map['status'],
        objective: map['objective'],
        id_usuario: map['id-usuario'],
        id_sala: map['id-sala']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'data': data,
      'horario-inicial': horario_inicial,
      'horario-final': horario_final,
      'status': status,
      'objective': objective,
      'id-usuario': id_usuario,
      'id-sala': id_sala
    };
  }

  factory HorarioSalaModel.empty() => HorarioSalaModel(id: 0, data: '', horario_inicial: '', horario_final: '', status: '', objective: '', id_usuario: 0, id_sala: 0);
}
