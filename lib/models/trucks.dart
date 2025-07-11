class ActiveTruck {
  final String id;
  final String truckId;
  final String location;
  final String route;
  final String driver;
  final String fuel;
  final String status;
  final int collections;
  final String distance;
  final String duration;

  ActiveTruck({
    required this.id,
    required this.truckId,
    required this.location,
    required this.route,
    required this.driver,
    required this.fuel,
    required this.status,
    required this.collections,
    required this.distance,
    required this.duration,
  });

  factory ActiveTruck.fromJson(Map<String, dynamic> json) {
    return ActiveTruck(
      id: json['id'],
      truckId: json['truckId'],
      location: json['location'],
      route: json['route'],
      driver: json['driver'],
      fuel: json['fuel'],
      status: json['status'],
      collections: json['collections'],
      distance: json['distance'],
      duration: json['duration'],
    );
  }
}
