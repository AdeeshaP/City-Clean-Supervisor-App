// import 'dart:convert';
// import 'package:abans_city_clean_supervisor/models/trucks.dart';
// import 'package:abans_city_clean_supervisor/screens/fitst_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class ActiveTrucksScreen extends StatefulWidget {
//   @override
//   _ActiveTrucksScreenState createState() => _ActiveTrucksScreenState();
// }

// class _ActiveTrucksScreenState extends State<ActiveTrucksScreen> {
//   List<ActiveTruck> activeTrucks = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     loadActiveTrucks();
//   }

//   void loadActiveTrucks() async {
//     try {
//       // Load the JSON file from assets
//       final String jsonString =
//           await rootBundle.loadString('assets/json/active_trucks.json');

//       // Parse the JSON
//       final Map<String, dynamic> jsonData = json.decode(jsonString);
//       final List<dynamic> trucksJson = jsonData['active_trucks'];

//       setState(() {
//         activeTrucks =
//             trucksJson.map((json) => ActiveTruck.fromJson(json)).toList();
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF6A1B9A),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Active Trucks',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
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
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFFFFC107).withOpacity(0.3),
//               Color(0xFFFFF8E1),
//               Color(0xFFFFFBE6),
//             ],
//           ),
//         ),
//         child: ListView.builder(
//             padding: EdgeInsets.all(12.0),
//             itemCount: activeTrucks.length,
//             itemBuilder: (context, index) {
//               final truck = activeTrucks[index];
//               return _buildTruckCard2(truck);
//             }),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         backgroundColor: const Color(0xFF8B5A96),
//         child: const Icon(Icons.my_location, color: Colors.white),
//       ),
//     );
//   }

//   Widget _buildTruckCard2(ActiveTruck truck) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       margin: EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header with truck ID and status
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 truck.truckId,
//                 style: const TextStyle(
//                   color: Color(0xFF8B5A96),
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: _getStatusBackgroundColor(truck.status),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Container(
//                       width: 8,
//                       height: 8,
//                       decoration: BoxDecoration(
//                         color: _getStatusColor(truck.status),
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                     const SizedBox(width: 6),
//                     Text(
//                       truck.status,
//                       style: TextStyle(
//                         color: _getStatusColor(truck.status),
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),

//           // Truck info grid
//           Wrap(
//             spacing: 12,
//             runSpacing: 8,
//             children: [
//               _buildInfoItem(
//                   Icons.location_on, truck.location, Color(0xFF8B5A96)),
//               _buildInfoItem(Icons.route, truck.route, Colors.green),
//               _buildInfoItem(Icons.person, truck.driver, Colors.blue),
//               _buildInfoItem(
//                   Icons.local_gas_station, truck.fuel, Colors.orange),
//             ],
//           ),
//           const SizedBox(height: 12),

//           // Metrics
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: const Color(0xFFF8F9FA),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _buildMetric(truck.collections.toString(), 'Collections'),
//                 _buildMetric(truck.distance, 'Distance'),
//                 _buildMetric(truck.duration, 'Duration'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoItem(IconData icon, String text, Color iconColor) {
//     return SizedBox(
//       width: (MediaQuery.of(context).size.width - 80) / 2,
//       child: Row(
//         children: [
//           Icon(icon, size: 16, color: iconColor),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               text,
//               style: const TextStyle(
//                 color: Colors.grey,
//                 fontSize: 14,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMetric(String value, String label) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: Color(0xFF8B5A96),
//           ),
//         ),
//         const SizedBox(height: 2),
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 12,
//             color: Colors.grey,
//           ),
//         ),
//       ],
//     );
//   }

//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'active':
//         return Colors.green;
//       case 'maintenance':
//         return Colors.orange;
//       case 'completed':
//         return Colors.blue;
//       default:
//         return Colors.red;
//     }
//   }

//   Color _getStatusBackgroundColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'active':
//         return const Color(0xFFE8F5E8);
//       case 'maintenance':
//         return const Color(0xFFFFF3E0);
//       case 'completed':
//         return const Color(0xFFE3F2FD);
//       default:
//         return const Color(0xFFFFEBEE);
//     }
//   }
// }
import 'dart:convert';
import 'package:abans_city_clean_supervisor/constants/color_pallettee.dart';
import 'package:abans_city_clean_supervisor/models/trucks.dart';
import 'package:abans_city_clean_supervisor/screens/fitst_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ActiveTrucksScreen extends StatefulWidget {
  @override
  _ActiveTrucksScreenState createState() => _ActiveTrucksScreenState();
}

class _ActiveTrucksScreenState extends State<ActiveTrucksScreen> {
  List<ActiveTruck> activeTrucks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadActiveTrucks();
  }

  void loadActiveTrucks() async {
    try {
      // Load the JSON file from assets
      final String jsonString =
          await rootBundle.loadString('assets/json/active_trucks.json');

      // Parse the JSON
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> trucksJson = jsonData['active_trucks'];

      setState(() {
        activeTrucks =
            trucksJson.map((json) => ActiveTruck.fromJson(json)).toList();
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
      appBar: AppBar(
        backgroundColor: Color(0xFF6A1B9A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Active Trucks',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
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
        child: ListView.builder(
            padding: EdgeInsets.all(12.0),
            itemCount: activeTrucks.length,
            itemBuilder: (context, index) {
              final truck = activeTrucks[index];
              return _buildTruckCard2(truck);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF8B5A96),
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
    );
  }

  Widget _buildTruckCard2(ActiveTruck truck) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with truck ID and status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                truck.truckId,
                style: const TextStyle(
                  // color: Color(0xFF8B5A96),
                  color: primaryPurpleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusBackgroundColor(truck.status),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _getStatusColor(truck.status),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      truck.status,
                      style: TextStyle(
                        color: _getStatusColor(truck.status),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Truck info with labels
          Column(
            children: [
              _buildInfoItemWithLabel(Icons.location_on, 'Location',
                  truck.location, Color(0xFF8B5A96)),
              const SizedBox(height: 8),
              _buildInfoItemWithLabel(
                  Icons.route, 'Route', truck.route, Colors.green),
              const SizedBox(height: 8),
              _buildInfoItemWithLabel(
                  Icons.person, 'Driver', truck.driver, Colors.blue),
              const SizedBox(height: 8),
              _buildInfoItemWithLabel(Icons.local_gas_station, 'Fuel Level',
                  truck.fuel, Colors.orange),
            ],
          ),
          const SizedBox(height: 12),

          // Metrics
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMetric(truck.collections.toString(), 'Collections'),
                _buildMetric(truck.distance, 'Distance'),
                _buildMetric(truck.duration, 'Duration'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // New method with text labels
  Widget _buildInfoItemWithLabel(
      IconData icon, String label, String value, Color iconColor) {
    return Row(
      children: [
        Icon(icon, size: 18, color: iconColor),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Keep the old method for backward compatibility if needed
  // Widget _buildInfoItem(IconData icon, String text, Color iconColor) {
  //   return SizedBox(
  //     width: (MediaQuery.of(context).size.width - 80) / 2,
  //     child: Row(
  //       children: [
  //         Icon(icon, size: 16, color: iconColor),
  //         const SizedBox(width: 8),
  //         Expanded(
  //           child: Text(
  //             text,
  //             style: const TextStyle(
  //               color: Colors.grey,
  //               fontSize: 14,
  //             ),
  //             overflow: TextOverflow.ellipsis,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildMetric(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF8B5A96),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'maintenance':
        return Colors.orange;
      case 'completed':
        return Colors.blue;
      default:
        return Colors.red;
    }
  }

  Color _getStatusBackgroundColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return const Color(0xFFE8F5E8);
      case 'maintenance':
        return const Color(0xFFFFF3E0);
      case 'completed':
        return const Color(0xFFE3F2FD);
      default:
        return const Color(0xFFFFEBEE);
    }
  }
}
