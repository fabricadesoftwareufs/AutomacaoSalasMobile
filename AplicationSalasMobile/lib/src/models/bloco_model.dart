class BlocoModel {
  final int id;
  final String titulo;
  final int organizacaoId;

  BlocoModel({required this.id, required this.titulo, required this.organizacaoId});

  factory BlocoModel.fromJson(Map<String, dynamic> map) {
    return BlocoModel(
      id: map['id'] ?? 0,
      titulo: map['titulo'] ?? '',
      organizacaoId: map['organizacaoId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'titulo': titulo, 'organizacaoId': organizacaoId};
  }

  factory BlocoModel.empty() => BlocoModel(id: 0, titulo: '', organizacaoId: 0);
}
