class SalaResponseModel {
  final int id;
  final String titulo;
  final int blocoId;

  SalaResponseModel({required this.id, required this.titulo, required this.blocoId});

  factory SalaResponseModel.fromJson(Map<String, dynamic> map) {
    return SalaResponseModel(id: map['id'] ?? 0, titulo: map['titulo'] ?? '', blocoId: map['blocoId'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'titulo': titulo, 'blocoId': blocoId};
  }
}
