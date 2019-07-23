import 'package:flutter/material.dart';
import 'package:todo_app/InputBox.dart';
import 'package:todo_app/Task_add_bloc/task_add_bloc.dart';
import 'Task_add_bloc/task_add_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskAddPage extends StatefulWidget {
  @override
  _TaskAddPageState createState() => _TaskAddPageState();
}

class _TaskAddPageState extends State<TaskAddPage> {
  final _bloc = TaskAddBloc();
  final _firestore = Firestore.instance;
  String chosenDay = 'Monday';
  String title;
  String description;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.enableDaySelection,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshotDSenabled) {
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
              InputBox(
                onClick: snapshotDSenabled.data
                    ? () => _bloc.taskAddEventSink.add(DisplayDaySelectionF())
                    : () => _bloc.taskAddEventSink.add(DisplayDaySelectionT()),
                text: '',
                isTextbox: false,
                childIfNotTextBox: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        snapshotDSenabled.data
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
              ),
              InputBox(
                text: 'Choose day',
                isTextField: false,
                isVisible: snapshotDSenabled.data,
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
              )
            ],
          ),
          floatingActionButton: GestureDetector(
            onTap: snapshotDSenabled.data
                ? () {
                    _firestore.collection('tasks').add({
                      'title': title,
                      'description': description,
                      'day': chosenDay,
                    });
                    Navigator.pop(context);
                  }
                : () {
                    _firestore.collection('tasks').add({
                      'title': title,
                      'description': description,
                      'day': null,
                    });
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
          ),
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Add new Task'),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
