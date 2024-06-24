import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quality_control_app/common/component/custom_appbar.dart';
import 'package:quality_control_app/common/library/custom_navigator.dart';
import 'package:quality_control_app/view/checklist_details_screen.dart';

class ChecklistWithDb extends StatefulWidget {
  const ChecklistWithDb({
    super.key,
    required this.editMode,
    required this.documentID,
  });

  final String documentID;
  final bool editMode;

  @override
  State<ChecklistWithDb> createState() => _ChecklistWithDbState();
}

class _ChecklistWithDbState extends State<ChecklistWithDb> {
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  late final CollectionReference _myDB;

  @override
  void initState() {
    _myDB = FirebaseFirestore.instance.collection('checklists').doc(widget.documentID).collection('tasks');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build('checklist'),
      floatingActionButton: widget.editMode
          ? FloatingActionButton(
              backgroundColor: Colors.lightBlueAccent.shade100,
              onPressed: () => _createDialogBox(context: context),
              child: const Icon(Icons.add),
            )
          : null,
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
                      final String title = doc['title'];
                      final String id = doc.id;
                      final double rating = doc['rating'].toDouble();
                      return Material(
                        child: _buildTaskCard(
                          title: title,
                          rating: rating,
                          index: index,
                          docID: id,
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

  Widget _buildTaskCard({
    required String title,
    required String docID,
    required double rating,
    required int index,
  }) {
    return Card(
      elevation: 3,
      child: ListTile(
        onLongPress: () {
          _deleteDialogBox(context: context, docID: docID);
        },
        title: Center(child: Text(title)),
        leading: widget.editMode
            ? const Icon(Icons.edit)
            : const Icon(Icons.comment),
        trailing: RatingBar(
          initialRating: rating,
          glow: false,
          allowHalfRating: true,
          itemSize: 25,
          onRatingUpdate: (value) {
            Map<Object, Object?> data = {'rating': value};
            _myDB.doc(docID).update(data);
          },
          ratingWidget: RatingWidget(
            full: const Icon(
              Icons.star,
            ),
            half: const Icon(
              Icons.star_half,
            ),
            empty: const Icon(
              Icons.star_border,
            ),
          ),
        ),
        onTap: () {
          CustomNavigator.goTo(
            context: context,
            destination: ChecklistDetailsScreen(
              taskIndex: index,
              documentID: widget.documentID,
              editMode: true,
            ),
          );
        },
      ),
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
                    'Deseja realmente deletar a tarefa?\nEssa ação é irreversível'),
                const SizedBox(
                  height: 15,
                ),
                FilledButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  child: const Text('Deletar'),
                  onPressed: () async {
                    _myDB
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
                        _descriptionController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Não deixe campos vazios!!!'),
                        ),
                      );
                    } else {
                      await _myDB.add({
                        'title': _taskTitleController.text,
                        'description': _descriptionController.text,
                        'checklist':
                            'teste de add', // TODO: IMPLEMENTAR OS CAMPOS ABAIXO
                        'rating': 0,
                        'comments': [],
                        'stores': [],
                      }).then((value) {
                        _taskTitleController.clear();
                        _descriptionController.clear();
                        Navigator.pop(context);
                      });
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
}
