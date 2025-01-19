import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digitalbharat/utils/colors.dart'; // Import your colors file
import 'account_page.dart'; // Import the AccountPage
import 'lodge_screen.dart'; // Import the LodgeScreen
import 'status_screen.dart'; // Import the ViewStatusScreen

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isAccountPageVisible = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryPurple,
        automaticallyImplyLeading: false,
        title: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: screenWidth * 0.07,
                ),
                onPressed: () {
                  setState(() {
                    _isAccountPageVisible = !_isAccountPageVisible;
                  });
                },
              ),
            ),
            Center(
              child: Text(
                'Home',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: screenWidth * 0.07,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.4,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/mit_logo.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        'Welcome to',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.065,
                          fontWeight: FontWeight.normal,
                          color: kPrimaryPurple,
                          shadows: [
                            Shadow(
                              blurRadius: 5.0,
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'MIT ADT University\'s',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.075,
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
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'Digital Bharat Project',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.065,
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
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LodgeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryPurple,
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                    ),
                    minimumSize: Size(screenWidth * 0.85, screenHeight * 0.08),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Lodge A Complaint',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ViewStatusScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryPurple,
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                    ),
                    minimumSize: Size(screenWidth * 0.85, screenHeight * 0.08),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'View Complaint Status',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: _isAccountPageVisible ? 0 : -screenWidth * 0.8,
            right: 0,
            top: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: screenWidth * 0.8,
                height: screenHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: const AccountPage(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}