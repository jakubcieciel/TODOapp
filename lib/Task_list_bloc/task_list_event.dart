abstract class TaskListEvent {}

class EnableFilters extends TaskListEvent {}

class EnableFiltersT extends EnableFilters {}

class EnableFiltersF extends EnableFilters {}

class SetFilter extends TaskListEvent {}

class SetFilterAll extends SetFilter {}

class SetFilterAllWithDay extends SetFilter {}

class SetFilterAllWithNoDay extends SetFilter {}

class SetFilterMon extends SetFilter {}

class SetFilterTue extends SetFilter {}

class SetFilterWed extends SetFilter {}

class SetFilterThu extends SetFilter {}

class SetFilterFri extends SetFilter {}

class SetFilterSat extends SetFilter {}

class SetFilterSun extends SetFilter {}
