import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:salas_mobile/src/datasources/auth_remote_datasource.dart';
import 'package:salas_mobile/src/models/auth_request_model.dart';
import 'package:salas_mobile/src/models/auth_response_model.dart';
import 'package:salas_mobile/src/services/auth_service.dart';

class AuthProvider extends ChangeNotifier{
  bool logado = false;
  bool _isLoading = true;
  final Dio dio;
  String? _token;
  AuthResponseModel? _currentUser;

  AuthProvider(this.dio);

  bool get isLoading => _isLoading;
  String? get token => _token;
  AuthResponseModel? get currentUser => _currentUser;

  Future<void> initializeAuth() async {
    _isLoading = true;
    notifyListeners();

    final isLoggedIn = await AuthService.isLoggedIn();
    final userData = await AuthService.getUserData();

    if (isLoggedIn && userData != null) {
      try {
        // Tentar recriar o AuthResponseModel dos dados salvos
        _currentUser = AuthResponseModel.fromJson(userData);
        _token = _currentUser?.token;
        logado = true;

        // Opcional: verificar se o token ainda é válido fazendo uma chamada para a API
        // await getCurrentUser();
      } catch (e) {
        print('Erro ao recuperar dados salvos: $e');
        await AuthService.clearAuthData();
        logado = false;
        _token = null;
        _currentUser = null;
      }
    } else {
      logado = false;
      _token = null;
      _currentUser = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<AuthResponseModel?> login(AuthRequestModel authRequestModel) async {
    IAuthDatasource authDataSource = AuthDataSourceImpl(dio: dio);
    final AuthResponseModel authResponseModel = await authDataSource.login(authRequestModel);

    if(authResponseModel.token != "") {
      // Salvar dados completos do AuthResponseModel
      await AuthService.saveAuthResponse(authResponseModel.toJson());

      _token = authResponseModel.token;
      _currentUser = authResponseModel;
      logado = true;
      notifyListeners();

      return authResponseModel;
    }
    return null;
  }

  Future<void> getCurrentUser() async {
    IAuthDatasource authDataSource = AuthDataSourceImpl(dio: dio);
    AuthResponseModel authResponseModel = await authDataSource.getToken();

    if(authResponseModel.token != "") {
      _currentUser = authResponseModel;
      _token = authResponseModel.token;
      logado = true;

      // Atualizar dados salvos
      await AuthService.saveAuthResponse(authResponseModel.toJson());
    } else {
      await logout();
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await AuthService.clearAuthData();

    logado = false;
    _token = null;
    _currentUser = null;

    notifyListeners();
  }
}