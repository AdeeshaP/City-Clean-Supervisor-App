// import 'package:abans_city_clean_supervisor/constants/color_pallettee.dart';
// import 'package:abans_city_clean_supervisor/models/track_issue.dart';
// import 'package:abans_city_clean_supervisor/screens/fitst_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:convert';

// class IssueTrackerScreen extends StatefulWidget {
//   @override
//   _IssueTrackerScreenState createState() => _IssueTrackerScreenState();
// }

// class _IssueTrackerScreenState extends State<IssueTrackerScreen> {
//   String selectedCategory = 'All';
//   bool isLoading = true;
//   List<TrackIssue> allIssuesTrack = [];

//   final List<String> categories = ['All', 'High', 'Medium', 'Low'];

//   @override
//   void initState() {
//     super.initState();
//     _loadCollections();
//   }

//   // Load collections from JSON file
//   Future<void> _loadCollections() async {
//     try {
//       final String response =
//           await rootBundle.loadString('assets/json/track_issue.json');
//       final Map<String, dynamic> data = json.decode(response);
//       setState(() {
//         // allCollections = List<Map<String, dynamic>>.from(data['collections']);
//         allIssuesTrack = (data['issues'] as List<dynamic>)
//             .map((json) => TrackIssue.fromJson(json))
//             .toList();
//         isLoading = false;
//       });
//     } catch (e) {
//       print('Error loading issues: $e');
//       setState(() {
//         allIssuesTrack = [];
//         isLoading = false;
//       });
//     }
//   }

//   List<TrackIssue> get filteredIssues {
//     if (selectedCategory == 'All') {
//       return allIssuesTrack;
//     }
//     return allIssuesTrack
//         .where((collection) => collection.priority.contains(selectedCategory))
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Issue Tracker',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 22,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         centerTitle: true,
//         backgroundColor: Color(0xFF6A1B9A),
//         actions: [
//           PopupMenuButton(
//             onSelected: (value) {
//               if (value == 'logout') {
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => MainScreen()),
//                   (route) => false,
//                 );
//               }
//             },
//             itemBuilder: (context) => [
//               PopupMenuItem(
//                 value: 'about',
//                 child: Row(
//                   children: [
//                     Icon(Icons.details, color: Colors.grey[600]),
//                     SizedBox(width: 8),
//                     Text(
//                       'About Us',
//                       style: TextStyle(
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               PopupMenuItem(
//                 value: 'contact',
//                 child: Row(
//                   children: [
//                     Icon(Icons.phone, color: Colors.grey[600]),
//                     SizedBox(width: 8),
//                     Text(
//                       'Contact Us',
//                       style: TextStyle(
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               PopupMenuItem(
//                 value: 'logout',
//                 child: Row(
//                   children: [
//                     Icon(Icons.logout, color: Colors.grey[600]),
//                     SizedBox(width: 8),
//                     Text(
//                       'Logout',
//                       style: TextStyle(
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: Container(
//         child: SafeArea(
//           child: isLoading
//               ? Center(
//                   child: CircularProgressIndicator(
//                     valueColor:
//                         AlwaysStoppedAnimation<Color>(Color(0xFFFFC107)),
//                   ),
//                 )
//               : Column(
//                   children: [
//                     // Content
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Color(0xFFFFC107).withOpacity(0.3),
//                               Color(0xFFFFF8E1),
//                               Color(0xFFFFFBE6),
//                             ],
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Category filters
//                             Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 15.0, vertical: 20),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Priority Level',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   SizedBox(height: 16),
//                                   SingleChildScrollView(
//                                     scrollDirection: Axis.horizontal,
//                                     child: Row(
//                                       children: categories.map((category) {
//                                         bool isSelected =
//                                             selectedCategory == category;
//                                         return Padding(
//                                           padding: EdgeInsets.only(right: 4),
//                                           child: GestureDetector(
//                                             onTap: () {
//                                               setState(() {
//                                                 selectedCategory = category;
//                                               });
//                                             },
//                                             child: Container(
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal: 24, vertical: 10),
//                                               decoration: BoxDecoration(
//                                                 color: isSelected
//                                                     ? Color(0xFFFFC107)
//                                                     : Colors.white,
//                                                 borderRadius:
//                                                     BorderRadius.circular(8),
//                                                 border: Border.all(
//                                                   color: isSelected
//                                                       ? Color(0xFFFFC107)
//                                                       : Colors.grey.shade300,
//                                                   width: 1,
//                                                 ),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color: Colors.black
//                                                         .withOpacity(0.05),
//                                                     blurRadius: 4,
//                                                     offset: Offset(0, 2),
//                                                   ),
//                                                 ],
//                                               ),
//                                               child: Text(
//                                                 category,
//                                                 style: TextStyle(
//                                                   color: isSelected
//                                                       ? Colors.white
//                                                       : Colors.black,
//                                                   fontWeight: isSelected
//                                                       ? FontWeight.w800
//                                                       : FontWeight.w500,
//                                                   fontSize: 15,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                       }).toList(),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),

//                             // Issues list
//                             Expanded(
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 12.0),
//                                 child: ListView.builder(
//                                   itemCount: filteredIssues.length,
//                                   itemBuilder: (context, index) {
//                                     final issue = filteredIssues[index];
//                                     // List<String> types =
//                                     //     List<String>.from(collection['types']);
//                                     return Container(
//                                       margin: const EdgeInsets.symmetric(
//                                           vertical: 8),
//                                       decoration: BoxDecoration(
//                                         color: Colors.grey.shade50,
//                                         borderRadius: BorderRadius.circular(12),
//                                         boxShadow: const [
//                                           BoxShadow(
//                                             color: Colors.black12,
//                                             blurRadius: 4,
//                                             offset: Offset(0, 2),
//                                           )
//                                         ],
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           // Top: Submitted by and date
//                                           Padding(
//                                             padding: const EdgeInsets.fromLTRB(
//                                                 12, 10, 12, 6),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   "Submitted by: ${issue.reportedBy}",
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.w500,
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   _formatDate(
//                                                       issue.reportedDate),
//                                                   style: TextStyle(
//                                                     fontSize: 12,
//                                                     color: Colors.grey.shade800,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           SizedBox(height: 10),
//                                           // Image (cropped)
//                                           ClipRRect(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                             child: Container(
//                                               height: 100,
//                                               width: double.infinity,
//                                               margin:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 12),
//                                               child: Image.network(
//                                                 issue.imageUrl,
//                                                 fit: BoxFit.cover,
//                                                 alignment: Alignment.center,
//                                               ),
//                                             ),
//                                           ),

//                                           // Description
//                                           Padding(
//                                             padding: const EdgeInsets.all(12),
//                                             child: Text(
//                                               issue.description,
//                                               style:
//                                                   const TextStyle(fontSize: 14, color: Colors.black54),
//                                               maxLines: 3,
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                           ),

//                                           // Location with icon
//                                           Padding(
//                                             padding:  EdgeInsets.fromLTRB(
//                                                 12, 4, 12, 12),
//                                             child: Row(
//                                               children:  [
//                                                 Icon(Icons.location_on,
//                                                     size: 16,
//                                                     color: primaryPurpleColor),
//                                                 SizedBox(width: 4),
//                                                 Text(
//                                                   issue.location,
//                                                   style: TextStyle(
//                                                     fontSize: 13,
//                                                     fontWeight: FontWeight.w600,
//                                                     color: Colors.black87,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                     // return Container(
//                                     //   margin: EdgeInsets.only(bottom: 12),
//                                     //   decoration: BoxDecoration(
//                                     //     color: Colors.white,
//                                     //     borderRadius: BorderRadius.circular(12),
//                                     //     boxShadow: [
//                                     //       BoxShadow(
//                                     //         color:
//                                     //             Colors.black.withOpacity(0.08),
//                                     //         blurRadius: 8,
//                                     //         offset: Offset(0, 4),
//                                     //       ),
//                                     //     ],
//                                     //   ),
//                                     //   child: ListTile(
//                                     //     contentPadding: EdgeInsets.symmetric(
//                                     //         horizontal: 12, vertical: 10),
//                                     //     leading: Container(
//                                     //       width: 60,
//                                     //       height: 80,
//                                     //       decoration: BoxDecoration(
//                                     //         color: Colors.amber.shade50,
//                                     //         borderRadius:
//                                     //             BorderRadius.circular(10),
//                                     //       ),
//                                     //     ),
//                                     //     title: Text(
//                                     //       // collection['date'],
//                                     //       issue.priority,
//                                     //       style: TextStyle(
//                                     //         fontWeight: FontWeight.bold,
//                                     //         fontSize: 16,
//                                     //       ),
//                                     //     ),
//                                     //     subtitle: Column(
//                                     //       crossAxisAlignment:
//                                     //           CrossAxisAlignment.start,
//                                     //       children: [
//                                     //         SizedBox(height: 4),
//                                     //         Text(
//                                     //           // 'Time - ${collection['time']}',
//                                     //           'Time - ${issue.reportedBy}',
//                                     //           style: TextStyle(
//                                     //             color: Colors.grey.shade600,
//                                     //             fontSize: 14,
//                                     //           ),
//                                     //         ),
//                                     //         SizedBox(height: 4),
//                                     //         Text(
//                                     //           // 'Location - ${collection['location']}',
//                                     //           'Location - ${issue.location}',
//                                     //           style: TextStyle(
//                                     //             color: Colors.grey.shade600,
//                                     //             fontSize: 14,
//                                     //           ),
//                                     //         ),
//                                     //         SizedBox(height: 4),
//                                     //         // Display multiple types with colored chips
//                                     //       ],
//                                     //     ),
//                                     //     trailing: GestureDetector(
//                                     //       onTap: () {},
//                                     //       child: Icon(
//                                     //         Icons.chevron_right,
//                                     //         color: Colors.grey.shade400,
//                                     //       ),
//                                     //     ),
//                                     //   ),
//                                     // );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }

//   String _formatDate(DateTime date) {
//     final months = [
//       'Jan',
//       'Feb',
//       'Mar',
//       'Apr',
//       'May',
//       'Jun',
//       'Jul',
//       'Aug',
//       'Sep',
//       'Oct',
//       'Nov',
//       'Dec'
//     ];

//     return ' ${date.day}/${months[date.month - 1]}/${date.year}';
//   }
// }

import 'package:abans_city_clean_supervisor/constants/color_pallettee.dart';
import 'package:abans_city_clean_supervisor/models/issue_data.dart';
import 'package:abans_city_clean_supervisor/screens/fitst_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IssueTrackerScreen extends StatefulWidget {
  @override
  _IssueTrackerScreenState createState() => _IssueTrackerScreenState();
}

class _IssueTrackerScreenState extends State<IssueTrackerScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  IssueData? _selectedIssue;

  List<IssueData> issues = [];
  List<String> supervisors = [
    'John Silva',
    'Priya Perera',
    'Kamal Fernando',
    'Nimal Jayasinghe',
    'Prasad Wickrama',
    'Chaminda Perera'
  ];

  String _selectedFilter = 'All';
  List<String> _filterOptions = [
    'All',
    'Pending',
    'In Progress',
    'Resolved',
    'Closed'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadIssues();
    _setupMapData();
  }

  void loadIssues() {
    // Mock data - in real app, load from API
    issues = [
      IssueData(
        id: 'ISS-001',
        title: 'Garbage Overflow at Main Street',
        description:
            'Large amount of garbage overflowing from bins near the main market area',
        location: 'Main Street, Kollupitiya',
        reportedBy: 'Citizen User 1',
        reportedAt: DateTime.now().subtract(Duration(hours: 2)),
        status: 'Pending',
        priority: 'High',
        category: 'Overflow',
        assignedTo: 'John Silva',
        coordinates: LatLng(6.9271, 79.8612),
        imageUrl: 'https://example.com/image1.jpg',
        estimatedResolution: '2 hours',
        zone: 'North Zone',
      ),
      IssueData(
        id: 'ISS-002',
        title: 'Illegal Dumping in Park',
        description:
            'Construction waste dumped illegally in the public park area',
        location: 'Viharamahadevi Park, Cinnamon Gardens',
        reportedBy: 'Citizen User 2',
        reportedAt: DateTime.now().subtract(Duration(hours: 5)),
        status: 'In Progress',
        priority: 'Medium',
        category: 'Illegal Dumping',
        assignedTo: 'Priya Perera',
        coordinates: LatLng(6.9147, 79.8560),
        imageUrl: 'https://example.com/image2.jpg',
        estimatedResolution: '4 hours',
        zone: 'Central Zone',
      ),
      IssueData(
        id: 'ISS-003',
        title: 'Missed Collection',
        description: 'Scheduled collection missed for residential area',
        location: 'Galle Road, Wellawatta',
        reportedBy: 'Citizen User 3',
        reportedAt: DateTime.now().subtract(Duration(hours: 8)),
        status: 'Resolved',
        priority: 'Low',
        category: 'Missed Collection',
        assignedTo: 'Kamal Fernando',
        coordinates: LatLng(6.8956, 79.8506),
        imageUrl: 'https://example.com/image3.jpg',
        estimatedResolution: '1 hour',
        zone: 'South Zone',
      ),
      IssueData(
        id: 'ISS-004',
        title: 'Damaged Bin',
        description: 'Public waste bin damaged and needs replacement',
        location: 'Bus Station, Fort',
        reportedBy: 'Citizen User 4',
        reportedAt: DateTime.now().subtract(Duration(hours: 12)),
        status: 'Closed',
        priority: 'Medium',
        category: 'Infrastructure',
        assignedTo: 'Nimal Jayasinghe',
        coordinates: LatLng(6.9344, 79.8428),
        imageUrl: 'https://example.com/image4.jpg',
        estimatedResolution: '6 hours',
        zone: 'Central Zone',
      ),
    ];
  }

  void _setupMapData() {
    _markers.clear();

    List<IssueData> issuesToShow =
        _selectedIssue != null ? [_selectedIssue!] : _getFilteredIssues();

    for (int i = 0; i < issuesToShow.length; i++) {
      IssueData issue = issuesToShow[i];

      _markers.add(
        Marker(
          markerId: MarkerId(issue.id),
          position: issue.coordinates,
          infoWindow: InfoWindow(
            title: issue.title,
            snippet: '${issue.status} - ${issue.priority}',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            _getIssueStatusColor(issue.status),
          ),
        ),
      );
    }
  }

  List<IssueData> _getFilteredIssues() {
    if (_selectedFilter == 'All') {
      return issues;
    }
    return issues.where((issue) => issue.status == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Issue Tracker',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
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
                    Text('About Us', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'contact',
                child: Row(
                  children: [
                    Icon(Icons.phone, color: Colors.grey[600]),
                    SizedBox(width: 8),
                    Text('Contact Us', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.grey[600]),
                    SizedBox(width: 8),
                    Text('Logout', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Issues List'),
            Tab(text: 'Map View'),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFC107).withOpacity(0.3),
                Color(0xFFFFF8E1),
                Color(0xFFFFFBE6),
                Color(0xFFFFC107).withOpacity(0.3),
              ],
            ),
          ),
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildIssuesListView(),
              _buildMapView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIssuesListView() {
    return Column(
      children: [
        // Filter Section
        Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.filter_list, color: primaryPurpleColor),
              SizedBox(width: 8),
              Text(
                'Filter by Status:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryPurpleColor,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: DropdownButton<String>(
                  value: _selectedFilter,
                  isExpanded: true,
                  underline: Container(
                    height: 1,
                    color: primaryPurpleColor,
                  ),
                  items: _filterOptions.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFilter = newValue!;
                      _setupMapData();
                    });
                  },
                ),
              ),
            ],
          ),
        ),

        // Issues List
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: _getFilteredIssues().length,
            itemBuilder: (context, index) {
              final issue = _getFilteredIssues()[index];
              return _buildIssueCard(issue);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildIssueCard(IssueData issue) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      issue.title,
                      style: TextStyle(
                        color: primaryPurpleColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      issue.id,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getStatusColor(issue.status).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  issue.status,
                  style: TextStyle(
                    color: _getStatusColor(issue.status),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),

          // Priority and Category
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _getPriorityColor(issue.priority).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  issue.priority,
                  style: TextStyle(
                    color: _getPriorityColor(issue.priority),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  issue.category,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),

          // Issue details
          Column(
            children: [
              _buildIssueDetailRow(
                  Icons.location_on, 'Location', issue.location),
              SizedBox(height: 8),
              _buildIssueDetailRow(
                  Icons.person, 'Reported By', issue.reportedBy),
              SizedBox(height: 8),
              _buildIssueDetailRow(Icons.access_time, 'Reported',
                  _formatDateTime(issue.reportedAt)),
              SizedBox(height: 8),
              _buildIssueDetailRow(
                  Icons.person_outline, 'Assigned To', issue.assignedTo),
            ],
          ),
          SizedBox(height: 12),

          // Description
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              issue.description,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
          SizedBox(height: 12),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActionButton(
                icon: Icons.edit,
                label: 'Update Status',
                color: primaryGreen,
                onPressed: () => _showUpdateStatusDialog(issue),
              ),
              _buildActionButton(
                icon: Icons.visibility,
                label: 'View Details',
                color: primaryGreen,
                onPressed: () => _showIssueDetailsDialog(issue),
              ),
              _buildActionButton(
                icon: Icons.location_on,
                label: 'View on Map',
                color: primaryGreen,
                onPressed: () => _showIssueOnMap(issue),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIssueDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: iconColorDahsbaord2),
        SizedBox(width: 12),
        Text(
          '$label: ',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, size: 14, color: Colors.white),
          label: Text(
            label,
            style: TextStyle(fontSize: 11, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            // backgroundColor: color,
            padding: EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMapView() {
    return Container(
      child: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(6.9271, 79.8612), // Colombo coordinates
          zoom: 12,
        ),
        markers: _markers,
        mapType: MapType.normal,
      ),
    );
  }

  // Dialog methods
  void _showUpdateStatusDialog(IssueData issue) {
    showDialog(
      context: context,
      builder: (context) => UpdateStatusDialog(
        issue: issue,
        onStatusUpdated: (newStatus) {
          setState(() {
            issue.status = newStatus;
            _setupMapData();
          });
        },
      ),
    );
  }

  void _showIssueDetailsDialog(IssueData issue) {
    showDialog(
      context: context,
      builder: (context) => IssueDetailsDialog(issue: issue),
    );
  }

  void _showIssueOnMap(IssueData issue) {
    setState(() {
      _selectedIssue = issue;
      _setupMapData();
    });
    _tabController.animateTo(1);

    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(issue.coordinates, 15),
      );
    }
  }

  // Helper methods
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.amber;
      case 'in progress':
        return Colors.blue;
      case 'resolved':
        return Colors.green;
      case 'closed':
        return Colors.grey;
      default:
        return Colors.red;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  double _getIssueStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return BitmapDescriptor.hueOrange;
      case 'in progress':
        return BitmapDescriptor.hueBlue;
      case 'resolved':
        return BitmapDescriptor.hueGreen;
      case 'closed':
        return BitmapDescriptor.hueViolet;
      default:
        return BitmapDescriptor.hueRed;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inMinutes}m ago';
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

// Update Status Dialog
class UpdateStatusDialog extends StatefulWidget {
  final IssueData issue;
  final Function(String) onStatusUpdated;

  UpdateStatusDialog({
    required this.issue,
    required this.onStatusUpdated,
  });

  @override
  _UpdateStatusDialogState createState() => _UpdateStatusDialogState();
}

class _UpdateStatusDialogState extends State<UpdateStatusDialog> {
  String? _selectedStatus;
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.issue.status;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        'Update Issue Status',
        style: TextStyle(
          color: primaryPurpleColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Issue: ${widget.issue.title}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Current Status: ${widget.issue.status}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _selectedStatus,
            decoration: InputDecoration(
              labelText: 'New Status',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
            items:
                ['Pending', 'In Progress', 'Resolved', 'Closed'].map((status) {
              return DropdownMenuItem(
                value: status,
                child: Text(status),
              );
            }).toList(),
            onChanged: (value) => setState(() => _selectedStatus = value),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _notesController,
            decoration: InputDecoration(
              labelText: 'Notes (Optional)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_selectedStatus != null) {
              widget.onStatusUpdated(_selectedStatus!);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Status updated successfully')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Update',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

// Issue Details Dialog
class IssueDetailsDialog extends StatelessWidget {
  final IssueData issue;

  IssueDetailsDialog({required this.issue});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: BoxConstraints(
          maxWidth: 500,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: primaryPurpleColor.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: primaryPurpleColor,
                    size: 28,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Issue Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryPurpleColor,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: primaryPurpleColor),
                  ),
                ],
              ),
            ),

            // Content
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Issue ID', issue.id),
                      _buildDetailRow('Title', issue.title),
                      _buildDetailRow('Status', issue.status),
                      _buildDetailRow('Priority', issue.priority),
                      _buildDetailRow('Category', issue.category),
                      _buildDetailRow('Location', issue.location),
                      _buildDetailRow('Zone', issue.zone),
                      _buildDetailRow('Reported By', issue.reportedBy),
                      _buildDetailRow(
                          'Reported At', issue.reportedAt.toString()),
                      _buildDetailRow('Assigned To', issue.assignedTo),
                      _buildDetailRow(
                          'Estimated Resolution', issue.estimatedResolution),
                      SizedBox(height: 16),
                      Text(
                        'Description:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          issue.description,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
