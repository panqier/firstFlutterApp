class Launch {
  final String missionName;
  final DateTime launchDate;
  final String patchLarge;
  final String wikipedia;
  final String rocket;
  final String details;
  final String launchpad;
  final bool isPatchLargeNull;

  Launch({
    required this.missionName,
    required this.launchDate,
    required this.patchLarge,
    required this.wikipedia,
    required this.rocket,
    required this.details,
    required this.launchpad,
    required this.isPatchLargeNull,
  });

  factory Launch.fromJson(Map<String, dynamic> json) {
    final patchLarge =
        json['links']['patch'] != null ? json['links']['patch']['large'] : '';
    return Launch(
      missionName: json['name'],
      launchDate: DateTime.parse(json['date_utc']),
      patchLarge: json['links']['patch']['large'],
      wikipedia: json['links']['wikipedia'],
      rocket: json['rocket'],
      details: json['details'],
      launchpad: json['launchpad'],
      isPatchLargeNull: patchLarge == '',
    );
  }
}
