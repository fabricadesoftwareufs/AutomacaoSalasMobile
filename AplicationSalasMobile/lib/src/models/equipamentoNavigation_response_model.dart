class EquipamentoNavigationResponseModel {
  final int id;
  final String modelo;
  final String marca;
  final String descricao;
  final int sala;
  final String tipoEquipamento;
  final String hardwareDeSala;

  EquipamentoNavigationResponseModel(
      {required this.id,
      required this.modelo,
      required this.marca,
      required this.descricao,
      required this.sala,
      required this.tipoEquipamento,
      required this.hardwareDeSala});

  factory EquipamentoNavigationResponseModel.fromJson(Map<String, dynamic> map) {
    return EquipamentoNavigationResponseModel(
      id: map['id'] ?? 0,
      modelo: map['modelo'] ?? '',
      marca: map['marca'] ?? '',
      descricao: map['descricao'] ?? '',
      sala: map['sala'] ?? 0,
      tipoEquipamento: map['tipoEquipamento'] ?? '',
      hardwareDeSala: map['hardwareDeSala'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'modelo': modelo,
      'marca': marca,
      'descricao': descricao,
      'sala': sala,
      'tipoEquipamento': tipoEquipamento,
      'hardwareDeSala': hardwareDeSala
    };
  }
}
