class BlocoResponseModel {
  final int id;
  final String titulo;
  final int organizacaoId;

  BlocoResponseModel({required this.id, required this.titulo, required this.organizacaoId});

  factory BlocoResponseModel.fromJson(Map<String, dynamic> map) {
    return BlocoResponseModel(id: map['id'] ?? 0, titulo: map['titulo'] ?? '', organizacaoId: map['organizacaoId'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'titulo': titulo, 'organizacaoId': organizacaoId};
  }
}