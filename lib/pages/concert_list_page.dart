import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/concert_list_controller.dart';

class ConcertListBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ConcertListController());
  }
}

class ConcertListPage extends StatefulWidget {
  const ConcertListPage({super.key});

  static const pageName = '/concert-list';

  @override
  State<ConcertListPage> createState() => _ConcertListPageState();
}

class _ConcertListPageState extends State<ConcertListPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
