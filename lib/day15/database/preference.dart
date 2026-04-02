import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHandler {
  static final PreferenceHandler _instance = PreferenceHandler._internal();
  late SharedPreferences _preferences;

  factory PreferenceHandler() => _instance;

  PreferenceHandler._internal();

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static const String _isLogin = 'isLogin';
  static const String _token = 'token';
  static const String _name = 'name';
  static const String _email = 'email';
  static const String _oldEmail = 'oldEmail';
  static const String _phone = 'phone';
  static const String _image = 'image';

  Future<void> storingIsLogin(bool isLogin) async {
    await _preferences.setBool(_isLogin, isLogin);
  }

  Future<void> storingToken(String token) async {
    await _preferences.setString(_token, token);
  }

  /// 🔥 Simpan profile, update email baru tanpa hapus phone/image lama
  Future<void> saveUserProfile({
    required String name,
    required String email,
    String? phone,
    String? image,
  }) async {
    final currentEmail = _preferences.getString(_email) ?? "";
    if (currentEmail.isNotEmpty && currentEmail != email) {
      await _preferences.setString(_oldEmail, currentEmail);
    }

    await _preferences.setString(_name, name);
    await _preferences.setString(_email, email);

    if (phone != null) await _preferences.setString(_phone, phone);
    if (image != null) await _preferences.setString(_image, image);
  }

  Future<Map<String, String>> getProfile() async {
    return {
      "name": _preferences.getString(_name) ?? "",
      "email": _preferences.getString(_email) ?? "",
      "oldEmail": _preferences.getString(_oldEmail) ?? "",
      "phone": _preferences.getString(_phone) ?? "",
      "image": _preferences.getString(_image) ?? "",
    };
  }

  static Future<bool?> getIsLogin() async =>
      (await SharedPreferences.getInstance()).getBool(_isLogin);

  static Future<String?> getToken() async =>
      (await SharedPreferences.getInstance()).getString(_token);

  Future<void> deleteIsLogin() async => await _preferences.remove(_isLogin);

  Future<void> deleteUserProfile() async {
    await _preferences.remove(_name);
    await _preferences.remove(_email);
    await _preferences.remove(_oldEmail);
    await _preferences.remove(_phone);
    await _preferences.remove(_image);
  }

  Future<void> clearAll() async => await _preferences.clear();
}
