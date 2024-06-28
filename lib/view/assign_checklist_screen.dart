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
  final TextEditingController _checklistNameController =
      TextEditingController();
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final CollectionReference _checklistsCollection =
      FirebaseFirestore.instance.collection('checklists');
  final CollectionReference _storesCollection =
      FirebaseFirestore.instance.collection('stores');

  int _selectedStore = 1;
  final List<String> _selectedChecklists = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build('Atribuir Checklist'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent.shade100,
        onPressed: () => _createDialogBox(context: context),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          _buildStorePicker(),
          const Divider(), //--------------------------------------------------------------------------------------------
          _buildChecklistsListSectionTitle(),
          StreamBuilder(
            stream: _checklistsCollection.snapshots(),
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
                      return _buildChecklistItem(
                        context: context,
                        id: id,
                        checklistName: checklistName,
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

  Widget _buildChecklistItem({
    required BuildContext context,
    required String id,
    required String checklistName,
  }) {
    bool isSelected = _selectedChecklists.contains(id);
    return Card(
      color: isSelected ? Colors.green : null,
      elevation: 3,
      child: ListTile(
        selectedColor: Colors.white,
        selected: isSelected,
        title: Text(checklistName),
        onLongPress: () {
          _deleteDialogBox(context: context, docID: id);
        },
        onTap: () {
          setState(() {
            isSelected
                ? _selectedChecklists.remove(id)
                : _selectedChecklists.add(id);
          });
        },
        leading: IconButton(
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChecklistWithDb(
                      editMode: true,
                      checklistName: checklistName,
                      collection: _checklistsCollection.doc(id).collection('tasks'),
                    ),
                  ),
                ),
            icon: const Icon(Icons.edit)),
      ),
    );
  }

  SizedBox _buildChecklistsListSectionTitle() {
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
            onPressed: () async {
              await _saveButtonAction();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _saveButtonAction() async {
    if (_selectedChecklists.isNotEmpty) {
      for (final checklistID in _selectedChecklists) {
        DocumentSnapshot<Object?> checklistToAdd =
            await _checklistsCollection.doc(checklistID).get();
        Map<String, dynamic> data = {'name': checklistToAdd['name']};
        DocumentReference newDoc = await _storesCollection
            .doc(_selectedStore.toString())
            .collection('checklists')
            .add(data);
        _checklistsCollection.doc(checklistID).collection('tasks').get().then(
          (value) {
            for (var doc in value.docs) {
                Map<String, dynamic> taskData = {
                  'title': doc['title'],
                  'description': doc['description'],
                  'rating': doc['rating'],
                  'comments': doc['comments']
                };
                newDoc.collection('tasks').add(taskData);
              }
          },
        );
        debugPrint(checklistToAdd.data().toString());
      }
      setState(() {
        _selectedChecklists.clear();
      });
      _showSuccessSnackBar();
    }
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

  Future<void> _createDialogBox({
    required BuildContext context,
  }) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Escreva o nome do checklist:',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                TextField(
                  controller: _checklistNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Escreva aqui...',
                  ),
                ),
                const Divider(
                  height: 50,
                ),
                const Text(
                  'Escreva o título da tarefa:',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                TextField(
                  controller: _taskTitleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Escreva aqui...',
                  ),
                ),
                const Divider(
                  height: 50,
                ),
                const Text(
                  'Escreva a descrição:',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Escreva aqui...',
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                FilledButton(
                  child: const Text('Salvar'),
                  onPressed: () async {
                    if (_taskTitleController.text.isEmpty ||
                        _descriptionController.text.isEmpty ||
                        _checklistNameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Não deixe campos vazios!!!'),
                        ),
                      );
                    } else {
                      DocumentReference newDoc = await _checklistsCollection
                          .add({'name': _checklistNameController.text});
                      _checklistsCollection
                          .doc(newDoc.id)
                          .collection('tasks')
                          .add(
                        {
                          'title': _taskTitleController.text,
                          'description': _descriptionController.text,
                          'rating': 0,
                          'comments': [],
                        },
                      ).then(
                        (value) {
                          _checklistNameController.clear();
                          _taskTitleController.clear();
                          _descriptionController.clear();
                          Navigator.pop(context);
                        },
                      );
                    }
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _deleteDialogBox(
      {required BuildContext context, required String docID}) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                    'Deseja realmente deletar a Checklist?\nEssa ação é irreversível'),
                const SizedBox(
                  height: 15,
                ),
                FilledButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  child: const Text('Deletar'),
                  onPressed: () async {
                    _checklistsCollection
                        .doc(docID)
                        .delete()
                        .then((value) => Navigator.pop(context));
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Atribuído com sucesso'),
      ),
    );
  }
}
