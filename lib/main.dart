import 'package:flutter/material.dart';
import 'controllers/water_controller.dart';
import 'views/home_view.dart';

void main() {
  final waterController = WaterController();
  runApp(DrinkMoreWaterApp(controller: waterController));
}

class DrinkMoreWaterApp extends StatelessWidget {
  final WaterController controller;

  const DrinkMoreWaterApp({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beber Água',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blueAccent,
          secondary: Colors.lightBlue,
        ),
        useMaterial3: true,
      ),
      home: HomeView(controller: controller),
      debugShowCheckedModeBanner: false,
    );
  }
}
