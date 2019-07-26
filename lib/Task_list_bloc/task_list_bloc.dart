import 'dart:async';
import 'task_list_event.dart';

class TaskListBloc {
  bool _enableFilters = false;
  String _currentFilter = 'all';

  final _setFiltersStateController = StreamController<String>();
  StreamSink<String> get _inSetFilters => _setFiltersStateController.sink;
  Stream<String> get setFilters => _setFiltersStateController.stream;

  final _enableFiltersStateController = StreamController<bool>();
  StreamSink<bool> get _inEnableFilters => _enableFiltersStateController.sink;
  Stream<bool> get enableFilters => _enableFiltersStateController.stream;

  final _taskListEventController = StreamController<TaskListEvent>();
  Sink<TaskListEvent> get taskListEventSink => _taskListEventController.sink;

  TaskListBloc() {
    _taskListEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(TaskListEvent event) {
    if (event is EnableFiltersEvent) {
      if (event is EnableFiltersF) _enableFilters = false;

      if (event is EnableFiltersT) _enableFilters = true;
      _inEnableFilters.add(_enableFilters);
    }
    if (event is SetFilterEvent) {
      if (event is SetFilterAll) _currentFilter = 'all';
      if (event is SetFilterAllWithDay) _currentFilter = 'allwithday';
      if (event is SetFilterAllWithNoDay) _currentFilter = 'allwithnoday';
      if (event is SetFilterMon) _currentFilter = 'mon';
      if (event is SetFilterTue) _currentFilter = 'tue';
      if (event is SetFilterWed) _currentFilter = 'wed';
      if (event is SetFilterThu) _currentFilter = 'thu';
      if (event is SetFilterFri) _currentFilter = 'fri';
      if (event is SetFilterSat) _currentFilter = 'sat';
      if (event is SetFilterSun) _currentFilter = 'sun';
      _inSetFilters.add(_currentFilter);
    }
  }

  void dispose() {
    _setFiltersStateController.close();
    _enableFiltersStateController.close();
    _taskListEventController.close();
  }
}
