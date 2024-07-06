import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/splash_controller.dart';
import 'package:weather_app/pages/concert_list_page.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const pageName = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () => Get.offNamed(ConcertListPage.pageName));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Weather App '),
            SizedBox(height: 16),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
