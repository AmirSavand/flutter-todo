import 'package:uuid/uuid.dart';

import '../classes/store.dart';

/// A class representing a Task.
class Task {
  /// Store instance to manage tasks.
  static final store = Store<Task>(
    key: 'tasks',
    toJson: (Task item) => item.toJson(),
    fromJson: (Map<String, dynamic> item) => Task.fromJson(item),
  );

  /// UUID instance reference.
  static const _uuid = Uuid();

  /// Unique ID of the task, generated using UUID v4.
  final String id;

  /// The date and time when the task was created.
  final DateTime created;

  /// The title or name of the task.
  String title;

  /// A flag indicating whether the task is completed or not.
  bool done;

  Task._({
    required this.title,
    required this.id,
    required this.created,
    required this.done,
  });

  /// Convert a Task object to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created': created.toIso8601String(),
      'title': title,
      'done': done,
    };
  }

  /// Create a Task object from a JSON map.
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task._(
      id: json['id'],
      created: DateTime.parse(json['created']),
      title: json['title'],
      done: json['done'],
    );
  }

  static create({required String title}) {
    return Task._(
      id: _uuid.v4(),
      title: title,
      created: DateTime.now(),
      done: false,
    );
  }
}
