class SalaExclusivaModel {
  final int id;
  final int usuarioId;
  final int salaId;

  SalaExclusivaModel({required this.id, required this.usuarioId, required this.salaId});

  factory SalaExclusivaModel.fromJson(Map<String, dynamic> map) {
    return SalaExclusivaModel(id: map['id'] ?? 0, usuarioId: map['usuarioId'] ?? 0, salaId: map['salaId'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'usuarioId': usuarioId, 'salaId': salaId};
  }

  factory SalaExclusivaModel.empty() => SalaExclusivaModel(id: 0, usuarioId: 0, salaId: 0);
}
