import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/splash_controller.dart';

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
