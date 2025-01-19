import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:digitalbharat/utils/colors.dart';
import '../database_helper.dart'; // Ensure this file exists and provides necessary functionality

class LodgeScreen extends StatefulWidget {
  const LodgeScreen({super.key});

  @override
  _LodgeScreenState createState() => _LodgeScreenState();
}

class _LodgeScreenState extends State<LodgeScreen> {
  File? _selectedImage;
  String? _selectedLocation;
  String? _selectedFloor;
  String? _selectedRoom;
  String? _selectedIssueType;
  final TextEditingController _noteController = TextEditingController();

  final List<String> _locations = ['SOFT', 'ISBJ', 'MANET', 'SBSR', 'IT Building', 'SFT', 'IOD'];
  final List<String> _floors = ['Ground', 'First', 'Second', 'Third', 'Fourth', 'Fifth', 'Sixth'];
  final List<String> _rooms = ['Library', 'N301', 'N302', 'N303', 'N304', 'N305', 'N306'];
  final List<String> _issueTypes = ['Electricity', 'Waste Management', 'Water', 'Other (mention in notes)'];

  Future<void> _checkCameraPermission() async {
    if (await Permission.camera.isDenied) {
      await Permission.camera.request();
    }
  }

  Future<void> _pickImage() async {
    await _checkCameraPermission();
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      _showErrorDialog("Error while accessing camera: $e");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Okay'),
            ),
          ],
        );
      },
    );
  }

  void _submitForm() async {
    if (_selectedImage == null ||
        _selectedLocation == null ||
        _selectedFloor == null ||
        _selectedRoom == null ||
        _selectedIssueType == null ||
        _noteController.text.isEmpty) {
      _showErrorDialog('Please fill all fields and upload an image.');
      return;
    }

    // Capture current date and time
    final now = DateTime.now();
    final formattedDate = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    final formattedTime = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    final data = {
      'image_path': _selectedImage!.path,
      'date': formattedDate,
      'time': formattedTime,
      'location': _selectedLocation,
      'floor': _selectedFloor,
      'room': _selectedRoom,
      'issue_type': _selectedIssueType,
      'note': _noteController.text,
    };

    final dbHelper = DatabaseHelper();
    try {
      await dbHelper.insertLodgeData(data);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Data uploaded successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pop(); // Navigate back
                },
                child: const Text('Okay'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Upload failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryPurple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kBackgroundColor, size: screenWidth * 0.08),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Lodge',
          style: GoogleFonts.poppins(
            fontSize: screenWidth * 0.07,
            fontWeight: FontWeight.bold,
            color: kBackgroundColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: screenWidth * 0.33,
                backgroundColor: Colors.grey[200],
                child: _selectedImage == null
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, size: screenWidth * 0.12, color: kPrimaryPurple),
                    SizedBox(height: screenHeight * 0.01),
                    Text('Click an Image', style: GoogleFonts.poppins(fontSize: screenWidth * 0.04, color: kPrimaryPurple)),
                  ],
                )
                    : ClipOval(
                  child: Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                    width: screenWidth * 0.66,
                    height: screenWidth * 0.66,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            _buildDropdown('Location', _locations, _selectedLocation, (value) {
              setState(() {
                _selectedLocation = value;
              });
            }),
            SizedBox(height: screenHeight * 0.02),
            _buildDropdown('Floor', _floors, _selectedFloor, (value) {
              setState(() {
                _selectedFloor = value;
              });
            }),
            SizedBox(height: screenHeight * 0.02),
            _buildDropdown('Room Number', _rooms, _selectedRoom, (value) {
              setState(() {
                _selectedRoom = value;
              });
            }),
            SizedBox(height: screenHeight * 0.02),
            _buildDropdown('Type of Issue', _issueTypes, _selectedIssueType, (value) {
              setState(() {
                _selectedIssueType = value;
              });
            }),
            SizedBox(height: screenHeight * 0.02),
            TextField(
              controller: _noteController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Add a note...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryPurple,
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                'Upload',
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String hint, List<String> items, String? value, ValueChanged<String?> onChanged) {
    final screenWidth = MediaQuery.of(context).size.width;
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: kPrimaryPurple,
        contentPadding: EdgeInsets.only(left: screenWidth * 0.04),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
      hint: Text(hint, style: GoogleFonts.poppins(color: kBackgroundColor)),
      value: value,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: GoogleFonts.poppins(fontSize: screenWidth * 0.035, color: kBackgroundColor),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      icon: Icon(Icons.arrow_drop_down, color: kBackgroundColor, size: screenWidth * 0.07),
      dropdownColor: kPrimaryPurple,
    );
  }
}