import 'package:shared_preferences/shared_preferences.dart';

// Set (store) and get (retrive) the JWT token locally (users' devices)
class LocalStorageRepository {
  void setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString('auth-token-jwt', token);
  }

  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String? token = preferences.getString('auth-token-jwt');

    return token;
  }
}
