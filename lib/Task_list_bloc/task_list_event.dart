abstract class TaskListEvent {}

class EnableFiltersEvent extends TaskListEvent {}

class EnableFiltersT extends EnableFiltersEvent {}

class EnableFiltersF extends EnableFiltersEvent {}

class SetFilterEvent extends TaskListEvent {}

class SetFilterAll extends SetFilterEvent {}

class SetFilterAllWithDay extends SetFilterEvent {}

class SetFilterAllWithNoDay extends SetFilterEvent {}

class SetFilterMon extends SetFilterEvent {}

class SetFilterTue extends SetFilterEvent {}

class SetFilterWed extends SetFilterEvent {}

class SetFilterThu extends SetFilterEvent {}

class SetFilterFri extends SetFilterEvent {}

class SetFilterSat extends SetFilterEvent {}

class SetFilterSun extends SetFilterEvent {}
