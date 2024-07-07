import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/concert_list_controller.dart';
import 'package:weather_app/pages/current_weather_page.dart';

class ConcertListBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ConcertListController());
  }
}

class ConcertListPage extends StatefulWidget {
  const ConcertListPage({super.key});

  static const pageName = '/';

  @override
  State<ConcertListPage> createState() => _ConcertListPageState();
}

class _ConcertListPageState extends State<ConcertListPage> {
  final controller = Get.find<ConcertListController>();

  void _goToCurrentWeatherPage(String location) {
    Get.toNamed(
      CurrentWeatherPage.pageName,
      arguments: CurrentWeatherArguments(location: location),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Concert List')),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(labelText: 'Search'),
                  onChanged: controller.setFilter,
                ),
              ),
              Obx(() {
                final concertPlaces = controller.concertPlaces;

                if (concertPlaces.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      'No concerts found at this location.',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: concertPlaces.length,
                    itemBuilder: (context, index) {
                      final concertPlace = concertPlaces[index];

                      return ListTile(
                        leading: const Icon(Icons.location_on),
                        title: Text(concertPlace),
                        onTap: () => _goToCurrentWeatherPage(concertPlace),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
