import 'package:flutter/foundation.dart';
import '../models/water_intake_model.dart';

class WaterController with ChangeNotifier {
  final List<WaterIntake> _intakes = [];
  DailyGoal _goal = DailyGoal(targetInMl: 2000);

  List<WaterIntake> get intakes => List.unmodifiable(_intakes);
  DailyGoal get goal => _goal;

  int get totalConsumed {
    return _intakes.fold(0, (sum, item) => sum + item.amountInMl);
  }

  double get progress {
    if (_goal.targetInMl == 0) return 0;
    return totalConsumed / _goal.targetInMl;
  }

  void addWater(int amountInMl) {
    _intakes.add(
      WaterIntake(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        amountInMl: amountInMl,
        time: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void removeWater(String id) {
    _intakes.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void updateGoal(int newGoal) {
    _goal = DailyGoal(targetInMl: newGoal);
    notifyListeners();
  }
}
