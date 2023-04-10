class SalaModel {
  final int id;
  final String titulo;
  final int blocoId;

  SalaModel({required this.id, required this.titulo, required this.blocoId});

  factory SalaModel.fromJson(Map<String, dynamic> map) {
    return SalaModel(id: map['id'] ?? 0, titulo: map['titulo'] ?? '', blocoId: map['blocoId'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'titulo': titulo, 'blocoId': blocoId};
  }

  factory SalaModel.empty() => SalaModel(id: 0, titulo: '', blocoId: 0);
}
