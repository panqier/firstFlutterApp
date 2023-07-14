import 'package:flutter/material.dart';
import 'package:flutterapp/data/launch.dart';
import 'package:flutterapp/data/launchpad.dart';
import 'package:flutterapp/data/launchpad_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/data/rocket_provider.dart';
import 'package:flutterapp/data/rocket.dart';

class LaunchDetail extends StatelessWidget {
  final Launch launch;

  const LaunchDetail({super.key, required this.launch});

  void _launchWikipediaUrl() {
    launchUrl(Uri.parse(launch.wikipedia));
  }

  @override
  Widget build(BuildContext context) {
    Widget patchImage;
    if (launch.isPatchLargeNull) {
      patchImage = Image.asset('assets/universe01.png');
    } else {
      patchImage = Image.network(
        launch.patchLarge,
        fit: BoxFit.cover,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(launch.missionName),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            patchImage,
            SizedBox(height: 16),
            ListTile(
              title: Text('Description'),
              subtitle: Text(launch.details),
            ),
            ListTile(
              title: Text('Launch Date'),
              subtitle: Text(launch.launchDate.toString()),
            ),
            ListTile(
              title: Text('Wikipedia'),
              subtitle: GestureDetector(
                onTap: _launchWikipediaUrl,
                child: Text(
                  launch.wikipedia.isNotEmpty
                      ? launch.wikipedia
                      : 'No Wikipedia link available',
                  style: TextStyle(
                    color: launch.wikipedia.isNotEmpty ? Colors.blue : null,
                    decoration: launch.wikipedia.isNotEmpty
                        ? TextDecoration.underline
                        : null,
                  ),
                ),
              ),
            ),
            Builder(
              builder: (context) {
                final rocketProvider = Provider.of<RocketProvider>(context);
                final Future<Rocket?> rocketFuture =
                    rocketProvider.fetchRocketById(launch.rocket);

                return FutureBuilder<Rocket?>(
                  future: rocketFuture,
                  builder: (context, snapshot) {
                    // Handle snapshot states here
                    // Rest of your code
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListTile(
                        title: Text('Rocket'),
                        subtitle: Text('Loading rocket...'),
                      );
                    } else if (snapshot.hasError) {
                      return ListTile(
                        title: Text('Rocket'),
                        subtitle: Text('Failed to load rocket data'),
                      );
                    } else if (snapshot.hasData) {
                      return ListTile(
                        title: Text('Rocket'),
                        subtitle: Text(snapshot.data!.rocketName),
                      );
                    } else {
                      return ListTile(
                        title: Text('Rocket'),
                        subtitle: Text('Rocket not found'),
                      );
                    }
                  },
                );
              },
            ),
            Builder(
              builder: (context) {
                final launchpadProvider =
                    Provider.of<LaunchpadProvider>(context);
                final Future<Launchpad?> launchpadFuture =
                    launchpadProvider.fetchLaunchpadById(launch.launchpad);

                return FutureBuilder<Launchpad?>(
                  future: launchpadFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListTile(
                        title: Text('Launchpad'),
                        subtitle: Text('Loading Launchpad...'),
                      );
                    } else if (snapshot.hasError) {
                      return ListTile(
                        title: Text('Launchpad'),
                        subtitle: Text('Failed to load launchpad data'),
                      );
                    } else if (snapshot.hasData) {
                      return ListTile(
                        title: Text('Launchpad'),
                        subtitle: Text(snapshot.data!.launchpadName),
                      );
                    } else {
                      return ListTile(
                        title: Text('Launchpad'),
                        subtitle: Text('Launchpad not found'),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
