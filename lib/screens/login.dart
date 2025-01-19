import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart'; // Import the HomePage for navigation
import '../utils/colors.dart'; // Import your colors file

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          // Fixed Logo layer - centered and stays fixed
          Align(
            alignment: Alignment.center,
            child: Opacity(
              opacity: 0.1, // Adjust opacity for subtle visibility
              child: Image.asset(
                'assets/mit_logo.png',
                fit: BoxFit.contain,
                width: screenWidth * 0.95, // Logo uses 90% of the screen width
              ),
            ),
          ),
          // Scrollable content
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08, vertical: screenHeight * 0.10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Heading with subtle drop shadow
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.04), // Increased space to move the heading lower
                      Text(
                        'MIT ADT University',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryPurple,
                          shadows: [
                            Shadow(
                              blurRadius: 5.0,
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Digital Bharat Project',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryPurple,
                          shadows: [
                            Shadow(
                              blurRadius: 5.0,
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.10), // Add extra space before the login fields
                // Login text with subtle shadow
                Text(
                  'Login',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // Enrollment No. field with increased padding
                TextField(
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: 'Enrollment No.',
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.02, horizontal: screenWidth * 0.04), // Increased field padding
                    border: const UnderlineInputBorder(),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // Registered Mobile No. field with increased padding
                TextField(
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: 'Registered Mobile No.',
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.02, horizontal: screenWidth * 0.04), // Increased field padding
                    border: const UnderlineInputBorder(),
                  ),
                ),
                SizedBox(height: screenHeight * 0.08), // Add space before the button
                // Continue button with rectangular shape, rounded corners and reduced size
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryPurple,
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.10, vertical: screenHeight * 0.015), // Adjusted padding for rectangular shape
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18), // Rounded corners
                      ),
                    ),
                    child: Text(
                      'Continue',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: screenWidth * 0.05, // Reduced font size
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05), // Extra space after button if needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
