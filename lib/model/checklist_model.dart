import 'package:quality_control_app/model/task_model.dart';

class Checklist {
  Checklist({
    required this.title,
    required this.tasks,
  });

  final String title;
  final List<Task> tasks;
}
