import 'package:hive_ce/hive.dart';

part 'daily_goal_model.g.dart';

@HiveType(typeId: 1)
class DailyGoal extends HiveObject {
  @HiveField(0)
  final int targetInMl;

  DailyGoal({required this.targetInMl});
}
