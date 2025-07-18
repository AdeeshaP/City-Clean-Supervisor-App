import 'package:abans_city_clean_supervisor/constants/color_pallettee.dart';
import 'package:abans_city_clean_supervisor/screens/fitst_screen.dart';
import 'package:flutter/material.dart';

class ScheduleReportsScreen extends StatefulWidget {
  @override
  _ScheduleReportsScreenState createState() => _ScheduleReportsScreenState();
}

class _ScheduleReportsScreenState extends State<ScheduleReportsScreen> {
  String selectedTimeFrame = 'This Week';
  final List<String> timeFrames = [
    'Today',
    'This Week',
    'This Month',
    'Last Month',
    'Custom'
  ];

  // Sample data
  final Map<String, int> scheduleStats = {
    'totalSchedules': 45,
    'activeSchedules': 32,
    'completedSchedules': 28,
    'pendingSchedules': 8,
    'cancelledSchedules': 5,
    'onTimeCompletion': 85,
    'delayedSchedules': 7,
    'averageDelay': 25, // in minutes
  };

  final List<Map<String, dynamic>> recentActivity = [
    {
      'type': 'completed',
      'schedule': 'SCH001 - Route A Collection',
      'time': '2 hours ago',
      'status': 'On Time',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'type': 'delayed',
      'schedule': 'SCH003 - Route C Collection',
      'time': '4 hours ago',
      'status': 'Delayed by 30 min',
      'icon': Icons.schedule,
      'color': Colors.orange,
    },
    {
      'type': 'started',
      'schedule': 'SCH005 - Route E Collection',
      'time': '6 hours ago',
      'status': 'Started',
      'icon': Icons.play_circle,
      'color': Colors.blue,
    },
    {
      'type': 'cancelled',
      'schedule': 'SCH007 - Route B Collection',
      'time': '1 day ago',
      'status': 'Cancelled',
      'icon': Icons.cancel,
      'color': Colors.red,
    },
  ];

  final List<Map<String, dynamic>> performanceData = [
    {
      'route': 'Route A',
      'completion': 95,
      'avgTime': '3.2h',
      'efficiency': 'High'
    },
    {
      'route': 'Route B',
      'completion': 87,
      'avgTime': '4.1h',
      'efficiency': 'Medium'
    },
    {
      'route': 'Route C',
      'completion': 92,
      'avgTime': '3.8h',
      'efficiency': 'High'
    },
    {
      'route': 'Route D',
      'completion': 78,
      'avgTime': '4.5h',
      'efficiency': 'Low'
    },
    {
      'route': 'Route E',
      'completion': 89,
      'avgTime': '3.9h',
      'efficiency': 'Medium'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Schedule Reports',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
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
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Time Frame Selector
                // Container(
                //   padding: EdgeInsets.all(16),
                //   child: SingleChildScrollView(
                //     scrollDirection: Axis.horizontal,
                //     child: Row(
                //       children: timeFrames.map((timeFrame) {
                //         bool isSelected = selectedTimeFrame == timeFrame;
                //         return GestureDetector(
                //           onTap: () {
                //             setState(() {
                //               selectedTimeFrame = timeFrame;
                //             });
                //           },
                //           child: Container(
                //             margin: EdgeInsets.only(right: 8),
                //             padding: EdgeInsets.symmetric(
                //                 horizontal: 16, vertical: 8),
                //             decoration: BoxDecoration(
                //               color: isSelected
                //                   ? primaryPurpleColor
                //                   : Colors.white,
                //               borderRadius: BorderRadius.circular(20),
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: Colors.grey.withOpacity(0.1),
                //                   spreadRadius: 1,
                //                   blurRadius: 3,
                //                   offset: Offset(0, 1),
                //                 ),
                //               ],
                //             ),
                //             child: Text(
                //               timeFrame,
                //               style: TextStyle(
                //                 color: isSelected
                //                     ? Colors.white
                //                     : Color(0xFF7B3F98),
                //                 fontWeight: FontWeight.w600,
                //               ),
                //             ),
                //           ),
                //         );
                //       }).toList(),
                //     ),
                //   ),
                // ),

                // Statistics Cards
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Overview Statistics',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7B3F98),
                        ),
                      ),
                      SizedBox(height: 16),

                      // First Row of Stats
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              'Total Schedules',
                              scheduleStats['totalSchedules'].toString(),
                              Icons.calendar_today,
                              iconColorDahsbaord2,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              'Active',
                              scheduleStats['activeSchedules'].toString(),
                              Icons.play_circle,
                              iconColorDahsbaord2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),

                      // Second Row of Stats
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              'Completed',
                              scheduleStats['completedSchedules'].toString(),
                              Icons.check_circle,
                              iconColorDahsbaord2,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              'Pending',
                              scheduleStats['pendingSchedules'].toString(),
                              Icons.pending,
                              iconColorDahsbaord2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),

                      // Third Row of Stats
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              'On Time %',
                              '${scheduleStats['onTimeCompletion']}%',
                              Icons.schedule,
                              iconColorDahsbaord2,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              'Avg Delay',
                              '${scheduleStats['averageDelay']} min',
                              Icons.timer,
                              iconColorDahsbaord2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                // Performance Chart Section
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Route Performance',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7B3F98),
                            ),
                          ),
                          Icon(Icons.bar_chart, color: primaryPurpleColor),
                        ],
                      ),
                      SizedBox(height: 16),

                      // Performance List
                      Column(
                        children: performanceData.map((data) {
                          return _buildPerformanceItem(data);
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                // Recent Activity Section
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Activity',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7B3F98),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // View all activity
                            },
                            child: Text(
                              'View All',
                              style: TextStyle(color: primaryPurpleColor),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      // Activity List
                      Column(
                        children: recentActivity.map((activity) {
                          return _buildActivityItem(activity);
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                // Quick Actions
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quick Actions',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7B3F98),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildQuickActionCard(
                              'Generate Report',
                              Icons.description,
                              Colors.blue,
                              () => _generateReport(),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _buildQuickActionCard(
                              'Export Data',
                              Icons.file_download,
                              Colors.green,
                              () => _exportData(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildQuickActionCard(
                              'Send Summary',
                              Icons.email,
                              Colors.orange,
                              () => _sendSummary(),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _buildQuickActionCard(
                              'Schedule Analysis',
                              Icons.analytics,
                              Colors.purple,
                              () => _showAnalysis(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF7B3F98),
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceItem(Map<String, dynamic> data) {
    Color efficiencyColor = data['efficiency'] == 'High'
        ? Colors.green
        : data['efficiency'] == 'Medium'
            ? Colors.orange
            : Colors.red;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              data['route'],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF7B3F98),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${data['completion']}%',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: data['completion'] >= 90
                        ? Colors.green
                        : data['completion'] >= 80
                            ? Colors.orange
                            : Colors.red,
                  ),
                ),
                Text(
                  'Completion',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  data['avgTime'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF7B3F98),
                  ),
                ),
                Text(
                  'Avg Time',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: efficiencyColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                data['efficiency'],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: efficiencyColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: activity['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              activity['icon'],
              color: activity['color'],
              size: 20,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['schedule'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF7B3F98),
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      activity['status'],
                      style: TextStyle(
                        fontSize: 12,
                        color: activity['color'],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      ' • ${activity['time']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(
      String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF7B3F98),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _generateReport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Change radius here
        ),
        title: Text('Generate Report'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Select report type:'),
            SizedBox(height: 16),
            ListTile(
              title: Text('Weekly Summary'),
              leading: Radio(
                value: 'weekly',
                groupValue: 'weekly',
                onChanged: (value) {},
              ),
            ),
            ListTile(
              title: Text('Monthly Overview'),
              leading: Radio(
                value: 'monthly',
                groupValue: 'weekly',
                onChanged: (value) {},
              ),
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
              Navigator.pop(context);
              _showSuccessMessage('Report generated successfully!');
            },
            child: Text('Generate'),
          ),
        ],
      ),
    );
  }

  void _exportData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Change radius here
        ),
        title: Text('Export Data'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Select export format:'),
            SizedBox(height: 16),
            ListTile(
              title: Text('CSV'),
              leading: Radio(
                value: 'csv',
                groupValue: 'csv',
                onChanged: (value) {},
              ),
            ),
            ListTile(
              title: Text('Excel'),
              leading: Radio(
                value: 'excel',
                groupValue: 'csv',
                onChanged: (value) {},
              ),
            ),
            ListTile(
              title: Text('PDF'),
              leading: Radio(
                value: 'pdf',
                groupValue: 'csv',
                onChanged: (value) {},
              ),
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
              Navigator.pop(context);
              _showSuccessMessage('Data exported successfully!');
            },
            child: Text('Export'),
          ),
        ],
      ),
    );
  }

  void _sendSummary() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Change radius here
        ),
        title: Text('Send Summary'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(),
              ),
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
              Navigator.pop(context);
              _showSuccessMessage('Summary sent successfully!');
            },
            child: Text('Send'),
          ),
        ],
      ),
    );
  }

  void _showAnalysis() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Change radius here
        ),
        title: Text('Schedule Analysis'),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Analysis Summary:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              Text('• Average completion rate: 88%'),
              Text('• Peak activity hours: 8 AM - 12 PM'),
              Text('• Most efficient route: Route A'),
              Text('• Improvement areas: Route D timing'),
              SizedBox(height: 16),
              Text('Recommendations:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('• Schedule Route D earlier in the day'),
              Text('• Allocate more resources to peak hours'),
              Text('• Consider Route A as template for others'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
