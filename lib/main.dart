import 'package:flutter/material.dart';
import 'controllers/water_controller.dart';
import 'models/daily_goal_model.dart';
import 'models/water_intake_model.dart';
import 'views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  Hive.registerAdapter(WaterIntakeAdapter());
  Hive.registerAdapter(DailyGoalAdapter());
  
  await Hive.openBox<WaterIntake>('intakes');
  await Hive.openBox<DailyGoal>('goal');

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
