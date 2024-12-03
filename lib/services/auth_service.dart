import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String apiUrlLogin = 'http://10.0.2.2/ufind/login.php'; // Use localhost for Android emulator
  final String apiUrlRegister = 'http://10.0.2.2/ufind/registration.php'; // URL for registration
  final String apiUrlUpdateProfile = 'http://10.0.2.2/ufind/update_profile.php'; // URL for updating the profile
  final String apiUrlFetchUserData = 'http://10.0.2.2/ufind/fetch_user_data.php'; // URL to fetch user data
  final String apiUrlFetchUserProfile = 'http://10.0.2.2/ufind/fetch_profile.php'; // URL for fetching user profile data

  // Login method
  // Login method in AuthService
  Future<Map<String, dynamic>> login(String user_email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrlLogin),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_email': user_email, 'password': password}),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');  // Log the raw response

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);  // This will fail if the response is not valid JSON
        if (data['success']) {
          return {
            'success': true,
            'user_id': data['user_id'],
          };
        } else {
          return {'success': false, 'user_id': null};
        }
      } else {
        throw Exception('Failed to connect to the server');
      }
    } catch (e) {
      print('Error: $e');
      return {'success': false, 'user_id': null};
    }
  }

  // Register method
  Future<bool> register(String user_firstname, String user_lastname, String school_id, String password, String user_email) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrlRegister),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_firstname': user_firstname,
          'user_lastname': user_lastname,
          'school_id': school_id,
          'password': password, // Hash password on the backend (SHA1)
          'user_email': user_email
        }),
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

  // Update Profile method
  Future<Map<String, dynamic>?> fetchUserProfile(String userId) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrlFetchUserProfile),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_id': userId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          return data['user']; // Assuming the response returns the user data in a 'user' field
        } else {
          return null;
        }
      } else {
        throw Exception('Failed to fetch profile');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Update Profile method (existing)
  Future<bool> updateProfile(String user_id, String user_firstname, String user_lastname, String school_id, String password) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrlUpdateProfile),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': user_id,
          'user_firstname': user_firstname,
          'user_lastname': user_lastname,
          'school_id': school_id,
          'password': password, // Ensure password is hashed on the backend (SHA1)
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'];
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // Fetch updated user data
  Future<Map<String, dynamic>?> getUserDetails(int userId) async {
    final response = await http.get(
      Uri.parse('https://yourapi.com/getUserDetails?id=$userId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return {
          'first_name': data['first_name'],
          'last_name': data['last_name'],
          'school_id': data['school_id'],
          'password': data['password'],
        };
      } else {
        return null;  // Handle failure case
      }
    } else {
      throw Exception('Failed to load user details');
    }
  }
}