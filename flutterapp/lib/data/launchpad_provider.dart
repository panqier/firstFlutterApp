import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutterapp/data/launchpad.dart';

class LaunchpadProvider extends ChangeNotifier {
  late Launchpad _launchpad;

  Launchpad get rocket => _launchpad;

  Future<Launchpad?> fetchLaunchpadById(String launchpadId) async {
    final dio = Dio();
    final url = 'https://api.spacexdata.com/v4/launchpads/$launchpadId';

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final jsonData = response.data;
        return Launchpad.fromJson(jsonData);
      } else {
        throw Exception('Failed to fetch rocket');
      }
    } catch (e) {
      throw Exception('Failed to fetch rocket: $e');
    }
  }
}
