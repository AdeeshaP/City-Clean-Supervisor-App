// Data model
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteData {
  String id;
  String name;
  String zone;
  List<String> areas;
  String assignedTruck;
  String driver;
  String status;
  String estimatedTime;
  String distance;
  int collections;
  List<LatLng> coordinates;

  RouteData({
    required this.id,
    required this.name,
    required this.zone,
    required this.areas,
    required this.assignedTruck,
    required this.driver,
    required this.status,
    required this.estimatedTime,
    required this.distance,
    required this.collections,
    required this.coordinates,
  });
}

// Add Route Dialog
