import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/notes.page.dart';
import 'package:flutter_todo/pages/settings.page.dart';
import 'package:flutter_todo/pages/tasks.page.dart';
import 'package:flutter_todo/pages/wrapper.page.dart';
import 'package:flutter_todo/transitions/slide-fade-up.transition.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return WrapperPage(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const TasksPage(),
              transitionsBuilder: slideFadeUpTransition,
            ),
          ),
          GoRoute(
            path: '/notes',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const NotesPage(),
              transitionsBuilder: slideFadeUpTransition,
            ),
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const SettingsPage(),
              transitionsBuilder: slideFadeUpTransition,
            ),
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Todo',
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      routerConfig: _router,
    );
  }
}
