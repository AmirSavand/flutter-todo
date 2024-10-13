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

  final TextEditingController _taskInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Flutter Todo',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
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
                  _tasks.add(Task(title: value));
                });
              },
            ),
          )
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
