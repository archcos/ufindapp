import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String apiUrl = 'http://10.0.2.2/login.php'; // Use localhost for Android emulator

  Future<bool> login(String user_email, String hashed_password) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_email': user_email, 'hashed_password': hashed_password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'];
      } else {
        throw Exception('Failed to connect to the server');
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
