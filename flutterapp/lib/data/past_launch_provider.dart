import 'package:flutterapp/data/launch.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class PastLaunchProvider extends ChangeNotifier {
  List<Launch> _launchList = [];

  List<Launch> get launchList => _launchList;

  PastLaunchProvider() {
    fetchLaunchList();
  }

  Future<void> fetchLaunchList() async {
    try {
      final response =
          await Dio().get('https://api.spacexdata.com/v4/launches/past');
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data;
        _launchList = jsonData.map((launchData) {
          final patchLarge = launchData['links']['patch'] != null
              ? launchData['links']['patch']['large']
              : '';
          final wikipedia = launchData['links']['wikipedia'] ?? '';
          final rocket = launchData['rocket'] ?? '';
          final details =
              launchData['details'] ?? 'No description for this launch';
          final launchpad = launchData['launchpad'] ?? '';
          final isPatchLargeNull = patchLarge.isEmpty;

          return Launch(
            missionName: launchData['name'],
            launchDate: DateTime.parse(launchData['date_utc']),
            patchLarge: patchLarge,
            wikipedia: wikipedia,
            rocket: rocket,
            details: details,
            launchpad: launchpad,
            isPatchLargeNull: isPatchLargeNull,
          );
        }).toList();

        // Sort the launch list by launch date in descending order
        _launchList.sort((a, b) => b.launchDate.compareTo(a.launchDate));

        notifyListeners();
      } else {
        throw Exception('Failed to fetch launch list');
      }
    } catch (e) {
      throw Exception('Failed to fetch launch list: $e');
    }
  }
}
