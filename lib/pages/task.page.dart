import 'package:flutter/material.dart';
import 'package:flutter_todo/models/models.dart';
import 'package:flutter_todo/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key, required this.id});

  final String id;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late Task? _task;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    Task.store.items.then((List<Task> tasks) {
      try {
        _task = tasks.firstWhere((Task item) => item.id == widget.id);
      } catch (error) {
        _task = null;
      }
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: loadingWidget);
    }
    if (_task == null) {
      return Scaffold(body: notFoundWidget(context));
    }
    Task task = _task!;
    return Scaffold(
      body: SingleChildScrollView(
        padding: notificationBarPadding(context),
        child: Card(
          margin: const EdgeInsets.all(16),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.done ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(
              'Created at ${DateFormat.yMd().add_jm().format(task.created)}',
            ),
            leading: IconButton(
              icon: Icon(task.icon),
              onPressed: () {
                setState(() {
                  task.done = !task.done;
                });
                Task.store.save();
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                // Remove the task
                await Task.store.remove(task);
                setState(() {
                  // Make a snackbar about it
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Your todo is now gone'),
                    duration: Duration(seconds: 3),
                  ));
                  // Go back
                  context.pop();
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
