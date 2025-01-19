import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/login.dart'; // Import the LoginPage
import 'utils/colors.dart'; // Import the colors.dart
import 'package:flutter/services.dart'; // Import services for system UI styling

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(options: FirebaseOptions(
        apiKey: "AIzaSyD_BKyMnUCgk5_xvQcdz_lfw1TEXsL-k2M",
        authDomain: "digital-bharat-crieya.firebaseapp.com",
        projectId: "digital-bharat-crieya",
        storageBucket: "digital-bharat-crieya.firebasestorage.app",
        messagingSenderId: "408636439453",
        appId: "1:408636439453:web:a68360abf24e8fcd740d74"));
  }
  else{
   await  Firebase.initializeApp();
  }
  // Set the status bar color to transparent for blending
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Make status bar transparent
    statusBarIconBrightness: Brightness.dark, // Set icons to be dark if needed
  ));

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