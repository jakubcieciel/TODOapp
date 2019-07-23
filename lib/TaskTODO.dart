import 'package:flutter/material.dart';

class TaskTODO {
  final String title;
  final String description;
  final String day;
  final String id;

  TaskTODO({this.title, this.description, this.day, this.id});
}

class Task extends StatelessWidget {
  final String title;
  final String description;
  final String day;
  final bool isDayType;
  final String id;
  Task(
      {this.isDayType = true, this.description, this.title, this.day, this.id});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: EdgeInsets.only(left: 8.0, top: 4, bottom: 8),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.close,
                      size: 15,
                      color: Colors.white,
                    ),
                    Text(
                      title,
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Text(
                      description,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              isDayType
                  ? Expanded(
                      flex: 2,
                      child: Text(
                        day,
                        style: TextStyle(color: Colors.white, fontSize: 27),
                      ))
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
