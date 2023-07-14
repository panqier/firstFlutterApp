import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutterapp/data/rocket.dart';

class RocketProvider extends ChangeNotifier {
  late Rocket _rocket;

  Rocket get rocket => _rocket;

  Future<Rocket?> fetchRocketById(String rocketId) async {
    final dio = Dio();
    final url = 'https://api.spacexdata.com/v4/rockets/$rocketId';

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final jsonData = response.data;
        return Rocket.fromJson(jsonData);
      } else {
        throw Exception('Failed to fetch rocket');
      }
    } catch (e) {
      throw Exception('Failed to fetch rocket: $e');
    }
  }
}
