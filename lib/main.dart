import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_todo/pages/pages.dart';
import 'package:flutter_todo/transitions/transitions.dart';
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
          _createRoute('tasks', '/', const TasksPage()),
          _createRouteWithId('task', '/task/:id', (id) => TaskPage(id: id)),
          _createRoute('notes', '/notes', const NotesPage()),
          _createRouteWithId('note', '/note/:id', (id) => NotePage(id: id)),
          _createRoute('settings', '/settings', const SettingsPage()),
        ],
      ),
    ],
  );

  /// Go route instance creator to avoid repetition.
  static GoRoute _createRoute(
    String name,
    String path,
    Widget child,
  ) {
    return GoRoute(
      name: name,
      path: path,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: child,
        transitionsBuilder: slideFadeUpTransition,
      ),
    );
  }

  // Same as _createRoute but for routes with ID.
  static GoRoute _createRouteWithId(
    String name,
    String path,
    Widget Function(String id) getWidget,
  ) {
    return GoRoute(
      name: name,
      path: path,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: getWidget(state.pathParameters['id'].toString()),
        transitionsBuilder: slideFadeUpTransition,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ));
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Todo',
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      routerConfig: _router,
    );
  }
}
