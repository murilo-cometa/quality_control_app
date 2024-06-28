import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:quality_control_app/common/component/custom_appbar.dart';
import 'package:quality_control_app/common/library/custom_navigator.dart';
import 'package:quality_control_app/view/checklist_with_db.dart';

class ApplyChecklistScreen extends StatefulWidget {
  const ApplyChecklistScreen({super.key});

  @override
  State<ApplyChecklistScreen> createState() => _ApplyChecklistScreenState();
}

class _ApplyChecklistScreenState extends State<ApplyChecklistScreen> {
  int _selectedStore = 1;

  // travou a aplicação :(

  @override
  Widget build(BuildContext context) {
    final CollectionReference myDB = FirebaseFirestore.instance
        .collection('stores')
        .doc(_selectedStore.toString())
        .collection('checklists');
    return Scaffold(
      appBar: CustomAppBar.build('Aplicar checklist'),
      body: Column(
        children: [
          const Text(
            'Escolha a loja',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          NumberPicker(
            haptics: true,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue)),
            infiniteLoop: true,
            itemWidth: 70,
            itemCount: 5,
            axis: Axis.horizontal,
            minValue: 1,
            maxValue: 40,
            value: _selectedStore,
            onChanged: (value) {
              setState(() {
                _selectedStore = value;
              });
            },
          ),
          const Divider(),
          StreamBuilder(
            stream: myDB.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = snapshot.data!.docs[index];
                    String title = doc['title'];
                    String id = doc.id;
                    return Card(
                      elevation: 3,
                      child: ListTile(
                        title: Text(title),
                        onTap: () {
                          CustomNavigator.goTo(
                            context: context,
                            destination: ChecklistWithDb(
                                editMode: false,
                                checklistName: title,
                                collection: myDB.doc(id).collection('tasks')),
                          );
                        },
                      ),
                    );
                  },
                );
              }
              return const Center(
                child: Text('não há checklists'),
              );
            },
          )
        ],
      ),
    );
  }
}
