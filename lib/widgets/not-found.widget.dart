import 'package:flutter/material.dart';

Widget notFoundWidget(BuildContext context) {
  return Center(
    child: Card(
      margin: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Text('What you are looking for does not exist.'),
      ),
    ),
  );
}
