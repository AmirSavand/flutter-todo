import 'package:flutter/material.dart';
import 'package:flutter_todo/models/models.dart';
import 'package:go_router/go_router.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  late List<Task> _tasks = [];

  final TextEditingController _taskInputController = TextEditingController();

  void _setup() {
    Task.store.items.then((List<Task> value) {
      setState(() {
        _tasks = value;
      });
    });
  }

  void _unFocusInput() {
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();
    _setup();
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
                    icon: Icon(task.icon),
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
                  trailing: IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () async {
                      await context.push('/task/${task.id}');
                      _setup();
                    },
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
                border: OutlineInputBorder(),
                hintText: 'Create a new task',
              ),
              onTapOutside: (_) => _unFocusInput(),
              onSubmitted: (String value) {
                _taskInputController.clear();
                _unFocusInput();
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
