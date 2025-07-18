import 'package:abans_city_clean_supervisor/constants/color_pallettee.dart';
import 'package:abans_city_clean_supervisor/models/route_data.dart';
import 'package:abans_city_clean_supervisor/screens/fitst_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteManagementScreen extends StatefulWidget {
  @override
  _RouteManagementScreenState createState() => _RouteManagementScreenState();
}

class _RouteManagementScreenState extends State<RouteManagementScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  RouteData? _selectedRoute; // Add this line

  List<RouteData> routes = [];
  List<String> availableDrivers = [
    'Ravi Silva',
    'Sunil Perera',
    'Kamal Fernando',
    'Nimal Jayasinghe',
    'Prasad Wickrama',
    'Chaminda Perera'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadRoutes();
    _setupMapData();
  }

  void loadRoutes() {
    // Mock data - in real app, load from API
    routes = [
      RouteData(
        id: 'RT-001',
        name: 'Route A - North Zone',
        zone: 'North Zone',
        areas: [
          'Kollupitiya',
          'Bambalapitiya',
          'Wellawatta',
          'Cinnamon Gardens'
        ],
        assignedTruck: 'T-001',
        driver: 'Ravi Silva',
        status: 'Active',
        estimatedTime: '4.5h',
        distance: '15.2km',
        collections: 12,
        coordinates: [
          LatLng(6.9271, 79.8612),
          LatLng(6.9147, 79.8560),
          LatLng(6.8956, 79.8506),
        ],
      ),
      RouteData(
        id: 'RT-002',
        name: 'Route B - Central Zone',
        zone: 'Central Zone',
        areas: ['Fort', 'Pettah', 'Kotahena'],
        assignedTruck: 'T-003',
        driver: 'Sunil Perera',
        status: 'Active',
        estimatedTime: '3.8h',
        distance: '12.1km',
        collections: 8,
        coordinates: [
          LatLng(6.9344, 79.8428),
          LatLng(6.9319, 79.8478),
          LatLng(6.9395, 79.8518),
        ],
      ),
      RouteData(
        id: 'RT-003',
        name: 'Route C - South Zone',
        zone: 'South Zone',
        areas: ['Wellawatta', 'Mt.Lavinia', 'Dehiwala'],
        assignedTruck: 'T-007',
        driver: 'Kamal Fernando',
        status: 'Completed',
        estimatedTime: '5.2h',
        distance: '18.5km',
        collections: 15,
        coordinates: [
          LatLng(6.8956, 79.8506),
          LatLng(6.8692, 79.8742),
          LatLng(6.8507, 79.8719),
        ],
      ),
    ];
  }

  void _setupMapData() {
    _markers.clear();
    _polylines.clear();

    // If a specific route is selected, show only that route
    List<RouteData> routesToShow =
        _selectedRoute != null ? [_selectedRoute!] : routes;

    for (int i = 0; i < routesToShow.length; i++) {
      RouteData route = routesToShow[i];

      // Add markers for each route
      for (int j = 0; j < route.coordinates.length; j++) {
        _markers.add(
          Marker(
            markerId: MarkerId('${route.id}_$j'),
            position: route.coordinates[j],
            infoWindow: InfoWindow(
              title: route.name,
              snippet: route.areas[j],
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              _getRouteColor(route.status),
            ),
          ),
        );
      }

      // Add polyline for route path
      _polylines.add(
        Polyline(
          polylineId: PolylineId(route.id),
          points: route.coordinates,
          color: _getRouteStatusColor(route.status),
          width: 4,
        ),
      );
    }
  }

  // void _showAllRoutes() {
  //   setState(() {
  //     _selectedRoute = null;
  //     _setupMapData();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Route Management',
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
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Routes List'),
            Tab(text: 'Map View'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryPurpleColor,
        onPressed: () => _showAddRouteDialog(),
        child: Icon(Icons.add, color: Colors.white),
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
              _buildRoutesListView(),
              _buildMapView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoutesListView() {
    return ListView.builder(
      padding: EdgeInsets.all(12.0),
      itemCount: routes.length,
      itemBuilder: (context, index) {
        final route = routes[index];
        return _buildRouteCard(route);
      },
    );
  }

  Widget _buildRouteCard(RouteData route) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      route.name,
                      style: TextStyle(
                        // color: Color(0xFF8B5A96),
                        color: primaryPurpleColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      route.id,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
       
            ],
          ),
          SizedBox(height: 12),

          // Route details
          Column(
            children: [
              _buildRouteDetailRow(
                  Icons.location_on, 'Areas', route.areas.join(', ')),
              SizedBox(height: 8),
              _buildRouteDetailRow(
                  Icons.local_shipping, 'Truck', route.assignedTruck),
              SizedBox(height: 8),
              _buildRouteDetailRow(Icons.person, 'Driver', route.driver),
              SizedBox(height: 8),
              // _buildRouteDetailRow(Icons.access_time, 'Estimated Time', route.estimatedTime),
            ],
          ),
          SizedBox(height: 12),

          // Metrics
          // Container(
          //   padding: EdgeInsets.all(12),
          //   decoration: BoxDecoration(
          //     color: Color(0xFFF8F9FA),
          //     borderRadius: BorderRadius.circular(8),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       _buildMetric(route.collections.toString(), 'Collections'),
          //       _buildMetric(route.distance, 'Distance'),
          //       _buildMetric(route.estimatedTime, 'Duration'),
          //     ],
          //   ),
          // ),
          // SizedBox(height: 12),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActionButton(
                icon: Icons.edit,
                label: 'Edit Route',
                color: primaryGreen,
                onPressed: () => _showEditRouteDialog(route),
                // width: 90,
              ),
              // _buildActionButton(
              //   icon: Icons.person_add,
              //   label: 'Change Driver',
              //   color: primaryGreen,
              //   onPressed: () => _showChangeDriverDialog(route),
              //   width: 120,
              // ),
              _buildActionButton(
                icon: Icons.visibility,
                label: 'View on Map',
                color: primaryGreen,
                onPressed: () => _showRouteOnMap(route),
                // width: 95,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRouteDetailRow(IconData icon, String label, String value) {
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
    // required double width,
  }) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, size: 16, color: Colors.white),
          label: Text(
            label,
            style: TextStyle(fontSize: 13, color: Colors.white),
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
        polylines: _polylines,
        mapType: MapType.normal,
      ),
    );
  }

  // Widget _buildMetric(String value, String label) {
  //   return Column(
  //     children: [
  //       Text(
  //         value,
  //         style: TextStyle(
  //           fontSize: 16,
  //           fontWeight: FontWeight.w600,
  //           color: Color(0xFF8B5A96),
  //         ),
  //       ),
  //       SizedBox(height: 2),
  //       Text(
  //         label,
  //         style: TextStyle(
  //           fontSize: 11,
  //           color: Colors.grey,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Dialog methods
  void _showAddRouteDialog() {
    showDialog(
      context: context,
      builder: (context) => AddRouteDialog(
        availableDrivers: availableDrivers,
        onRouteAdded: (newRoute) {
          setState(() {
            routes.add(newRoute);
            _setupMapData();
          });
        },
      ),
    );
  }

  void _showEditRouteDialog(RouteData route) {
    showDialog(
      context: context,
      builder: (context) => EditRouteDialog(
        route: route,
        availableDrivers: availableDrivers,
        onRouteUpdated: (updatedRoute) {
          setState(() {
            int index = routes.indexWhere((r) => r.id == route.id);
            routes[index] = updatedRoute;
            _setupMapData();
          });
        },
      ),
    );
  }

  // void _showChangeDriverDialog(RouteData route) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => ChangeDriverDialog(
  //       route: route,
  //       availableDrivers: availableDrivers,
  //       onDriverChanged: (newDriver) {
  //         setState(() {
  //           route.driver = newDriver;
  //         });
  //       },
  //     ),
  //   );
  // }

  void _showRouteOnMap(RouteData route) {
    // _tabController.animateTo(1);
    // // Center map on route
    // if (_mapController != null && route.coordinates.isNotEmpty) {
    //   _mapController!.animateCamera(
    //     CameraUpdate.newLatLngBounds(
    //       LatLngBounds(
    //         southwest: LatLng(
    //           route.coordinates
    //               .map((e) => e.latitude)
    //               .reduce((a, b) => a < b ? a : b),
    //           route.coordinates
    //               .map((e) => e.longitude)
    //               .reduce((a, b) => a < b ? a : b),
    //         ),
    //         northeast: LatLng(
    //           route.coordinates
    //               .map((e) => e.latitude)
    //               .reduce((a, b) => a > b ? a : b),
    //           route.coordinates
    //               .map((e) => e.longitude)
    //               .reduce((a, b) => a > b ? a : b),
    //         ),
    //       ),
    //       100.0,
    //     ),
    //   );
    // }
    setState(() {
      _selectedRoute = route;
      _setupMapData();
    });
    _tabController.animateTo(1);

    if (_mapController != null && route.coordinates.isNotEmpty) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(
              route.coordinates
                  .map((e) => e.latitude)
                  .reduce((a, b) => a < b ? a : b),
              route.coordinates
                  .map((e) => e.longitude)
                  .reduce((a, b) => a < b ? a : b),
            ),
            northeast: LatLng(
              route.coordinates
                  .map((e) => e.latitude)
                  .reduce((a, b) => a > b ? a : b),
              route.coordinates
                  .map((e) => e.longitude)
                  .reduce((a, b) => a > b ? a : b),
            ),
          ),
          100.0,
        ),
      );
    }
  }

  // // Helper methods
  // Color _getStatusColor(String status) {
  //   switch (status.toLowerCase()) {
  //     case 'active':
  //       return Colors.green;
  //     case 'completed':
  //       return Colors.blue;
  //     case 'pending':
  //       return Colors.orange;
  //     default:
  //       return Colors.red;
  //   }
  // }

  // Color _getStatusBackgroundColor(String status) {
  //   switch (status.toLowerCase()) {
  //     case 'active':
  //       return Color(0xFFE8F5E8);
  //     case 'completed':
  //       return Color(0xFFE3F2FD);
  //     case 'pending':
  //       return Color(0xFFFFF3E0);
  //     default:
  //       return Color(0xFFFFEBEE);
  //   }
  // }

  Color _getRouteStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'completed':
        return Colors.blue;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  double _getRouteColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return BitmapDescriptor.hueGreen;
      case 'completed':
        return BitmapDescriptor.hueBlue;
      case 'pending':
        return BitmapDescriptor.hueOrange;
      default:
        return BitmapDescriptor.hueRed;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

// Add Route Dialog
class AddRouteDialog extends StatefulWidget {
  final List<String> availableDrivers;
  final Function(RouteData) onRouteAdded;

  AddRouteDialog({
    required this.availableDrivers,
    required this.onRouteAdded,
  });

  @override
  _AddRouteDialogState createState() => _AddRouteDialogState();
}

class _AddRouteDialogState extends State<AddRouteDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _zoneController = TextEditingController();
  final _areasController = TextEditingController();
  final _truckController = TextEditingController();
  String? _selectedDriver;

  @override
  void dispose() {
    _nameController.dispose();
    _zoneController.dispose();
    _areasController.dispose();
    _truckController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(20),
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
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.add_road,
                    color: Theme.of(context).primaryColor,
                    size: 28,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Add New Route',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ],
              ),
            ),

            // Form Content
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Route Name
                        _buildFormField(
                          controller: _nameController,
                          label: 'Route Name',
                          icon: Icons.route,
                          hint: 'Enter route name',
                        ),

                        SizedBox(height: 15),

                        // Zone
                        _buildFormField(
                          controller: _zoneController,
                          label: 'Zone',
                          icon: Icons.location_on,
                          hint: 'Enter zone name',
                        ),

                        SizedBox(height: 15),

                        // Areas
                        _buildFormField(
                          controller: _areasController,
                          label: 'Areas',
                          icon: Icons.place,
                          hint: 'Enter areas separated by commas',
                          maxLines: 2,
                        ),

                        SizedBox(height: 15),

                        // Assigned Truck
                        _buildFormField(
                          controller: _truckController,
                          label: 'Assigned Truck',
                          icon: Icons.local_shipping,
                          hint: 'Enter truck ID or name',
                        ),

                        SizedBox(height: 15),

                        // Driver Selection
                        _buildDriverDropdown(),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Action Buttons
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Add Route',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey.shade600),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13),
            filled: true,
            fillColor: Colors.grey.shade50,
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
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 15,
            ),
          ),
          validator: (value) =>
              value?.isEmpty ?? true ? '$label is required' : null,
        ),
      ],
    );
  }

  Widget _buildDriverDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.person, size: 20, color: Colors.grey.shade600),
            SizedBox(width: 8),
            Text(
              'Select Driver',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedDriver,
          decoration: InputDecoration(
            hintText: 'Choose a driver',
            hintStyle: TextStyle(fontWeight: FontWeight.w400),
            filled: true,
            fillColor: Colors.grey.shade50,
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
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          items: widget.availableDrivers.map((driver) {
            return DropdownMenuItem(
              value: driver,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(0.1),
                    child: Text(
                      driver.substring(0, 1).toUpperCase(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    driver,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) => setState(() => _selectedDriver = value),
          validator: (value) => value == null ? 'Please select a driver' : null,
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final newRoute = RouteData(
        id: 'RT-${DateTime.now().millisecondsSinceEpoch}',
        name: _nameController.text.trim(),
        zone: _zoneController.text.trim(),
        areas: _areasController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
        assignedTruck: _truckController.text.trim(),
        driver: _selectedDriver!,
        status: 'Pending',
        estimatedTime: '0h',
        distance: '0km',
        collections: 0,
        coordinates: [LatLng(6.9271, 79.8612)], // Default coordinates
      );
      widget.onRouteAdded(newRoute);
      Navigator.pop(context);
    }
  }
}

// Edit Route Dialog
class EditRouteDialog extends StatefulWidget {
  final RouteData route;
  final List<String> availableDrivers;
  final Function(RouteData) onRouteUpdated;

  EditRouteDialog({
    required this.route,
    required this.availableDrivers,
    required this.onRouteUpdated,
  });

  @override
  _EditRouteDialogState createState() => _EditRouteDialogState();
}

class _EditRouteDialogState extends State<EditRouteDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _zoneController;
  late TextEditingController _areasController;
  late TextEditingController _truckController;
  String? _selectedDriver;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.route.name);
    _zoneController = TextEditingController(text: widget.route.zone);
    _areasController =
        TextEditingController(text: widget.route.areas.join(', '));
    _truckController = TextEditingController(text: widget.route.assignedTruck);
    _selectedDriver = widget.route.driver;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(20),
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
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                    size: 28,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Edit Route Details',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        editRouteFormField(
                          context,
                          _nameController,
                          'Route Name',
                          Icons.route,
                          'Enter route name',
                        ),
                        SizedBox(height: 15),
                        editRouteFormField(
                          context,
                          _zoneController,
                          'Zone',
                          Icons.route,
                          'Enter route name',
                        ),
                        SizedBox(height: 15),
                        editRouteFormField(
                          context,
                          _areasController,
                          'Areas (comma separated)',
                          Icons.route,
                          'Areas (comma separated)',
                        ),
                        SizedBox(height: 15),
                        editRouteFormField(
                          context,
                          _truckController,
                          'Assigned Truck',
                          Icons.local_shipping,
                          'Enter route name',
                        ),
                        SizedBox(height: 15),
                        editDetailsDriverDropdown(),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Action Buttons
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // actions: [
      //   TextButton(
      //     onPressed: () => Navigator.pop(context),
      //     child: Text('Cancel'),
      //   ),
      //   ElevatedButton(
      //     onPressed: () {
      //       if (_formKey.currentState?.validate() ?? false) {
      //         final updatedRoute = RouteData(
      //           id: widget.route.id,
      //           name: _nameController.text,
      //           zone: _zoneController.text,
      //           areas: _areasController.text
      //               .split(',')
      //               .map((e) => e.trim())
      //               .toList(),
      //           assignedTruck: _truckController.text,
      //           driver: _selectedDriver!,
      //           status: widget.route.status,
      //           estimatedTime: widget.route.estimatedTime,
      //           distance: widget.route.distance,
      //           collections: widget.route.collections,
      //           coordinates: widget.route.coordinates,
      //         );
      //         widget.onRouteUpdated(updatedRoute);
      //         Navigator.pop(context);
      //       }
      //     },
      //     child: Text('Update Route'),
      //   ),
      // ],
    );
  }

  Widget editDetailsDriverDropdown() {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.person, size: 20, color: Colors.grey.shade600),
            SizedBox(width: 8),
            Text(
              'Select Driver',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedDriver,
          items: widget.availableDrivers.map((driver) {
            return DropdownMenuItem(
                value: driver,
                child: Text(
                  driver,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ));
          }).toList(),
          onChanged: (value) => setState(() => _selectedDriver = value),
          validator: (value) => value == null ? 'Required' : null,
        ),
      ],
    );
  }

  Widget editRouteFormField(
    BuildContext context,
    TextEditingController controller,
    String label,
    IconData icon,
    String hint,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey.shade600),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
          decoration: InputDecoration(
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
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 15,
            ),
          ),
          validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
        ),
      ],
    );
  }
}

// Change Driver Dialog
class ChangeDriverDialog extends StatefulWidget {
  final RouteData route;
  final List<String> availableDrivers;
  final Function(String) onDriverChanged;

  ChangeDriverDialog({
    required this.route,
    required this.availableDrivers,
    required this.onDriverChanged,
  });

  @override
  _ChangeDriverDialogState createState() => _ChangeDriverDialogState();
}

class _ChangeDriverDialogState extends State<ChangeDriverDialog> {
  String? _selectedDriver;

  @override
  void initState() {
    super.initState();
    _selectedDriver = widget.route.driver;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Change Driver'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Current Driver: ${widget.route.driver}'),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _selectedDriver,
            decoration: InputDecoration(labelText: 'Select New Driver'),
            items: widget.availableDrivers.map((driver) {
              return DropdownMenuItem(value: driver, child: Text(driver));
            }).toList(),
            onChanged: (value) => setState(() => _selectedDriver = value),
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
            if (_selectedDriver != null &&
                _selectedDriver != widget.route.driver) {
              widget.onDriverChanged(_selectedDriver!);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Driver changed successfully')),
              );
            } else {
              Navigator.pop(context);
            }
          },
          child: Text('Change Driver'),
        ),
      ],
    );
  }
}
