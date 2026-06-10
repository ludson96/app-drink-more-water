import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'controllers/water_controller.dart';
import 'models/daily_goal_model.dart';
import 'models/water_intake_model.dart';
import 'hive_registrar.g.dart';

final getIt = GetIt.instance;

/// Inicializa o Hive, abre as caixas e registra as dependências do app.
Future<void> initDependencies() async {
  // 1. Inicializa o Hive e os adaptadores
  await Hive.initFlutter();
  Hive.registerAdapters();

  // 2. Abre as caixas de armazenamento local (garante que estarão prontas antes do Controller)
  await Hive.openBox<WaterIntake>('intakes');
  await Hive.openBox<DailyGoal>('goal');

  // 3. Registra o Controller como Singleton
  getIt.registerLazySingleton<WaterController>(() => WaterController());
}
