class Rocket {
  final String rocketId;
  final String rocketName;
  // Add other properties here

  Rocket({
    required this.rocketId,
    required this.rocketName,
    // Add other constructor parameters here
  });

  factory Rocket.fromJson(Map<String, dynamic> json) {
    return Rocket(
      rocketId: json['id'],
      rocketName: json['name'],
      // Parse other properties from the JSON object
    );
  }
}
