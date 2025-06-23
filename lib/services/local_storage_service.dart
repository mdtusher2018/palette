import 'dart:convert';
import 'package:palette/models/common_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _tokenKey = 'token';
  static const _savedLogins = 'saved_logins';
  static const _userData = 'user_data';

  // Save token
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<void> saveUserAttributes(UserAttributes user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userData, json.encode(user.toJson()));
  }

  Future<UserAttributes?> loadUserAttributes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('user_data');

    if (jsonString == null) return null;
    return UserAttributes.fromJson(json.decode(jsonString));
  }

  // Get token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Remove token (for logout)
  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // Clear all preferences (optional)
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> saveLoginToLocal(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    // Load existing map from SharedPreferences
    String? jsonString = prefs.getString(_savedLogins);
    Map<String, String> loginsMap = {};

    if (jsonString != null) {
      loginsMap = Map<String, String>.from(json.decode(jsonString));
    }

    // Add new email-password pair (you may avoid duplicates here if needed)
    loginsMap[email] = password;

    // Save back to SharedPreferences
    await prefs.setString(_savedLogins, json.encode(loginsMap));
  }

  Future<Map<String, String>> getSavedLogins() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('saved_logins');
    if (jsonString != null) {
      return Map<String, String>.from(json.decode(jsonString));
    } else {
      return {};
    }
  }

  Future<void> removeLogin(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final savedLoginsJson = prefs.getString(_savedLogins);

    if (savedLoginsJson == null) return;

    final Map<String, String> savedLogins =
        Map<String, String>.from(json.decode(savedLoginsJson));

    savedLogins.remove(email);

    // Save updated map
    await prefs.setString(_savedLogins, json.encode(savedLogins));
  }
}
