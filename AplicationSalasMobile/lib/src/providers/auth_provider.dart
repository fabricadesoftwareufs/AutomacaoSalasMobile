import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:aplicationsalasmobile/src/datasources/auth_remote_datasource.dart';
import 'package:aplicationsalasmobile/src/models/auth_request_model.dart';
import 'package:aplicationsalasmobile/src/models/auth_response_model.dart';

class AuthProvider extends ChangeNotifier{
  bool logado = false;
  final Dio dio;

  AuthProvider(this.dio);

  Future<AuthResponseModel?> login(AuthRequestModel authRequestModel) async {
    IAuthDatasource authDataSource = AuthDataSourceImpl(dio: dio);
    final AuthResponseModel authResponseModel = await authDataSource.login(authRequestModel);
    if(authResponseModel.token != "") return authResponseModel;
    return null;
  }

  Future<void> getCurrentUser()async {
    IAuthDatasource authDataSource = AuthDataSourceImpl(dio: dio);
    AuthResponseModel authResponseModel = await authDataSource.getToken();
    if(authResponseModel.token != "") logado = true;
    notifyListeners();
  }
}


