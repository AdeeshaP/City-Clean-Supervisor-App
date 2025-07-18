import 'package:google_maps_flutter/google_maps_flutter.dart';

class IssueData {
  final String id;
  final String title;
  final String description;
  final String location;
  final String reportedBy;
  final DateTime reportedAt;
  String status;
  final String priority;
  final String category;
  final String assignedTo;
  final LatLng coordinates;
  final String imageUrl;
  final String estimatedResolution;
  final String zone;
  
  IssueData({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.reportedBy,
    required this.reportedAt,
    required this.status,
    required this.priority,
    required this.category,
    required this.assignedTo,
    required this.coordinates,
    required this.imageUrl,
    required this.estimatedResolution,
    required this.zone,
  });
}