import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  // Create a GlobalKey for the Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the key to the Scaffold
      appBar: AppBar(
        backgroundColor: Colors.transparent,  // Makes the AppBar transparent
        elevation: 0,  // Removes the shadow of the AppBar
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),  // Menu icon
          onPressed: () {
            // Use the Scaffold key to open the drawer
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          // Profile picture icon in the trailing section
          GestureDetector(
            onTap: () {
              // Navigate to the profile page when clicked
              Navigator.pushNamed(context, '/profile');
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/profile.jpg'),  // Replace with your profile image
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Drawer Header
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/logo.png'), // Replace with your logo
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Welcome, User',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Navigation Items
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Us'),
              onTap: () {
                // Navigate to About Us page
                Navigator.pushNamed(context, '/homepage');
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text('Contact Us'),
              onTap: () {
                // Navigate to Contact Us page
                Navigator.pushNamed(context, '/homepage');
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_box),
              title: const Text('Create Listing'),
              onTap: () {
                // Navigate to Create Listing page
                Navigator.pushNamed(context, '/homepage');
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Browse Item'),
              onTap: () {
                // Navigate to Browse Item page
                Navigator.pushNamed(context, '/homepage');
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('My Account'),
              onTap: () {
                // Navigate to My Account page
                Navigator.pushNamed(context, '/homepage');
              },
            ),
            ListTile(
              leading: const Icon(Icons.view_list),
              title: const Text('View My Ticket'),
              onTap: () {
                // Navigate to View My Ticket page
                Navigator.pushNamed(context, '/homepage');
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                // Implement logout functionality
                Navigator.pushReplacementNamed(context, '/'); // Redirect to login page
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: const Text(
          'Welcome to the Home Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
