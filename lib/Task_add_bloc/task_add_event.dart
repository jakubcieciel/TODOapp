import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TaskAddEvent extends Equatable {
  TaskAddEvent([List props = const []]) : super(props);
}

class DisableDaySelection extends TaskAddEvent {
  @override
  String toString() => 'DisableDaySelection';
}

class EnableDaySelection extends TaskAddEvent {
  @override
  String toString() => 'EnableDaySelection';
}
