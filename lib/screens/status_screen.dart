import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';
import 'package:digitalbharat/database_helper.dart';

class ViewStatusScreen extends StatefulWidget {
  const ViewStatusScreen({super.key});

  @override
  _ViewStatusScreenState createState() => _ViewStatusScreenState();
}

class _ViewStatusScreenState extends State<ViewStatusScreen> {
  Map<String, List<Map<String, dynamic>>> complaints = {};

  @override
  void initState() {
    super.initState();
    _fetchComplaintsFromDatabase();
  }

  Future<void> _fetchComplaintsFromDatabase() async {
    try {
      final dbHelper = DatabaseHelper();
      final data = await dbHelper.getAllLodgeData();
      print("Fetched data: $data");  // Debugging the fetched data

      if (data.isEmpty) {
        setState(() {
          complaints = {};
        });
        print("No complaints found.");
        return;
      }

      // Sort data by date in descending order
      data.sort((a, b) {
        try {
          return DateTime.parse(b['date']).compareTo(DateTime.parse(a['date']));
        } catch (e) {
          print("Error parsing date: $e");
          return 0;
        }
      });

      // Group data by month
      final groupedData = <String, List<Map<String, dynamic>>>{};
      for (final entry in data) {
        final date = DateTime.parse(entry['date']);
        final month = _monthName(date);
        groupedData.putIfAbsent(month, () => []).add(entry);
      }

      setState(() {
        complaints = groupedData;
      });
    } catch (e) {
      print('Error fetching complaints: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching complaints: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _monthName(DateTime date) {
    const monthNames = [
      "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"
    ];
    return "${monthNames[date.month - 1]} ${date.year}";
  }

  String _formatTime(String time) {
    try {
      final dateTime = DateTime.parse(time);
      final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
      final minute = dateTime.minute.toString().padLeft(2, '0');
      final amPm = dateTime.hour >= 12 ? "PM" : "AM";
      return "$hour:$minute $amPm";
    } catch (e) {
      return "Invalid Time";
    }
  }

  String _formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      const monthNames = [
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
      ];
      return "${parsedDate.day} ${monthNames[parsedDate.month - 1]}, ${parsedDate.year}";
    } catch (e) {
      return "Invalid Date";
    }
  }

  void _showComplaintDetails(Map<String, dynamic> complaint) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: kPrimaryPurple, width: 3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _formatDate(complaint["date"] ?? "No Date"),
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryPurple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  if (complaint["note"] != null && complaint["note"].isNotEmpty)
                    Text(
                      complaint["note"] ?? "No Note",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: kPrimaryPurple,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  const SizedBox(height: 16),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (complaint["time"] != null && complaint["time"].isNotEmpty)
                              Text(
                                "Time: ${_formatTime(complaint["time"])}",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: kPrimaryPurple,
                                ),
                              ),
                            const SizedBox(height: 8),

                            if (complaint["location"] != null && complaint["location"].isNotEmpty)
                              Text(
                                "Location: ${complaint["location"]}",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: kPrimaryPurple,
                                ),
                              ),
                            const SizedBox(height: 8),

                            if (complaint["floor"] != null)
                              Text(
                                "Floor: ${complaint["floor"]}",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: kPrimaryPurple,
                                ),
                              ),
                            const SizedBox(height: 8),

                            if (complaint["classroom"] != null)
                              Text(
                                "Classroom: ${complaint["classroom"]}",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: kPrimaryPurple,
                                ),
                              ),
                            const SizedBox(height: 16),

                            Text(
                              "Status",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: kPrimaryPurple,
                              ),
                            ),
                            Text(
                              complaint["status"] == "CHECKED" ? "CHECKED" : "SUBMITTED",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: complaint["status"] == "CHECKED"
                                    ? const Color(0xFF638D43) // Green
                                    : const Color(0xFFCBB92D), // Golden
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (complaint["image_path"] != null && complaint["image_path"].isNotEmpty)
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => Dialog(
                                  child: Image.file(
                                    File(complaint["image_path"]),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(complaint["image_path"]),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Close",
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryPurple,
        title: Text(
          "View Status",
          style: GoogleFonts.poppins(
            fontSize: screenWidth * 0.07,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _fetchComplaintsFromDatabase,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: complaints.isEmpty
              ? Center(
            child: Text(
              "No complaints lodged yet.",
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: kPrimaryPurple,
              ),
            ),
          )
              :ListView.builder(
            shrinkWrap: true,
            itemCount: complaints.keys.length,
            itemBuilder: (context, index) {
              String month = complaints.keys.elementAt(index);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      month,
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryPurple,
                        shadows: [
                          const Shadow(
                            color: Colors.black12,
                            offset: Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Ensure that the complaints list for the month is not null
                  ...(complaints[month]?.map((complaint) {
                    return GestureDetector(
                      onTap: () => _showComplaintDetails(complaint),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0DAE3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: kPrimaryPurple,
                            width: 1,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _formatDate(complaint["date"]?.split('T').first ?? "No Date"),
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryPurple,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              (complaint["location"] ?? "") +
                                  (complaint["floor"] != null ? ", ${complaint["floor"]} floor" : "") +
                                  (complaint["classroom"] != null ? ", ${complaint["classroom"]}" : ""),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              complaint["status"] == "CHECKED" ? "CHECKED" : "SUBMITTED",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: complaint["status"] == "CHECKED"
                                    ? const Color(0xFF638D43) // Green
                                    : const Color(0xFFCBB92D), // Golden
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }) ?? []), // Use an empty list if complaints[month] is null
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}