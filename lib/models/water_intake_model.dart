import 'package:hive_ce/hive.dart';

part 'water_intake_model.g.dart';

@HiveType(typeId: 0)
class WaterIntake extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final int amountInMl;
  
  @HiveField(2)
  final DateTime time;

  WaterIntake({required this.id, required this.amountInMl, required this.time});
}
