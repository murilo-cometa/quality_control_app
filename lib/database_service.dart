import 'package:cloud_firestore/cloud_firestore.dart';

const String collectionPath = 'tasks';

class TasksDB {
  final _myDB = FirebaseFirestore.instance.collection(collectionPath);

  Future<void> addTask(Map<String, dynamic> data) async {
    await _myDB.add(data).then(
          (DocumentReference doc) =>
              print('DocumentSnapshot added with ID: ${doc.id}'),
        );
  }

 Future<QuerySnapshot<Map<String, dynamic>>> getTasks() async{
  return _myDB.get();
 }
}
