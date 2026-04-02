import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHandler {
  static final PreferenceHandler _instance = PreferenceHandler._internal();
  SharedPreferences? _preferences;

  factory PreferenceHandler() => _instance;

  PreferenceHandler._internal();

  // ✅ AUTO INIT (TAMBAHAN PENTING)
  Future<SharedPreferences> get prefs async {
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences!;
  }

  static const String _isLogin = 'isLogin';
  static const String _token = 'token';
  static const String _name = 'name';
  static const String _email = 'email';
  static const String _oldEmail = 'oldEmail';
  static const String _phone = 'phone';
  static const String _image = 'image';

  Future<void> storingIsLogin(bool isLogin) async {
    final p = await prefs;
    await p.setBool(_isLogin, isLogin);
  }

  Future<void> storingToken(String token) async {
    final p = await prefs;
    await p.setString(_token, token);
  }

  /// 🔥 FIX: aman untuk update sebagian field
  Future<void> saveUserProfile({
    required String name,
    required String email,
    String? phone,
    String? image,
  }) async {
    final p = await prefs;

    final currentEmail = p.getString(_email) ?? "";
    if (currentEmail.isNotEmpty && currentEmail != email) {
      await p.setString(_oldEmail, currentEmail);
    }

    await p.setString(_name, name);
    await p.setString(_email, email);

    if (phone != null) {
      await p.setString(_phone, phone);
    }

    if (image != null) {
      await p.setString(_image, image);
    }
  }

  Future<Map<String, String>> getProfile() async {
    final p = await prefs;

    return {
      "name": p.getString(_name) ?? "",
      "email": p.getString(_email) ?? "",
      "oldEmail": p.getString(_oldEmail) ?? "",
      "phone": p.getString(_phone) ?? "",
      "image": p.getString(_image) ?? "",
    };
  }

  static Future<bool?> getIsLogin() async =>
      (await SharedPreferences.getInstance()).getBool(_isLogin);

  static Future<String?> getToken() async =>
      (await SharedPreferences.getInstance()).getString(_token);

  Future<void> deleteIsLogin() async {
    final p = await prefs;
    await p.remove(_isLogin);
  }

  Future<void> deleteUserProfile() async {
    final p = await prefs;
    await p.remove(_name);
    await p.remove(_email);
    await p.remove(_oldEmail);
    await p.remove(_phone);
    await p.remove(_image);
  }

  Future<void> clearAll() async {
    final p = await prefs;
    await p.clear();
  }
}
