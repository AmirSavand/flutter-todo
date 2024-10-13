import 'package:uuid/uuid.dart';

/// A class representing a Task.
class Task {
  /// Unique ID of the task, generated using UUID v4.
  final String id = (const Uuid()).v4();

  /// The date and time when the task was created.
  final DateTime created = DateTime.now();

  /// The title or name of the task.
  String title;

  /// A flag indicating whether the task is completed or not.
  bool done = false;

  Task({
    required this.title,
  });
}
