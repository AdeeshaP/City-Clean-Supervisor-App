import 'package:abans_city_clean_supervisor/constants/color_pallettee.dart';
import 'package:abans_city_clean_supervisor/models/track_issue.dart';
import 'package:abans_city_clean_supervisor/screens/fitst_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class IssueTrackerScreen extends StatefulWidget {
  @override
  _IssueTrackerScreenState createState() => _IssueTrackerScreenState();
}

class _IssueTrackerScreenState extends State<IssueTrackerScreen> {
  String selectedCategory = 'All';
  bool isLoading = true;
  List<TrackIssue> allIssuesTrack = [];

  final List<String> categories = ['All', 'High', 'Medium', 'Low'];

  @override
  void initState() {
    super.initState();
    _loadCollections();
  }

  // Load collections from JSON file
  Future<void> _loadCollections() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/track_issue.json');
      final Map<String, dynamic> data = json.decode(response);
      setState(() {
        // allCollections = List<Map<String, dynamic>>.from(data['collections']);
        allIssuesTrack = (data['issues'] as List<dynamic>)
            .map((json) => TrackIssue.fromJson(json))
            .toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error loading issues: $e');
      setState(() {
        allIssuesTrack = [];
        isLoading = false;
      });
    }
  }

  List<TrackIssue> get filteredIssues {
    if (selectedCategory == 'All') {
      return allIssuesTrack;
    }
    return allIssuesTrack
        .where((collection) => collection.priority.contains(selectedCategory))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Issue Tracker',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF6A1B9A),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'logout') {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                  (route) => false,
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'about',
                child: Row(
                  children: [
                    Icon(Icons.details, color: Colors.grey[600]),
                    SizedBox(width: 8),
                    Text(
                      'About Us',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'contact',
                child: Row(
                  children: [
                    Icon(Icons.phone, color: Colors.grey[600]),
                    SizedBox(width: 8),
                    Text(
                      'Contact Us',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.grey[600]),
                    SizedBox(width: 8),
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        child: SafeArea(
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFFFFC107)),
                  ),
                )
              : Column(
                  children: [
                    // Content
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFFFFC107).withOpacity(0.3),
                              Color(0xFFFFF8E1),
                              Color(0xFFFFFBE6),
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Category filters
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Priority Level',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: categories.map((category) {
                                        bool isSelected =
                                            selectedCategory == category;
                                        return Padding(
                                          padding: EdgeInsets.only(right: 4),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedCategory = category;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 24, vertical: 10),
                                              decoration: BoxDecoration(
                                                color: isSelected
                                                    ? Color(0xFFFFC107)
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: isSelected
                                                      ? Color(0xFFFFC107)
                                                      : Colors.grey.shade300,
                                                  width: 1,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.05),
                                                    blurRadius: 4,
                                                    offset: Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: Text(
                                                category,
                                                style: TextStyle(
                                                  color: isSelected
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: isSelected
                                                      ? FontWeight.w800
                                                      : FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),


                            // Issues list
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: ListView.builder(
                                  itemCount: filteredIssues.length,
                                  itemBuilder: (context, index) {
                                    final issue = filteredIssues[index];
                                    // List<String> types =
                                    //     List<String>.from(collection['types']);
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade50,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Top: Submitted by and date
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                12, 10, 12, 6),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Submitted by: ${issue.reportedBy}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  _formatDate(
                                                      issue.reportedDate),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey.shade800,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          // Image (cropped)
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Container(
                                              height: 100,
                                              width: double.infinity,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              child: Image.network(
                                                issue.imageUrl,
                                                fit: BoxFit.cover,
                                                alignment: Alignment.center,
                                              ),
                                            ),
                                          ),

                                          // Description
                                          Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Text(
                                              issue.description,
                                              style:
                                                  const TextStyle(fontSize: 14, color: Colors.black54),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),

                                          // Location with icon
                                          Padding(
                                            padding:  EdgeInsets.fromLTRB(
                                                12, 4, 12, 12),
                                            child: Row(
                                              children:  [
                                                Icon(Icons.location_on,
                                                    size: 16,
                                                    color: primaryPurpleColor),
                                                SizedBox(width: 4),
                                                Text(
                                                  issue.location,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                    // return Container(
                                    //   margin: EdgeInsets.only(bottom: 12),
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.white,
                                    //     borderRadius: BorderRadius.circular(12),
                                    //     boxShadow: [
                                    //       BoxShadow(
                                    //         color:
                                    //             Colors.black.withOpacity(0.08),
                                    //         blurRadius: 8,
                                    //         offset: Offset(0, 4),
                                    //       ),
                                    //     ],
                                    //   ),
                                    //   child: ListTile(
                                    //     contentPadding: EdgeInsets.symmetric(
                                    //         horizontal: 12, vertical: 10),
                                    //     leading: Container(
                                    //       width: 60,
                                    //       height: 80,
                                    //       decoration: BoxDecoration(
                                    //         color: Colors.amber.shade50,
                                    //         borderRadius:
                                    //             BorderRadius.circular(10),
                                    //       ),
                                    //     ),
                                    //     title: Text(
                                    //       // collection['date'],
                                    //       issue.priority,
                                    //       style: TextStyle(
                                    //         fontWeight: FontWeight.bold,
                                    //         fontSize: 16,
                                    //       ),
                                    //     ),
                                    //     subtitle: Column(
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.start,
                                    //       children: [
                                    //         SizedBox(height: 4),
                                    //         Text(
                                    //           // 'Time - ${collection['time']}',
                                    //           'Time - ${issue.reportedBy}',
                                    //           style: TextStyle(
                                    //             color: Colors.grey.shade600,
                                    //             fontSize: 14,
                                    //           ),
                                    //         ),
                                    //         SizedBox(height: 4),
                                    //         Text(
                                    //           // 'Location - ${collection['location']}',
                                    //           'Location - ${issue.location}',
                                    //           style: TextStyle(
                                    //             color: Colors.grey.shade600,
                                    //             fontSize: 14,
                                    //           ),
                                    //         ),
                                    //         SizedBox(height: 4),
                                    //         // Display multiple types with colored chips
                                    //       ],
                                    //     ),
                                    //     trailing: GestureDetector(
                                    //       onTap: () {},
                                    //       child: Icon(
                                    //         Icons.chevron_right,
                                    //         color: Colors.grey.shade400,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    return ' ${date.day}/${months[date.month - 1]}/${date.year}';
  }
}
