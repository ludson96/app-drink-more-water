import 'package:mobx/mobx.dart';
import 'package:hive_ce/hive.dart';
import '../models/daily_goal_model.dart';
import '../models/water_intake_model.dart';

part 'water_controller.g.dart';

class WaterController = _WaterController with _$WaterController;

abstract class _WaterController with Store {
  late final Box<WaterIntake> _intakeBox;
  late final Box<DailyGoal> _goalBox;

  _WaterController() {
    _intakeBox = Hive.box<WaterIntake>('intakes');
    _goalBox = Hive.box<DailyGoal>('goal');
    _loadData();
  }

  @observable
  ObservableList<WaterIntake> intakes = ObservableList<WaterIntake>();

  @observable
  DailyGoal goal = DailyGoal(targetInMl: 2000);

  @computed
  int get totalConsumed {
    return intakes.fold(0, (sum, item) => sum + item.amountInMl);
  }

  @computed
  double get progress {
    if (goal.targetInMl == 0) return 0;
    return totalConsumed / goal.targetInMl;
  }

  @action
  void _loadData() {
    intakes.addAll(_intakeBox.values);
    if (_goalBox.isNotEmpty) {
      goal = _goalBox.values.first;
    } else {
      _goalBox.add(goal);
    }
  }

  @action
  void addWater(int amountInMl) {
    final intake = WaterIntake(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amountInMl: amountInMl,
      time: DateTime.now(),
    );
    _intakeBox.put(intake.id, intake);
    intakes.add(intake);
  }

  @action
  void removeWater(String id) {
    _intakeBox.delete(id);
    intakes.removeWhere((item) => item.id == id);
  }

  @action
  void updateGoal(int newGoal) {
    goal = DailyGoal(targetInMl: newGoal);
    if (_goalBox.isNotEmpty) {
      _goalBox.putAt(0, goal);
    } else {
      _goalBox.add(goal);
    }
  }
}
