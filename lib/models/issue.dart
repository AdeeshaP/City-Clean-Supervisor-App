
// Issue model
class Issue {
  final String id;
  final String title;
  final String description;
  final String location;
  final DateTime reportedDate;
  final String status;
  final String imageUrl;
  final String reportedBy;
  final String priority;

  Issue({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.reportedDate,
    required this.status,
    required this.imageUrl,
    required this.reportedBy,
    required this.priority,
  });

  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      reportedDate: DateTime.parse(json['reported_date']),
      status: json['status'],
      imageUrl: json['image_url'],
      reportedBy: json['reported_by'],
      priority: json['priority'],
    );
  }
}
