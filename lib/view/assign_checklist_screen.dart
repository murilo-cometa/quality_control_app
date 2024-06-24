import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:quality_control_app/common/component/custom_appbar.dart';
import 'package:quality_control_app/view/checklist_with_db.dart';

class AssignChecklistScreen extends StatefulWidget {
  const AssignChecklistScreen({
    super.key,
    this.availableChecklists,
  });
  final List<Widget>? availableChecklists;

  @override
  State<AssignChecklistScreen> createState() => _AssignChecklistScreenState();
}

class _AssignChecklistScreenState extends State<AssignChecklistScreen> {
  final CollectionReference _myDB =
      FirebaseFirestore.instance.collection('checklists');
  int _selectedStore = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build('Atribuir Checklist'),
      body: Column(
        children: [
          _buildStorePicker(),
          const Divider(), //--------------------------------------------------------------------------------------------
          _buildChecklistsListTitle(),
          StreamBuilder(
            stream: _myDB.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot doc = snapshot.data!.docs[index];
                      final String checklistName = doc['name'];
                      final String id = doc.id;
                      return Card(
                        elevation: 3,
                        child: ListTile(
                          title: Text(checklistName),
                          leading: IconButton(
                              onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChecklistWithDb(
                                        editMode: true,
                                        documentID: id,
                                        checklistName: checklistName,
                                      ),
                                    ),
                                  ),
                              icon: const Icon(Icons.edit)),
                        ),
                      );
                    },
                  ),
                );
              }
              return const Center(
                child: Text('Sem checklists'),
              );
            },
          ),
        ],
      ),
    );
  }

  SizedBox _buildChecklistsListTitle() {
    return SizedBox(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Escolha a o tipo de checklist',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xFFFFE8A4)),
            ),
            child: const Text('Salvar'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Column _buildStorePicker() {
    return Column(
      children: [
        const SizedBox(
          height: 35,
          child: Text(
            'Escolha a loja',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        NumberPicker(
          haptics: true,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue),
          ),
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
      ],
    );
  }
}
