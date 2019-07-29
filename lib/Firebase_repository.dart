import 'package:meta/meta.dart';
import 'package:todo_app/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRepository {
  static void addTask(TaskTODO task) {
    final _firestore = Firestore.instance;
    _firestore.collection('tasks').add({
      'title': task.title ?? '',
      'description': task.description ?? '',
      'day': task.day,
    });
  }
}
