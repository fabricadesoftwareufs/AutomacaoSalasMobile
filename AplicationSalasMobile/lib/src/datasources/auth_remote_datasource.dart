import 'package:dio/dio.dart';
import 'package:aplicationsalasmobile/src/models/auth_request_model.dart';
import 'package:aplicationsalasmobile/src/models/auth_response_model.dart';

const KEY_SESSION_TOKEN = 'SESSION_TOKEN';

abstract class IAuthDatasource{
  Future<AuthResponseModel> login(AuthRequestModel authModel);
  Future<bool> setToken(AuthResponseModel authResponseModel);
  Future<AuthResponseModel> getToken();
}

class AuthDataSourceImpl extends IAuthDatasource{
  final Dio dio;

  AuthDataSourceImpl({required this.dio});

  @override
  Future<AuthResponseModel> login(AuthRequestModel authModel) async {
    try{
      Response res = await dio.post("/Auth",data: authModel.toJson());
      AuthResponseModel authResponseModel = AuthResponseModel.fromJson(res.data);
      //await setToken(authResponseModel);
      return authResponseModel;
    } on DioError {
      return AuthResponseModel.empty();
    }

  }

  @override
  Future<bool> setToken(AuthResponseModel authResponseModel) {
    // TODO: implement setToken
    throw UnimplementedError();
  }

  @override
  Future<AuthResponseModel> getToken() {
    // TODO: implement getToken
    throw UnimplementedError();
  }

}
