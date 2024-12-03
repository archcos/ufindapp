import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ufindapp/services/auth_service.dart';
import 'package:ufindapp/display/signin-page.dart';  // Import the SigninPage

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _schoolIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  int? userId;  // Declare userId variable

  @override
  void initState() {
    super.initState();
    _loadUserId();  // Fetch userId from SharedPreferences
  }

  // Fetch user_id from SharedPreferences
  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');  // Load user_id from SharedPreferences

    if (userId == null) {
      // If user_id is not found, navigate to SignInPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SigninPage()),
      );
    } else {
      setState(() {
        this.userId = userId;  // Try parsing to int, or set to null if it fails
      });
      _fetchUserProfile(userId);  // Fetch profile data for the user
    }
  }

  // Fetch user profile data from the backend
  Future<void> _fetchUserProfile(int? userId) async {
    if (userId == null) {
      print("User ID is null");
      return; // Handle the case where userId is null
    }

    final url = 'http://10.0.2.2/ufind/fetch-profile.php?user_id=$userId';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody['success']) {
          final user = responseBody['user'];
          setState(() {
            _firstNameController.text = user['user_firstname'];
            _lastNameController.text = user['user_lastname'];
            _schoolIdController.text = int.parse(user['school_id'].toString()).toString();
            // Do not populate password as it's sensitive data
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to fetch user profile')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch profile from server')),
        );
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching profile')),
      );
    }
  }

  // Save the updated profile
  void saveProfile() async {
    if (userId != null) {
      final bool success = await AuthService().updateProfile(
        userId! as String,  // Pass userId as int
        _firstNameController.text,
        _lastNameController.text,
        _schoolIdController.text,
        _passwordController.text,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User ID is missing.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if userId is available
    if (userId == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()), // Show loading until userId is fetched
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile picture section (Just a placeholder here)
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile.jpg'), // Replace with actual image
              ),
              SizedBox(height: 16),

              // Text fields for user details
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextField(
                controller: _schoolIdController,
                decoration: InputDecoration(labelText: 'School ID'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(height: 16),

              // Save Button
              ElevatedButton(
                onPressed: saveProfile,
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
