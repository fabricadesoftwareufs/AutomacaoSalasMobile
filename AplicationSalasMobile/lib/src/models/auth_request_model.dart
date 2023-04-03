class AuthRequestModel{
  final String login;
  final String senha;

  AuthRequestModel({required this.login,required this.senha});

  factory AuthRequestModel.fromJson(Map<String, dynamic> map) {
    return AuthRequestModel(
      login: map['login'],
      senha: map['senha'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'senha': senha,
    };
  }
}