import 'package:flutter/material.dart';
import 'package:flutter_todo/models/task.model.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  late List<Task> _tasks = [];

  final TextEditingController _taskInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Task.store.items.then((List<Task> value) {
      setState(() {
        _tasks = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(top: 16)),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return ListTile(
                  leading: IconButton(
                    icon: Icon(
                      task.done ? Icons.task_alt : Icons.circle_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        task.done = !task.done;
                      });
                      Task.store.save();
                    },
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.done ? TextDecoration.lineThrough : null,
                      color: task.done
                          ? Theme.of(context).colorScheme.secondary
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _taskInputController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.task_alt),
                border: OutlineInputBorder(),
                hintText: 'Create a new task',
              ),
              onSubmitted: (String value) {
                _taskInputController.clear();
                setState(() {
                  Task newTask = Task.create(title: value);
                  Task.store.add(newTask);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _taskInputController.dispose();
  }
}
