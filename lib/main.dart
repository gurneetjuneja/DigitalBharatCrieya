import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/login.dart'; // Import the LoginPage
import 'utils/colors.dart'; // Import the colors.dart

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Bharat',
      debugShowCheckedModeBanner: false, // Remove the debug banner
      theme: ThemeData(
        primaryColor: kPrimaryPurple, // Set primary color from colors.dart
        scaffoldBackgroundColor: kBackgroundColor, // Use default background color
        textTheme: GoogleFonts.poppinsTextTheme(), // Apply Google Fonts Poppins for text theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryPurple, // Use primary purple for elevated buttons
            textStyle: const TextStyle(color: Colors.white),
          ),
        ),
        useMaterial3: true, // Enable Material 3
      ),
      home: const LoginPage(), // Set the LoginPage as the home page
    );
  }
}