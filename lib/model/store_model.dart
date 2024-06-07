import 'package:quality_control_app/model/checklist_model.dart';

class Store {
  Store({
    required this.assignedCkeclists,
    required this.storeNumber,
  });
  final List<Checklist> assignedCkeclists;
  final int storeNumber;
}
