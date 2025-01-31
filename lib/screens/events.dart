import 'package:flutter/material.dart';
import 'package:digitalbharat/utils/colors.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryPurple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // This ensures the back button works correctly
          },
        ),
        title: const Text(
          'Events',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: 5, // Static number of events for now
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    'assets/event_placeholder.jpg', // Replace with an actual placeholder image in your assets
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Event Name $index',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryPurple, // Updated color
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Venue: Auditorium',
                        style: TextStyle(
                          color: kPrimaryPurple, // Updated color
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Date: 2025-02-01 | Time: 10:00 AM',
                        style: TextStyle(
                          color: kPrimaryPurple, // Updated color
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryPurple.withOpacity(0.8), // Lighter purple
                          ),
                          child: const Text(
                            'View Details',
                            style: TextStyle(
                              color: kBackgroundColor, // Button text matches background color
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
