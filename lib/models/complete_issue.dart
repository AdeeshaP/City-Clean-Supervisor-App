
// IssueComplete model
class IssueComplete {
  final String id;
  final String title;
  final String description;
  final String location;
  final String latitude;
  final String longitude;
  final DateTime reportedDate;
  final DateTime solvedDate;
  final String status;
  final String imageUrl;
  final String reportedBy;

  IssueComplete({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.reportedDate,
    required this.solvedDate,
    required this.status,
    required this.imageUrl,
    required this.reportedBy,
  });

  factory IssueComplete.fromJson(Map<String, dynamic> json) {
    return IssueComplete(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      reportedDate: DateTime.parse(json['reported_date']),
      solvedDate: DateTime.parse(json['solved_date']),
      status: json['status'],
      imageUrl: json['image_url'],
      reportedBy: json['reported_by'],
    );
  }
}
