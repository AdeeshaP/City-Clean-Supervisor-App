class CollectionRoute {
  final String id;
  final String routeName;
  final String truckId;
  final String startTime;
  final String area;
  final String status;
  final double progress;

  CollectionRoute({
    required this.id,
    required this.routeName,
    required this.truckId,
    required this.startTime,
    required this.area,
    required this.status,
    required this.progress,
  });

  factory CollectionRoute.fromJson(Map<String, dynamic> json) {
    return CollectionRoute(
      id: json['id'],
      routeName: json['routeName'],
      truckId: json['truckId'],
      startTime: json['startTime'],
      area: json['area'],
      status: json['status'],
      progress: json['progress'],
    );
  }
}
