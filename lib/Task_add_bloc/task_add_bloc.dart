import 'dart:async';
import 'task_add_event.dart';

class TaskAddBloc {
  bool _enableDaySelection;

  final _enableDaySelectionStateController = StreamController<bool>();
  StreamSink<bool> get _inEnableDaySelection =>
      _enableDaySelectionStateController.sink;
  Stream<bool> get enableDaySelection =>
      _enableDaySelectionStateController.stream;

  final _taskAddEventController = StreamController<TaskAddEvent>();
  Sink<TaskAddEvent> get taskAddEventSink => _taskAddEventController.sink;

  TaskAddBloc() {
    _taskAddEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(TaskAddEvent event) {
    if (event is DisplayDaySelectionF) _enableDaySelection = false;

    if (event is DisplayDaySelectionT) _enableDaySelection = true;
    _inEnableDaySelection.add(_enableDaySelection);
  }

  void dispose() {
    _enableDaySelectionStateController.close();
    _taskAddEventController.close();
  }
}
