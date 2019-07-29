import 'package:flutter/material.dart';
import 'package:todo_app/Widgets/InputBox.dart';
import 'package:todo_app/Task_add_bloc/task_add.dart';
import 'Firebase_repository.dart';
import 'models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskAddPage extends StatefulWidget {
  @override
  _TaskAddPageState createState() => _TaskAddPageState();
}

class _TaskAddPageState extends State<TaskAddPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskAddBloc>(
      builder: (context) => TaskAddBloc(),
      child: AddTaskPage(),
    );
  }
}

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String chosenDay = 'Monday';

  String title;

  String description;

  @override
  Widget build(BuildContext context) {
    final taskAddBloc = BlocProvider.of<TaskAddBloc>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          InputBox(
            text: 'Title',
            onChanged: (textOutput) {
              title = textOutput;
            },
          ),
          InputBox(
            text: 'Description',
            onChanged: (textOutput) {
              description = textOutput;
            },
          ),
          BlocBuilder<TaskAddBloc, TaskAddState>(
            builder: (context, state) {
              return InputBox(
                onClick: state == DaySelectionEnabled()
                    ? () => taskAddBloc.dispatch(DisableDaySelection())
                    : () => taskAddBloc.dispatch(EnableDaySelection()),
                text: '',
                isTextbox: false,
                childIfNotTextBox: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        state == DaySelectionEnabled()
                            ? Icons.gps_fixed
                            : Icons.gps_not_fixed,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'enable day selection',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          BlocBuilder<TaskAddBloc, TaskAddState>(
            builder: (context, state) {
              return InputBox(
                text: 'Choose day',
                isTextField: false,
                isVisible: state == DaySelectionEnabled(),
                childIfNotTextField: DropdownButton<String>(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                  value: chosenDay,
                  items: <String>[
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Thursday',
                    'Friday',
                    'Saturday',
                    'Sunday',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      chosenDay = newValue;
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<TaskAddBloc, TaskAddState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              FirebaseRepository.addTask(TaskTODO(
                  title: title,
                  description: description,
                  day: state == DaySelectionEnabled() ? chosenDay : null));
              Navigator.pop(context);
            },
            child: Container(
              height: 100,
              width: 100,
              alignment: Alignment(1, 0),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Make a new task',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add new Task'),
      ),
    );
  }
}
