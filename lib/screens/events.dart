import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digitalbharat/utils/colors.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
          backgroundColor: kPrimaryPurple,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true, // Center the title
          title: Text(
            'Events',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: screenWidth * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

      body: ListView.builder(
        itemCount: 5, // Number of events
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(screenWidth * 0.04),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    'assets/event_placeholder.jpg', // Ensure the asset exists
                    height: screenHeight * 0.2,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Event Name $index',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryPurple,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'Venue: Auditorium',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.04,
                          color: kPrimaryPurple,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'Date: 2025-02-01 | Time: 10:00 AM',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.04,
                          color: kPrimaryPurple,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryPurple.withOpacity(0.8),
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.015,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'View Details',
                            style: GoogleFonts.poppins(
                              color: kBackgroundColor,
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
