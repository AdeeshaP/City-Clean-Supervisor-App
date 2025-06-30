import 'package:abans_city_clean_supervisor/screens/fitst_screen.dart';
import 'package:flutter/material.dart';

class CollectionRoutesScreen extends StatefulWidget {
  @override
  _CollectionRoutesScreenState createState() => _CollectionRoutesScreenState();
}

class _CollectionRoutesScreenState extends State<CollectionRoutesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EFB8),
      appBar: AppBar(
        backgroundColor: Color(0xFF6A1B9A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
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
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildRouteCard(
                routeName: 'Route A - North Zone',
                truckId: 'Truck #T-001',
                startTime: 'Started 07:30',
                area: 'Kollupitiya - Bambalapitiya',
                status: 'Active',
                progress: 0.65,
                statusColor: Colors.green,
              ),
              const SizedBox(height: 12),
              _buildRouteCard(
                routeName: 'Route B - Central Zone',
                truckId: 'Truck #T-003',
                startTime: 'Started 08:00',
                area: 'Fort - Pettah - Kotahena',
                status: 'Active',
                progress: 0.40,
                statusColor: Colors.green,
              ),
              const SizedBox(height: 12),
              _buildRouteCard(
                routeName: 'Route C - South Zone',
                truckId: 'Truck #T-007',
                startTime: '06:30 - 09:15',
                area: 'Wellawatta - Mt.Lavinia',
                status: 'Completed',
                progress: 1.0,
                statusColor: Colors.blue,
              ),
              const SizedBox(height: 12),
              _buildRouteCard(
                routeName: 'Route D - East Zone',
                truckId: 'Truck #T-012',
                startTime: 'Scheduled 10:00',
                area: 'Battaramulla - Rajagiriya',
                status: 'Pending',
                progress: 0.0,
                statusColor: Colors.orange,
              ),
              const SizedBox(height: 12),
              _buildRouteCard(
                routeName: 'Route E - West Zone',
                truckId: 'Truck #T-005',
                startTime: 'Started 07:45',
                area: 'Nugegoda - Maharagama',
                status: 'Active',
                progress: 0.80,
                statusColor: Colors.green,
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF8B5A96),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildRouteCard({
    required String routeName,
    required String truckId,
    required String startTime,
    required String area,
    required String status,
    required double progress,
    required Color statusColor,
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
          // Header with route name and status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  routeName,
                  style: const TextStyle(
                    color: Color(0xFF8B5A96),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusBackgroundColor(status),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Route info
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.local_shipping,
                      size: 16,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      truckId,
                      style: const TextStyle(
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
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    startTime,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Location info
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 16,
                color: Color(0xFF8B5A96),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  area,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Progress bar
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
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
        return const Color(0xFFE8F5E8);
      case 'completed':
        return const Color(0xFFE3F2FD);
      case 'pending':
        return const Color(0xFFFFF3E0);
      default:
        return Colors.grey[100]!;
    }
  }
}
