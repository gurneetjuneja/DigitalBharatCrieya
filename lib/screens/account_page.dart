import 'package:digitalbharat/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart'; // Your colors file

class AccountPage extends StatefulWidget {
  final dynamic data; // Data passed from HomePage

  const AccountPage({Key? key, this.data}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final bool _isAccountPageVisible = true;

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Log Out',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Are you sure you want to log out?',
            style: GoogleFonts.poppins(),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryPurple,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text(
                'Log Out',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog

                // Add your logout logic here (e.g., clear authentication data)

                // Navigate back to the login page
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()), // Replace with your actual login page widget
                      (route) => false, // Remove all previous routes to prevent going back to the account page
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Retrieve the user data passed from the HomePage
    var userData = widget.data;

    // Log the user data to check what is passed
    print(userData);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.06),

            // Title
            Text(
              'User Profile',
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.08,
                fontWeight: FontWeight.bold,
                color: kPrimaryPurple,
                shadows: [
                  Shadow(
                    offset: Offset(0, screenWidth * 0.005),
                    blurRadius: screenWidth * 0.02,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.03),

            // Profile Image
            CircleAvatar(
              radius: screenWidth * 0.22,
              backgroundImage: const AssetImage('assets/student.jpg'),
            ),
            SizedBox(height: screenHeight * 0.03),

            // Name (from userData, null-safe)
            Text(
              'Name: ${userData?['name'] ?? 'Not Available'}',  // Null-aware operator used
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.05,
                color: kPrimaryPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),

            // Enrollment Number (from userData, null-safe)
            Text(
              userData?['enrollment'] ?? 'Enrollment Not Available',  // Null-aware operator used
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.w600,
                color: kPrimaryPurple,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),

            // Department (from userData, null-safe)
            Text(
              userData?['institute'] ?? 'Institute Not Available',  // Null-aware operator used
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.w500,
                color: kPrimaryPurple,
              ),
            ),
            const Spacer(),

            // Log Out Button
            Padding(
              padding: EdgeInsets.only(
                bottom: screenHeight * 0.03,
                left: screenWidth * 0.03,
              ),
              child: ElevatedButton(
                onPressed: () {
                  _showLogoutDialog(context); // Show logout confirmation dialog
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.015,
                  ),
                ),
                child: Text(
                  'Log Out',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.04,
                    color: Colors.white,
                  ),
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
