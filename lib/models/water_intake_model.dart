class WaterIntake {
  final String id;
  final int amountInMl;
  final DateTime time;

  WaterIntake({
    required this.id,
    required this.amountInMl,
    required this.time,
  });
}

class DailyGoal {
  final int targetInMl;

  DailyGoal({required this.targetInMl});
}
