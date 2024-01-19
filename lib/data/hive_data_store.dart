import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_file_manager/models/task.dart';

class HiveDataStore {
  // Box name String
  static const boxName = 'taskBox';

  // Current Box with all the saved data inside
  final Box<Task> box = Hive.box<Task>(boxName);

  //Add a new task
  Future<void> addTask({required Task task}) async {
    await box.put(task.id, task);
  }

  /// Show task
  Future<Task?> getTask({required String id}) async {
    return box.get(id);
  }

  /// Update task
  Future<void> updateTask({required Task task}) async {
    await task.save();
  }

  /// Delete task
  Future<void> deleteTask({required Task task}) async {
    await task.delete();
  }


  ValueListenable<Box<Task>> listenToTask() {
    return box.listenable();
  }
}
