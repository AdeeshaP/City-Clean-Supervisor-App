import 'package:abans_city_clean_supervisor/screens/fitst_screen.dart';
import 'package:flutter/material.dart';

class ActiveTrucksScreen extends StatefulWidget {
  @override
  _ActiveTrucksScreenState createState() => _ActiveTrucksScreenState();
}

class _ActiveTrucksScreenState extends State<ActiveTrucksScreen> {
  int selectedTabIndex = 0;

  final List<String> tabs = ['All (28)', 'Active (24)', 'Maintenance (4)'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EFB8),
      appBar: AppBar(
        backgroundColor: Color(0xFF6A1B9A),
        elevation: 2,
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
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Filter tabs
              // Container(
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(8),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black.withOpacity(0.1),
              //         blurRadius: 4,
              //         offset: const Offset(0, 2),
              //       ),
              //     ],
              //   ),
              //   padding: const EdgeInsets.all(4),
              //   child: Row(
              //     children: tabs.asMap().entries.map((entry) {
              //       int index = entry.key;
              //       String tab = entry.value;
              //       bool isSelected = selectedTabIndex == index;

              //       return Expanded(
              //         child: GestureDetector(
              //           onTap: () {
              //             setState(() {
              //               selectedTabIndex = index;
              //             });
              //           },
              //           child: Container(
              //             padding: const EdgeInsets.symmetric(
              //                 vertical: 8, horizontal: 12),
              //             decoration: BoxDecoration(
              //               color: isSelected
              //                   ? const Color(0xFF8B5A96)
              //                   : Colors.transparent,
              //               borderRadius: BorderRadius.circular(6),
              //             ),
              //             child: Text(
              //               tab,
              //               textAlign: TextAlign.center,
              //               style: TextStyle(
              //                 color:
              //                     isSelected ? Colors.white : Colors.grey[600],
              //                 fontSize: 14,
              //                 fontWeight: isSelected
              //                     ? FontWeight.w500
              //                     : FontWeight.normal,
              //               ),
              //             ),
              //           ),
              //         ),
              //       );
              //     }).toList(),
              //   ),
              // ),
              // const SizedBox(height: 16),

              // Trucks list
              Expanded(
                child: ListView(
                  children: [
                    _buildTruckCard(
                      truckId: 'Truck #T-001',
                      location: 'Kollupitiya',
                      route: 'Route A',
                      driver: 'Ravi Silva',
                      fuel: '85%',
                      status: 'Active',
                      collections: 12,
                      distance: '4.2km',
                      duration: '2.5h',
                    ),
                    const SizedBox(height: 12),
                    _buildTruckCard(
                      truckId: 'Truck #T-003',
                      location: 'Fort Area',
                      route: 'Route B',
                      driver: 'Sunil Perera',
                      fuel: '72%',
                      status: 'Active',
                      collections: 8,
                      distance: '3.1km',
                      duration: '1.8h',
                    ),
                    const SizedBox(height: 12),
                    _buildTruckCard(
                      truckId: 'Truck #T-005',
                      location: 'Nugegoda',
                      route: 'Route E',
                      driver: 'Kamal Fernando',
                      fuel: '91%',
                      status: 'Active',
                      collections: 15,
                      distance: '5.8km',
                      duration: '3.2h',
                    ),
                    const SizedBox(height: 12),
                    _buildTruckCard(
                      truckId: 'Truck #T-007',
                      location: 'Garage',
                      route: 'Route C',
                      driver: 'Nimal Jayasinghe',
                      fuel: '45%',
                      status: 'Active',
                      collections: 18,
                      distance: '8.4km',
                      duration: '4.5h',
                    ),
                    const SizedBox(height: 12),
                    _buildTruckCard(
                      truckId: 'Truck #T-012',
                      location: 'Service Center',
                      route: 'Route D',
                      driver: 'Priyantha Dias',
                      fuel: '60%',
                      status: 'Active',
                      collections: 0,
                      distance: '0km',
                      duration: '0h',
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF8B5A96),
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
    );
  }

  Widget _buildTruckCard({
    required String truckId,
    required String location,
    required String route,
    required String driver,
    required String fuel,
    required String status,
    required int collections,
    required String distance,
    required String duration,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
                truckId,
                style: const TextStyle(
                  color: Color(0xFF8B5A96),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusBackgroundColor(status),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _getStatusColor(status),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      status,
                      style: TextStyle(
                        color: _getStatusColor(status),
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

          // Truck info grid
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _buildInfoItem(Icons.location_on, location, Color(0xFF8B5A96)),
              _buildInfoItem(Icons.route, route, Colors.green),
              _buildInfoItem(Icons.person, driver, Colors.blue),
              _buildInfoItem(Icons.local_gas_station, fuel, Colors.orange),
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
                _buildMetric(collections.toString(), 'Collections'),
                _buildMetric(distance, 'Distance'),
                _buildMetric(duration, 'Duration'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text, Color iconColor) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 80) / 2,
      child: Row(
        children: [
          Icon(icon, size: 16, color: iconColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

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
