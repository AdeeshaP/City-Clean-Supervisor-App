class CollectionTemplate {
  final String id;
  final String name;
  final String category;
  final String description;
  final String frequency;
  final String duration;
  final int routes;
  final int trucks;
  final int crews;
  final List<String> timeSlots;
  final int usageCount;
  final String lastUsed;
  final bool isActive;
  final String creator;
  final List<String> zones;

  CollectionTemplate({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.frequency,
    required this.duration,
    required this.routes,
    required this.trucks,
    required this.crews,
    required this.timeSlots,
    required this.usageCount,
    required this.lastUsed,
    required this.isActive,
    required this.creator,
    required this.zones,
  });

  factory CollectionTemplate.fromJson(Map<String, dynamic> json) {
    return CollectionTemplate(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      description: json['description'],
      frequency: json['frequency'],
      duration: json['duration'],
      routes: json['routes'],
      trucks: json['trucks'],
      crews: json['crews'],
      timeSlots: List<String>.from(json['timeSlots']),
      usageCount: json['usageCount'],
      lastUsed: json['lastUsed'],
      isActive: json['isActive'],
      creator: json['creator'],
      zones: List<String>.from(json['zones']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'frequency': frequency,
      'duration': duration,
      'routes': routes,
      'trucks': trucks,
      'crews': crews,
      'timeSlots': timeSlots,
      'usageCount': usageCount,
      'lastUsed': lastUsed,
      'isActive': isActive,
      'creator': creator,
      'zones': zones,
    };
  }
}
