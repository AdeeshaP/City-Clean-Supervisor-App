import 'package:abans_city_clean_supervisor/screens/completed-issues/resolved_issues.dart';
import 'package:abans_city_clean_supervisor/screens/fitst_screen.dart';
import 'package:abans_city_clean_supervisor/screens/pending-issues/unresolved_issues.dart';
import 'package:flutter/material.dart';

import '../../constants/color_pallettee.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens.addAll([
      _buildDashboardContent(),
      _buildComplaints(),
      _buildMap(),
      _buildProfile(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
        centerTitle: true,
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
        color: Colors.white,
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF6A1B9A),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Complaints',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  String _getAppBarTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Complaints';
      case 2:
        return 'Map';
      case 3:
        return 'Profile';
      default:
        return 'Dashboard';
    }
  }

  Widget _buildDashboardContent() {
    return Container(
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
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Personal welcome section
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFF6A1B9A),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, Supervisor',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6A1B9A),
                          ),
                        ),
                        Text(
                          'Area: Colombo MC Area',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Statistics Grid - Garbage Collection themed
            Row(
              children: [
                Expanded(
                  child: _buildGarbageStatCard(
                    '15',
                    'Collection Routes',
                    Icons.local_shipping,
                    iconColorDahsbaord,
                    () {},
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildGarbageStatCard(
                    '28',
                    'Active Trucks',
                    Icons.fire_truck,
                    iconColorDahsbaord,
                    () {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildGarbageStatCard(
                    '6',
                    'Pending Issues',
                    Icons.warning,
                    iconColorDahsbaord,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PendingIssuesScreen()),
                      );
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildGarbageStatCard(
                    '42',
                    'Completed Today',
                    Icons.check_circle,
                    iconColorDahsbaord,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResolvedIssuesScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 28),

            // Section Title
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
            SizedBox(height: 16),

            // Action items - All visible without scrolling
            Column(
              children: [
                _buildGarbageActionItem(
                  icon: Icons.route,
                  title: 'Route Management',
                  subtitle: 'Plan and monitor collection routes',
                  // color: iconColorDahsbaord,
                  color: iconColorDahsbaord,
                  onTap: () => _showComingSoon(context),
                ),
                SizedBox(height: 12),
                _buildGarbageActionItem(
                  icon: Icons.report_problem,
                  title: 'Issue Tracking',
                  subtitle: 'Monitor and resolve collection issues',
                  // color: Color(0xFFFF9800),
                  color: iconColorDahsbaord,

                  onTap: () => _showComingSoon(context),
                ),
                SizedBox(height: 12),
                _buildGarbageActionItem(
                  icon: Icons.analytics,
                  title: 'Performance Reports',
                  subtitle: 'View collection statistics and trends',
                  // color: Color(0xFF2196F3),
                  color: iconColorDahsbaord,

                  onTap: () => _showComingSoon(context),
                ),
                SizedBox(height: 12),
                _buildGarbageActionItem(
                  icon: Icons.schedule,
                  title: 'Schedule Management',
                  subtitle: 'Manage collection schedules and shifts',
                  // color: Color(0xFF9C27B0),
                  color: iconColorDahsbaord,

                  onTap: () => _showComingSoon(context),
                ),
              ],
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildGarbageStatCard(String value, String label, IconData icon,
      Color iconColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: iconColor,
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGarbageActionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6A1B9A),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Coming Soon'),
          content: Text('This feature will be available in the next update.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildComplaints() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.list, size: 64, color: Colors.grey[400]),
          SizedBox(height: 16),
          Text(
            'Complaints Screen',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          SizedBox(height: 8),
          Text(
            'Coming Soon',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.map, size: 64, color: Colors.grey[400]),
          SizedBox(height: 16),
          Text(
            'Map View',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          SizedBox(height: 8),
          Text(
            'Coming Soon',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildProfile() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 64, color: Colors.grey[400]),
          SizedBox(height: 16),
          Text(
            'Profile Settings',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          SizedBox(height: 8),
          Text(
            'Coming Soon',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
