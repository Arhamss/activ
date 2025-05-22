import 'package:activ/core/app_preferences/base_storage.dart';

class AppPreferences extends BaseStorage {
  AppPreferences() {
    init('app-storage');
  }

  final String _authTokenKey = 'auth_token';
  final String _userIdKey = 'user_id';
  final String _refreshTokenKey = 'refresh_token';
  final String _appLocale = 'app_locale';
  final String _userModelKey = 'user_model';

  void setAppLocale(String locale) {
    store<String>(_appLocale, locale);
  }

  void clearAppLocale() {
    remove(_appLocale);
  }

  String? getAppLocale() {
    return retrieve<String>(_appLocale);
  }

  void setToken(String token) {
    store<String>(_authTokenKey, token);
  }

  String? getToken() {
    return retrieve<String>(_authTokenKey);
  }

  void setUserId(String userId) {
    store<String>(_userIdKey, userId);
  }

  String? getUserId() {
    return retrieve<String>(_userIdKey);
  }

  void setRefreshToken(String token) {
    store<String>(_refreshTokenKey, token);
  }

  String? getRefreshToken() {
    return retrieve<String>(_refreshTokenKey);
  }

  void removeUserModel() {
    remove(_userModelKey);
  }

  void clearAuthData() {
    remove(_authTokenKey);
    remove(_refreshTokenKey);
    remove(_userIdKey);
  }

  void clearAll() {
    removeAll();
  }
}
