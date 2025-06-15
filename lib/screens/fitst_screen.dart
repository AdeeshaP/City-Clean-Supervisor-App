import 'package:abans_city_clean_supervisor/screens/login/login_screen.dart';
import 'package:abans_city_clean_supervisor/screens/login/register_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFC107).withOpacity(0.3),
              Color(0xFFFFF8E1),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                // Logo section
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'AES',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6A1B9A),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Abans Environmental Services',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6A1B9A),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Supervisor Portal',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 60),

                // Welcome message
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.eco,
                        size: 48,
                        color: Color(0xFF4CAF50),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Welcome Supervisor!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6A1B9A),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Manage environmental complaints and keep your community clean',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                Spacer(),

                // Action buttons
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                        icon: Icon(
                          Icons.login,
                          size: 24,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        style: OutlinedButton.styleFrom(
                          // foregroundColor: Color(0xFF6A1B9A),
                          side: BorderSide(color: Color(0xFF6A1B9A), width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                          );
                        },
                        icon: Icon(Icons.person_add,
                            size: 24, color: Colors.white),
                        label: Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                          // foregroundColor: Color(0xFF6A1B9A),
                          side: BorderSide(color: Color(0xFF6A1B9A), width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            _showInfoDialog(context, 'About Us',
                                'Abans Environmental Services helps maintain clean and healthy communities through efficient waste management and environmental complaint resolution.');
                          },
                          icon:
                              Icon(Icons.info_outline, color: Colors.grey[600]),
                          label: Text('About',
                              style: TextStyle(color: Colors.grey[600])),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            _showInfoDialog(context, 'Contact Support',
                                'Need help? Contact our support team:\n\nEmail: support@abans.lk\nPhone: +94 11 123 4567');
                          },
                          icon: Icon(Icons.support_agent,
                              color: Colors.grey[600]),
                          label: Text('Support',
                              style: TextStyle(color: Colors.grey[600])),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showInfoDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
