import 'package:flutter/material.dart';
import 'task_add_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/Widgets/widgets.dart';
import 'package:todo_app/Task_list_bloc/task_list_bloc.dart';
import 'package:todo_app/Task_list_bloc/task_list_event.dart';
import 'package:todo_app/models/models.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODOapp',
      theme: ThemeData(
        primarySwatch: Colors.red,
        canvasColor: Colors.redAccent,
      ),
      home: MyHomePage(title: 'TODOapp'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _firestore = Firestore.instance;
  final _bloc = TaskListBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder(
          stream: _bloc.setFilters,
          initialData: 'all',
          builder: (BuildContext context,
              AsyncSnapshot<String> snapshotCurrentFilter) {
            return StreamBuilder(
              stream: _bloc.enableFilters,
              initialData: false,
              builder: (BuildContext context,
                  AsyncSnapshot<bool> snapshotFilterEnabled) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ChooseBox(
                      'Filters:',
                      height: 32,
                      onTap: snapshotFilterEnabled.data
                          ? () => _bloc.taskListEventSink.add(EnableFiltersF())
                          : () => _bloc.taskListEventSink.add(EnableFiltersT()),
                    ),
                    SizedBox(height: 1),
                    snapshotFilterEnabled.data
                        ? Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  ChooseBoxE(
                                    'all',
                                    isActive:
                                        snapshotCurrentFilter.data == 'all',
                                    onTap: () => _bloc.taskListEventSink
                                        .add(SetFilterAll()),
                                  ),
                                  SizedBox(width: 1),
                                  ChooseBoxE(
                                    'all w/day',
                                    isActive: snapshotCurrentFilter.data ==
                                        'allwithday',
                                    onTap: () => _bloc.taskListEventSink
                                        .add(SetFilterAllWithDay()),
                                  ),
                                  SizedBox(width: 1),
                                  ChooseBoxE(
                                    'all w/no day',
                                    isActive: snapshotCurrentFilter.data ==
                                        'allwithnoday',
                                    onTap: () => _bloc.taskListEventSink
                                        .add(SetFilterAllWithNoDay()),
                                  )
                                ],
                              ),
                              SizedBox(height: 1),
                              Row(
                                children: <Widget>[
                                  ChooseBoxE(
                                    'Mon',
                                    isActive:
                                        snapshotCurrentFilter.data == 'mon',
                                    onTap: () => _bloc.taskListEventSink
                                        .add(SetFilterMon()),
                                  ),
                                  SizedBox(width: 1),
                                  ChooseBoxE(
                                    'Tue',
                                    isActive:
                                        snapshotCurrentFilter.data == 'tue',
                                    onTap: () => _bloc.taskListEventSink
                                        .add(SetFilterTue()),
                                  ),
                                  SizedBox(width: 1),
                                  ChooseBoxE(
                                    'Wed',
                                    isActive:
                                        snapshotCurrentFilter.data == 'wed',
                                    onTap: () => _bloc.taskListEventSink
                                        .add(SetFilterWed()),
                                  ),
                                  SizedBox(width: 1),
                                  ChooseBoxE(
                                    'Thu',
                                    isActive:
                                        snapshotCurrentFilter.data == 'thu',
                                    onTap: () => _bloc.taskListEventSink
                                        .add(SetFilterThu()),
                                  ),
                                  SizedBox(width: 1),
                                  ChooseBoxE(
                                    'Fri',
                                    isActive:
                                        snapshotCurrentFilter.data == 'fri',
                                    onTap: () => _bloc.taskListEventSink
                                        .add(SetFilterFri()),
                                  ),
                                  SizedBox(width: 1),
                                  ChooseBoxE(
                                    'Sat',
                                    isActive:
                                        snapshotCurrentFilter.data == 'sat',
                                    onTap: () => _bloc.taskListEventSink
                                        .add(SetFilterSat()),
                                  ),
                                  SizedBox(width: 1),
                                  ChooseBoxE(
                                    'Sun',
                                    isActive:
                                        snapshotCurrentFilter.data == 'sun',
                                    onTap: () => _bloc.taskListEventSink
                                        .add(SetFilterSun()),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Container(),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _firestore.collection('tasks').snapshots(),
                        builder: (context, snapshot) {
                          List<TaskTODO> _taskListTODO = [];
                          if (snapshot.hasData) {
                            for (var task in snapshot.data.documents) {
                              var newTask = TaskTODO(
                                title: task.data['title'],
                                description: task.data['description'],
                                day: task.data['day'],
                              );
                              _taskListTODO.add(newTask);
                            }
                          }
                          List<Widget> taskList = [];
                          for (var task in _taskListTODO) {
                            var newTask = Task(
                                title: task.title,
                                description: task.description,
                                isDayType: task.day != null ? true : false,
                                day: task.day);
                            if (snapshotFilterEnabled.data == false)
                              taskList.add(newTask);
                            else {
                              if (snapshotCurrentFilter.data == 'all')
                                taskList.add(newTask);
                              if (snapshotCurrentFilter.data ==
                                  'allwithday') if (task.day != null)
                                taskList.add(newTask);
                              if (snapshotCurrentFilter.data ==
                                  'allwithnoday') if (task.day == null)
                                taskList.add(newTask);
                              if (snapshotCurrentFilter.data ==
                                  'mon') if (task.day == 'Monday')
                                taskList.add(newTask);
                              if (snapshotCurrentFilter.data ==
                                  'tue') if (task.day == 'Tuesday')
                                taskList.add(newTask);
                              if (snapshotCurrentFilter.data ==
                                  'wed') if (task.day == 'Wednesday')
                                taskList.add(newTask);
                              if (snapshotCurrentFilter.data ==
                                  'thu') if (task.day == 'Thursday')
                                taskList.add(newTask);
                              if (snapshotCurrentFilter.data ==
                                  'fri') if (task.day == 'Friday')
                                taskList.add(newTask);
                              if (snapshotCurrentFilter.data ==
                                  'sat') if (task.day == 'Saturday')
                                taskList.add(newTask);
                              if (snapshotCurrentFilter.data ==
                                  'sun') if (task.day == 'Sunday')
                                taskList.add(newTask);
                            }
                          }

                          return ListView(
                            children: taskList,
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => TaskAddPage())),
        child: Icon(Icons.add_to_photos),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
