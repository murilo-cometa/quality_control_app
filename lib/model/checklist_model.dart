import 'package:quality_control_app/model/task_model.dart';

class Checklist {
  Checklist({
    required this.name,
    required this.tasks,
  });
  final String name;
  final List<Task> tasks;

  
}
