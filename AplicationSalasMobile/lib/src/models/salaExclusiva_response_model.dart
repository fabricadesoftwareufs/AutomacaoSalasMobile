class SalaExclusivaResponseModel {
  final int id;
  final int usuarioId;
  final int salaId;

  SalaExclusivaResponseModel({required this.id, required this.usuarioId, required this.salaId});

  factory SalaExclusivaResponseModel.fromJson(Map<String, dynamic> map) {
    return SalaExclusivaResponseModel(id: map['id'] ?? 0, usuarioId: map['usuarioId'] ?? 0, salaId: map['salaId'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'usuarioId': usuarioId, 'salaId': salaId};
  }
}
