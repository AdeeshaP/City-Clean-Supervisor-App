import 'package:abans_city_clean_supervisor/constants/color_pallettee.dart';
import 'package:abans_city_clean_supervisor/screens/fitst_screen.dart';
import 'package:abans_city_clean_supervisor/screens/schedule-management/create_new_schedule.dart';
import 'package:flutter/material.dart';

class ScheduleManagementScreen extends StatefulWidget {
  @override
  _ScheduleManagementScreenState createState() =>
      _ScheduleManagementScreenState();
}

class _ScheduleManagementScreenState extends State<ScheduleManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6A1B9A),
        title: Text(
          'Schedule Management',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
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
              )
            ],
          ),
        ],
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(15),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stats Cards Row
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'Active Schedules',
                      count: '12',
                      color: Colors.amber,
                      icon: Icons.schedule,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      title: 'Pending Schedules',
                      count: '3',
                      color: Colors.amber,
                      icon: Icons.pending_actions,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24),

              // Quick Actions Section
              Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7B3F98),
                ),
              ),

              SizedBox(height: 16),

              // Action Cards
              _buildActionCard(
                title: 'Create New Schedule',
                subtitle: 'Add new collection schedule for routes',
                icon: Icons.add_circle_outline,
                color: iconColorDahsbaord,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateNewScheduleScreen()),
                ),
              ),

              SizedBox(height: 12),

              _buildActionCard(
                  title: 'View All Schedules',
                  subtitle: 'Browse and manage existing schedules',
                  icon: Icons.calendar_view_week,
                  color: iconColorDahsbaord,
                  onTap: () => {}),

              SizedBox(height: 12),

              _buildActionCard(
                  title: 'Schedule Templates',
                  subtitle: 'Create reusable schedule templates',
                  icon: Icons.content_copy,
                  color: iconColorDahsbaord,
                  onTap: () => {}),

              SizedBox(height: 12),

              _buildActionCard(
                  title: 'Schedule Reports',
                  subtitle: 'View schedule performance and analytics',
                  icon: Icons.bar_chart,
                  color: iconColorDahsbaord,
                  onTap: () => {}),

              SizedBox(height: 24),

              // Recent Activity
              // Text(
              //   'Recent Activity',
              //   style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //     color: Color(0xFF7B3F98),
              //   ),
              // ),

              // SizedBox(height: 16),

              // Container(
              //   height: 300,
              //   padding: EdgeInsets.all(16),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(12),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.withOpacity(0.1),
              //         spreadRadius: 1,
              //         blurRadius: 5,
              //         offset: Offset(0, 2),
              //       ),
              //     ],
              //   ),
              //   child: Column(
              //     children: [
              //       _buildActivityItem(
              //         title: 'Route A schedule updated',
              //         time: '2 hours ago',
              //         icon: Icons.edit,
              //         color: Colors.blue,
              //       ),
              //       Divider(height: 20),
              //       _buildActivityItem(
              //         title: 'New schedule created for Route F',
              //         time: '5 hours ago',
              //         icon: Icons.add,
              //         color: Colors.green,
              //       ),
              //       Divider(height: 20),
              //       _buildActivityItem(
              //         title: 'Route C schedule cancelled',
              //         time: '1 day ago',
              //         icon: Icons.cancel,
              //         color: Colors.red,
              //       ),
              //       Divider(height: 20),
              //       _buildActivityItem(
              //         title: 'Weekly template applied',
              //         time: '2 days ago',
              //         icon: Icons.schedule,
              //         color: Colors.purple,
              //       ),
              // ],
              // ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String count,
    required Color color,
    required IconData icon,
  }) {
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
            count,
            style: TextStyle(
              fontSize: 24,
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

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
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
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
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
                      color: Color(0xFF7B3F98),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

//   Widget _buildActivityItem({
//     required String title,
//     required String time,
//     required IconData icon,
//     required Color color,
//   }) {
//     return Row(
//       children: [
//         Container(
//           padding: EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(6),
//           ),
//           child: Icon(icon, color: color, size: 16),
//         ),
//         SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: Color(0xFF7B3F98),
//                 ),
//               ),
//               Text(
//                 time,
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.grey[600],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildBottomNavItem(IconData icon, String label, bool isActive) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(
//           icon,
//           color: isActive ? Color(0xFF7B3F98) : Colors.grey,
//           size: 24,
//         ),
//         SizedBox(height: 4),
//         Text(
//           label,
//           style: TextStyle(
//             color: isActive ? Color(0xFF7B3F98) : Colors.grey,
//             fontSize: 12,
//           ),
//         ),
//       ],
//     );
//   }
// }

}