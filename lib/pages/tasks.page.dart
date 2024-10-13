import 'package:flutter/material.dart';
import 'package:flutter_todo/models/task.model.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final List<Task> _tasks = [
    Task(title: 'Learn Flutter immediately'),
    Task(title: 'Use ChatGPT and Google for resources'),
    Task(title: 'Create task list page'),
    Task(title: 'Create task detail page'),
    Task(title: 'Save tasks to storage', done: true),
    Task(title: 'Load tasks from storage', done: true),
    Task(title: 'Add task create modal'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Flutter Todo'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.all(16)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Todos',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
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
                      setState(() => task.done = !task.done);
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
        ],
      ),
    );
  }
}
