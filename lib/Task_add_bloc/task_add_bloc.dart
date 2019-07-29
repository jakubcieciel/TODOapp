import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'task_add.dart';

class TaskAddBloc extends Bloc<TaskAddEvent, TaskAddState> {
  @override
  TaskAddState get initialState => DaySelectionDisabled();

  @override
  Stream<TaskAddState> mapEventToState(TaskAddEvent event) async* {
    if (event is DisableDaySelection) yield DaySelectionDisabled();

    if (event is EnableDaySelection) yield DaySelectionEnabled();
  }
}
