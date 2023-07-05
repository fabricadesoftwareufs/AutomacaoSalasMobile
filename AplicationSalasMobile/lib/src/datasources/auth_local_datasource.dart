import 'dart:convert';
import 'dart:developer';

import 'package:aplicationsalasmobile/src/models/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const KEY_SESSION_USER = 'SESSION_USER';

class AuthLocalDatasource {
  AuthLocalDatasource();

  Future<AuthResponseModel> getCurrentUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final result = sharedPreferences.getString(KEY_SESSION_USER);
    if (result != null) {
     return AuthResponseModel.fromJson(json.decode(result));
    }
    return AuthResponseModel.empty();
  }

  Future<bool> setCurrentUser(AuthResponseModel authResponseModel) async {
    print("[SET USER]: ${authResponseModel.toJson()}");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool result = await sharedPreferences.setString(KEY_SESSION_USER, json.encode(authResponseModel.toJson()));
    return result;
  }
}
