import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _userDataKey = 'user_data';
  static const String _isLoggedInKey = 'is_logged_in';

  static Future<void> saveAuthData(String token, [Map<String, dynamic>? userData]) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_tokenKey, token);
    await prefs.setBool(_isLoggedInKey, true);

    if (userData != null) {
      await prefs.setString(_userDataKey, json.encode(userData));
    }
  }

  // Método específico para salvar AuthResponseModel completo
  static Future<void> saveAuthResponse(Map<String, dynamic> authResponseData) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_tokenKey, authResponseData['token'] ?? '');
    await prefs.setString(_userDataKey, json.encode(authResponseData));
    await prefs.setBool(_isLoggedInKey, true);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_userDataKey);

    if (userData != null) {
      return json.decode(userData);
    }
    return null;
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  static Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userDataKey);
    await prefs.setBool(_isLoggedInKey, false);
  }
}