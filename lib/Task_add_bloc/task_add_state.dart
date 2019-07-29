import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'task_add.dart';

abstract class TaskAddState extends Equatable {
  TaskAddState([List props = const []]) : super(props);
}

class DaySelectionEnabled extends TaskAddState {
  @override
  String toString() => 'DaySelectionEnabled';
}

class DaySelectionDisabled extends TaskAddState {
  @override
  String toString() => 'DaySelectionDisabled';
}
