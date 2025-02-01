import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digitalbharat/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List<dynamic> events = [];
  bool _isLoading = true;
  String? _errorMessage;

  final String baseUrl = 'https://uniconnect.erctech.in/mit_adt_uni_BE_php_rest_api_react/';

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}getAllEvents.php'));
      if (response.statusCode == 200) {
        setState(() {
          events = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load events: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Exception occurred: $e';
        _isLoading = false;
      });
    }
  }

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
        centerTitle: true,
        title: Text(
          'Events',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: screenWidth * 0.06,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return EventCard(event: event, baseUrl: baseUrl);
                  },
                ),
    );
  }
}

class EventCard extends StatelessWidget {
  final dynamic event;
  final String baseUrl;

  const EventCard({Key? key, required this.event, required this.baseUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final String imagePath = event['EventWallpaperPath'] != null && event['EventWallpaperPath'].isNotEmpty
        ? baseUrl + event['EventWallpaperPath']
        : 'assets/event_placeholder.jpg';

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
            child: Image.network(
              imagePath,
              height: screenHeight * 0.2,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/event_placeholder.jpg',
                  height: screenHeight * 0.2,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event['EventName'] ?? 'Event Name',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryPurple,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Venue: ${event['EventVenue'] ?? 'Not Available'}',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.04,
                    color: kPrimaryPurple,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Date: ${event['EventDate'] ?? 'Not Available'} | Time: ${event['EventTime'] ?? 'Not Available'}',
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
  }
}