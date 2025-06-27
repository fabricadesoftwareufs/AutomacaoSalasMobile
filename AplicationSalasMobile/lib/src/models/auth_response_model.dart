class AuthResponseModel{
  final int id;
  final String cpf;
  final String nome;
  final String tipodeUsuario;
  final String organizacao;
  final String token;

  AuthResponseModel({required this.id, required this.cpf, required this.nome, required this.token, required this.tipodeUsuario, required this.organizacao});

  factory AuthResponseModel.fromJson(Map<String, dynamic> map) => AuthResponseModel(
      id: map['id'],
      cpf: map['cpf'],
      nome: map['nome'],
      tipodeUsuario: map['tipodeUsuario'],
      organizacao: map['organizacao'],
      token: map['token']
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'tipodeUsuario': tipodeUsuario,
      'organizacao': organizacao,
      'token': token
    };
  }

  factory AuthResponseModel.empty() => AuthResponseModel(token: '', id: 0, cpf: '', nome: '',
      tipodeUsuario: '', organizacao: '');
}