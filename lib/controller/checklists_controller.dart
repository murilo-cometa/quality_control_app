import 'package:flutter/material.dart';

class ChecklistsManager extends ChangeNotifier {
  final List<Map> _tasks = [];
  List<Map> get tasks => _tasks;
}
