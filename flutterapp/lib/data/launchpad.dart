class Launchpad {
  final String launchpadtId;
  final String launchpadName;
  // Add other properties here

  Launchpad({
    required this.launchpadtId,
    required this.launchpadName,
    // Add other constructor parameters here
  });

  factory Launchpad.fromJson(Map<String, dynamic> json) {
    return Launchpad(
      launchpadtId: json['id'],
      launchpadName: json['name'],
      // Parse other properties from the JSON object
    );
  }
}
