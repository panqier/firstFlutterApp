import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/data/upcoming_launch_provider.dart';
import 'package:flutterapp/ui/launch_detail.dart';

class UpcomingLaunch extends StatelessWidget {
  final List<String> iconPaths = [
    'assets/rocket01.png',
    'assets/rocket02.png',
    'assets/astronaut01.png',
    'assets/astronaut02.png',
  ];

  UpcomingLaunch({super.key});

  @override
  Widget build(BuildContext context) {
    final launchProvider =
        Provider.of<UpcomingLaunchProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Launch List'),
      ),
      //backgroundColor: Color.fromARGB(255, 150, 152, 153),
      body: Center(
        child: Consumer<UpcomingLaunchProvider>(
          builder: (context, launchProvider, _) {
            if (launchProvider.launchList.isEmpty) {
              return const CircularProgressIndicator();
            } else {
              return ListView.builder(
                itemCount: launchProvider.launchList.length,
                itemBuilder: (context, index) {
                  final launch = launchProvider.launchList[index];
                  final iconPath = iconPaths[index % iconPaths.length];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LaunchDetail(launch: launch),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Image.asset(iconPath, width: 60, height: 60),
                      title: Text(
                        launch.missionName,
                        style: const TextStyle(
                          fontSize: 16, // Set the desired text size
                          color: Colors.black, // Set the desired text color
                          fontWeight:
                              FontWeight.bold, // Set the desired font weight
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            launch.launchDate.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 84, 83, 83),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          launchProvider.fetchLaunchList();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
