import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quality_control_app/common/component/custom_appbar.dart';
import 'package:quality_control_app/common/component/task_card.dart';

class ChecklistWithDb extends StatefulWidget {
  const ChecklistWithDb({
    super.key,
    required this.editMode,
  });

  final bool editMode;

  @override
  State<ChecklistWithDb> createState() => _ChecklistWithDbState();
}

class _ChecklistWithDbState extends State<ChecklistWithDb> {
  final CollectionReference _myDB =
      FirebaseFirestore.instance.collection('tasks');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build('checklist'),
      body: Column(
        children: [
          const Text(
            'tarefas:',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const Divider(),
          StreamBuilder(
            stream: _myDB.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot doc = snapshot.data!.docs[index];
                      return Material(
                        child: TaskCard(
                          task: doc['title'],
                          description: doc['description'],
                          rating: doc['rating'].toDouble(),
                          editMode: true,
                        ),
                      );
                    },
                  ),
                );
              }
              return const Center(
                child: Text('Sem tarefas'),
              );
            },
          )
        ],
      ),
    );
  }
}
