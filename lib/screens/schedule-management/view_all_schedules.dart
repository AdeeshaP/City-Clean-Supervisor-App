import 'package:abans_city_clean_supervisor/constants/color_pallettee.dart';
import 'package:abans_city_clean_supervisor/screens/fitst_screen.dart';
import 'package:flutter/material.dart';

class ViewAllSchedulesScreen extends StatefulWidget {
  @override
  _ViewAllSchedulesScreenState createState() => _ViewAllSchedulesScreenState();
}

class _ViewAllSchedulesScreenState extends State<ViewAllSchedulesScreen> {
  String selectedFilter = 'All';
  final List<String> filters = [
    'All',
    'Active',
    'Pending',
    'Completed',
    'Cancelled'
  ];

  // Sample schedule data
  final List<Map<String, dynamic>> schedules = [
    {
      'id': 'SCH001',
      'route': 'Route A - North Zone',
      'truck': 'Truck #T-001',
      'driver': 'Ravi Silva',
      'days': ['Monday', 'Wednesday', 'Friday'],
      'startTime': '08:00 AM',
      'endTime': '12:00 PM',
      'status': 'Active',
      'type': 'Daily Collection',
      'created': '2024-01-15',
    },
    {
      'id': 'SCH002',
      'route': 'Route B - Central Zone',
      'truck': 'Truck #T-003',
      'driver': 'Sunil Perera',
      'days': ['Tuesday', 'Thursday', 'Saturday'],
      'startTime': '09:00 AM',
      'endTime': '01:00 PM',
      'status': 'Active',
      'type': 'Weekly Collection',
      'created': '2024-01-14',
    },
    {
      'id': 'SCH003',
      'route': 'Route C - South Zone',
      'truck': 'Truck #T-005',
      'driver': 'Kamal Fernando',
      'days': ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
      'startTime': '07:30 AM',
      'endTime': '11:30 AM',
      'status': 'Pending',
      'type': 'Daily Collection',
      'created': '2024-01-13',
    },
    {
      'id': 'SCH004',
      'route': 'Route D - East Zone',
      'truck': 'Truck #T-007',
      'driver': 'Nimal Jayasinghe',
      'days': ['Sunday'],
      'startTime': '08:00 AM',
      'endTime': '02:00 PM',
      'status': 'Completed',
      'type': 'Monthly Collection',
      'created': '2024-01-10',
    },
    {
      'id': 'SCH005',
      'route': 'Route E - West Zone',
      'truck': 'Truck #T-009',
      'driver': 'Chamara Perera',
      'days': ['Saturday'],
      'startTime': '10:00 AM',
      'endTime': '04:00 PM',
      'status': 'Cancelled',
      'type': 'Bi-Weekly Collection',
      'created': '2024-01-08',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredSchedules = selectedFilter == 'All'
        ? schedules
        : schedules
            .where((schedule) => schedule['status'] == selectedFilter)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Schedules',
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
          child: Column(
            children: [
              // Filter Section
              Container(
                padding: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: filters.map((filter) {
                      bool isSelected = selectedFilter == filter;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = filter;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          // padding:
                          //     EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            // color: isSelected ? primaryPurpleColor : Colors.white,
                            color: isSelected ? Color(0xFFFFC107) : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey.withOpacity(0.1),
                            //     spreadRadius: 1,
                            //     blurRadius: 3,
                            //     offset: Offset(0, 1),
                            //   ),
                            // ],
        
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 3,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Text(
                            filter,
                            style: TextStyle(
                              // color:
                              //     isSelected ? Colors.white : Color(0xFF7B3F98),
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
        
              // Schedule Count
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${filteredSchedules.length} Schedules',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF7B3F98),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.sort, color: Color(0xFF7B3F98)),
                      onPressed: () {
                        // Implement sort functionality
                      },
                    ),
                  ],
                ),
              ),
        
              // Schedules List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredSchedules.length,
                  itemBuilder: (context, index) {
                    final schedule = filteredSchedules[index];
                    return _buildScheduleCard(schedule);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleCard(Map<String, dynamic> schedule) {
    Color statusColor = _getStatusColor(schedule['status']);
    // IconData statusIcon = _getStatusIcon(schedule['status']);

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
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
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primaryPurpleColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.schedule,
                      color: primaryPurpleColor,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        schedule['id'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7B3F98),
                        ),
                      ),
                      Text(
                        schedule['type'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon(statusIcon, color: statusColor, size: 14),
                    // SizedBox(width: 4),
                    Text(
                      schedule['status'],
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          // Schedule Details
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  Icons.route,
                  'Route',
                  schedule['route'],
                ),
              ),
            ],
          ),

          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  Icons.local_shipping,
                  'Truck',
                  schedule['truck'],
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  Icons.person,
                  'Driver',
                  schedule['driver'],
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  Icons.access_time,
                  'Time',
                  '${schedule['startTime']} - ${schedule['endTime']}',
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          // Days
          _buildDetailItem(
            Icons.calendar_today,
            'Days',
            schedule['days'].join(', '),
          ),

          SizedBox(height: 5),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  _showScheduleDetails(schedule);
                },
                icon: Icon(Icons.visibility, size: 16, color: Colors.green),
                label: Text('View'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.green,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  _editSchedule(schedule);
                },
                icon: Icon(Icons.edit, size: 16, color: Colors.blue),
                label: Text('Edit'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  _deleteSchedule(schedule);
                },
                icon: Icon(
                  Icons.delete,
                  size: 16,
                  color: Colors.red,
                ),
                label: Text('Delete'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[500]),
        SizedBox(width: 4),
        Text(
          '$label : ',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF7B3F98),
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'Pending':
        return Colors.amber;
      case 'Completed':
        return Colors.blue;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // IconData _getStatusIcon(String status) {
  //   switch (status) {
  //     case 'Active':
  //       return Icons.check_circle;
  //     case 'Pending':
  //       return Icons.pending;
  //     case 'Completed':
  //       return Icons.done_all;
  //     case 'Cancelled':
  //       return Icons.cancel;
  //     default:
  //       return Icons.info;
  //   }
  // }

  void _showScheduleDetails(Map<String, dynamic> schedule) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Schedule Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDialogDetailItem('Schedule ID', schedule['id']),
              _buildDialogDetailItem('Route', schedule['route']),
              _buildDialogDetailItem('Truck', schedule['truck']),
              _buildDialogDetailItem('Driver', schedule['driver']),
              _buildDialogDetailItem('Type', schedule['type']),
              _buildDialogDetailItem('Status', schedule['status']),
              _buildDialogDetailItem('Days', schedule['days'].join(', ')),
              _buildDialogDetailItem('Start Time', schedule['startTime']),
              _buildDialogDetailItem('End Time', schedule['endTime']),
              _buildDialogDetailItem('Created', schedule['created']),
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

  Widget _buildDialogDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF7B3F98),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  void _editSchedule(Map<String, dynamic> schedule) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Edit functionality to be implemented'),
        backgroundColor: Colors.black,
      ),
    );
  }

  void _deleteSchedule(Map<String, dynamic> schedule) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Schedule'),
        content: Text('Are you sure you want to delete this schedule?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Schedule deleted successfully'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
