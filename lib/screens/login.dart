import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digitalbharat/function.dart'; // Import fetchData function
import '../utils/colors.dart'; // Import your colors file
import 'home_page.dart'; // Import HomePage for navigation

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String enroll = '';
  String phone = '';
  String apiUrl = 'http://10.0.2.2:5000/api'; // Local API endpoint

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/mit_logo.png',
                fit: BoxFit.contain,
                width: screenWidth * 0.95,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.08, vertical: screenHeight * 0.10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.04),
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
                  SizedBox(height: screenHeight * 0.10),
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
                  TextFormField(
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      labelText: 'Enrollment No.',
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.02,
                          horizontal: screenWidth * 0.04),
                      border: const UnderlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        enroll = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your enrollment number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  TextFormField(
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      labelText: 'Registered Mobile No.',
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.02,
                          horizontal: screenWidth * 0.04),
                      border: const UnderlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        phone = value;
                      });
                    },
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your registered mobile number';
                      } else if (value.length != 10) {
                        return 'Mobile number must be 10 digits';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.08),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Build the API URL with query parameters
                          String url = '$apiUrl?enroll=$enroll&phone=$phone';

                          // Fetch the data from the server
                          try {
                            var response = await fetchdata(url);

                            if (response.containsKey('error')) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(response['error']),
                                ),
                              );
                            } else {
                              // Show "Logged in" message
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Logged in'),
                                  duration: Duration(seconds: 2),
                                ),
                              );

                              // Navigate to the HomePage
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(data: response),
                                ),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error: $e'),
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryPurple,
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.10,
                            vertical: screenHeight * 0.015),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
