import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';
import 'login.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

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
                Navigator.of(context).pop();
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
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                      (Route<dynamic> route) => false,
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

            // Name
            Text(
              'Sarah Matthews',
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.bold,
                color: kPrimaryPurple,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),

            // ID
            Text(
              'MITU23BTIT0024',
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.w600,
                color: kPrimaryPurple,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),

            // Department
            Text(
              'School Of Computing - Information Technology',
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
                  _showLogoutDialog(context);
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