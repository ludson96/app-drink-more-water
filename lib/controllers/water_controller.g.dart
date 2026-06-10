// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WaterController on _WaterController, Store {
  Computed<int>? _$totalConsumedComputed;

  @override
  int get totalConsumed => (_$totalConsumedComputed ??= Computed<int>(
    () => super.totalConsumed,
    name: '_WaterController.totalConsumed',
  )).value;
  Computed<double>? _$progressComputed;

  @override
  double get progress => (_$progressComputed ??= Computed<double>(
    () => super.progress,
    name: '_WaterController.progress',
  )).value;

  late final _$intakesAtom = Atom(
    name: '_WaterController.intakes',
    context: context,
  );

  @override
  ObservableList<WaterIntake> get intakes {
    _$intakesAtom.reportRead();
    return super.intakes;
  }

  @override
  set intakes(ObservableList<WaterIntake> value) {
    _$intakesAtom.reportWrite(value, super.intakes, () {
      super.intakes = value;
    });
  }

  late final _$goalAtom = Atom(name: '_WaterController.goal', context: context);

  @override
  DailyGoal get goal {
    _$goalAtom.reportRead();
    return super.goal;
  }

  @override
  set goal(DailyGoal value) {
    _$goalAtom.reportWrite(value, super.goal, () {
      super.goal = value;
    });
  }

  late final _$_WaterControllerActionController = ActionController(
    name: '_WaterController',
    context: context,
  );

  @override
  void _loadData() {
    final _$actionInfo = _$_WaterControllerActionController.startAction(
      name: '_WaterController._loadData',
    );
    try {
      return super._loadData();
    } finally {
      _$_WaterControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addWater(int amountInMl) {
    final _$actionInfo = _$_WaterControllerActionController.startAction(
      name: '_WaterController.addWater',
    );
    try {
      return super.addWater(amountInMl);
    } finally {
      _$_WaterControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeWater(String id) {
    final _$actionInfo = _$_WaterControllerActionController.startAction(
      name: '_WaterController.removeWater',
    );
    try {
      return super.removeWater(id);
    } finally {
      _$_WaterControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateGoal(int newGoal) {
    final _$actionInfo = _$_WaterControllerActionController.startAction(
      name: '_WaterController.updateGoal',
    );
    try {
      return super.updateGoal(newGoal);
    } finally {
      _$_WaterControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
intakes: ${intakes},
goal: ${goal},
totalConsumed: ${totalConsumed},
progress: ${progress}
    ''';
  }
}
