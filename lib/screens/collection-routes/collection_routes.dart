import 'dart:convert';
import 'package:abans_city_clean_supervisor/constants/color_pallettee.dart';
import 'package:abans_city_clean_supervisor/screens/fitst_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/collection_route.dart';

class CollectionRoutesScreen extends StatefulWidget {
  @override
  _CollectionRoutesScreenState createState() => _CollectionRoutesScreenState();
}

class _CollectionRoutesScreenState extends State<CollectionRoutesScreen> {
  List<CollectionRoute> collectionRoutes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadRoutes();
  }

  void loadRoutes() async {
    try {
      // Load the JSON file from assets
      final String jsonString =
          await rootBundle.loadString('assets/json/collection_routes.json');

      // Parse the JSON
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> issuesJson = jsonData['collection_routes'];

      setState(() {
        collectionRoutes =
            issuesJson.map((json) => CollectionRoute.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5EFB8),
      appBar: AppBar(
        backgroundColor: Color(0xFF6A1B9A),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Collection Routes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
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
              ),
            ],
          ),
        ],
      ),
      body: Container(
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
        child: Padding(
            padding: EdgeInsets.all(5.0),
            child: ListView.builder(
                itemCount: collectionRoutes.length,
                padding: EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final route = collectionRoutes[index];
                  return _buildRouteCard2(route);
                })),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        // backgroundColor: Color(0xFF8B5A96),
        backgroundColor: primaryPurpleColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildRouteCard2(CollectionRoute route) {
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
          // Header with route name and status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  route.routeName,
                  style: TextStyle(
                    color: primaryPurpleColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusBackgroundColor(route.status),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  route.status,
                  style: TextStyle(
                    color: _getStatusTextColor(route.status),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),

          // Route info
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.local_shipping,
                      size: 16,
                      color: Colors.amber,
                    ),
                    SizedBox(width: 6),
                    Text(
                      route.truckId,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: Colors.amber,
                  ),
                  SizedBox(width: 6),
                  Text(
                    route.startTime,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),

          // Location info
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 16,
                color: Colors.amber,
              ),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  route.area,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),

          // Progress bar
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: route.progress,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusBackgroundColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Color(0xFFE8F5E8);
      case 'completed':
        return Color(0xFFE3F2FD);
      case 'pending':
        return Color(0xFFFFF3E0);
      default:
        return Colors.grey[100]!;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'completed':
        return Colors.blue;
      case 'pending':
        return Colors.amber[600]!;
      default:
        return Colors.grey[100]!;
    }
  }
}
