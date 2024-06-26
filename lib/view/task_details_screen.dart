import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quality_control_app/common/component/simple_selectable_card_item.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({
    super.key,
    required this.taskIndex,
    required this.editMode,
    required this.documentID,
  });

  final int taskIndex;
  final bool editMode;
  final String documentID;

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final TextEditingController commentController = TextEditingController();
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late final CollectionReference _myDB;
  bool editDescription = false;
  bool editTitle = false;

  @override
  void initState() {
    _myDB = FirebaseFirestore.instance
        .collection('checklists')
        .doc(widget.documentID)
        .collection('tasks');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 232, 164),
        centerTitle: true,
        title: const Text(
          'Detalhes da tarefa',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder(
          stream: _myDB.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final DocumentSnapshot doc =
                  snapshot.data!.docs[widget.taskIndex];

              final String title = doc['title'];
              final String id = doc.id;
              final String description = doc['description'];
              final double rating = doc['rating'].toDouble();
              final List<dynamic> comments = doc['comments'];
              _taskTitleController.text = title;
              _descriptionController.text = description;

              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildCardTitle(title: title, rating: rating, docID: id),
                    const Divider(), //-----------------------------------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Descrição',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        if (widget.editMode)
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              setState(() {
                                editDescription = !editDescription;
                              });
                            },
                          ),
                      ],
                    ),
                    _buildDescriptionBox(description: description, docID: id),
                    const Divider(), //-----------------------------------------------
                    const Text(
                      'Comentários',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 3,
                            child: ListTile(
                              title: Text(comments[index]),
                              onLongPress: () {
                                _deleteDialogBox(
                                  context: context,
                                  docID: id,
                                  commentIndex: index,
                                  commentsList: comments,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    TextField(
                      enabled: !widget.editMode,
                      controller: commentController,
                      decoration: const InputDecoration(
                        hintText: 'Escreva seu comentário...',
                        suffixIcon: Icon(Icons.comment),
                      ),
                      onSubmitted: (value) {
                        List newComments = comments + [commentController.text];
                        Map<Object, Object?> data = {'comments': newComments};
                        _myDB.doc(id).update(data);
                        commentController.clear();
                      },
                    )
                  ],
                ),
              );
            }
            return const Center(
              child: Text('não foi possível obter os dados'),
            );
          }),
    );
  }

  Row _buildCardTitle({
    required String title,
    required String docID,
    required double rating,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Row(
              children: [
                if (editTitle)
                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: _taskTitleController,
                      textAlign: TextAlign.center,
                      autofocus: true,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) {
                        _update(
                            docID: docID,
                            data: {'title': _taskTitleController.text}).then(
                          (value) {
                            setState(() {
                              editTitle = !editTitle;
                            });
                          },
                        );
                      },
                    ),
                  )
                else
                  SizedBox(
                    width: 250,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                if (widget.editMode)
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        editTitle = !editTitle;
                      });
                    },
                  ),
              ],
            ),
            RatingBar(
              ignoreGestures: widget.editMode,
              initialRating: rating,
              glow: false,
              allowHalfRating: true,
              itemSize: 30,
              onRatingUpdate: (value) {
                _update(docID: docID, data: {'rating': value});
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
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.image,
            size: 40,
          ),
        )
      ],
    );
  }

  Widget _buildDescriptionBox({
    required String description,
    required String docID,
  }) {
    if (editDescription) {
      return Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: TextField(
            autofocus: true,
            decoration: const InputDecoration(border: InputBorder.none),
            controller: _descriptionController,
            onSubmitted: (value) {
              _update(
                      docID: docID,
                      data: {'description': _descriptionController.text})
                  .then((value) => setState(() {
                        editDescription = !editDescription;
                      }));
            },
          ),
        ),
      );
    }
    return SimpleSelectableCardItem(text: description);
  }

  Future<void> _deleteDialogBox({
    required BuildContext context,
    required String docID,
    required int commentIndex,
    required List<dynamic> commentsList,
  }) {
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
                    'Deseja realmente deletar o comentário?\nEssa ação é irreversível'),
                const SizedBox(
                  height: 15,
                ),
                FilledButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  child: const Text('Deletar'),
                  onPressed: () async {
                    List newList = commentsList;
                    newList.removeAt(commentIndex);
                    _myDB.doc(docID).update({'comments': newList}).then(
                        (value) => Navigator.pop(context));
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _update({
    required String docID,
    required Map<Object, Object?> data,
  }) async {
    await _myDB.doc(docID).update(data);
  }

  // Future<void> _create({
  //   required Map<Object, Object?> data,
  // }) async {
  //   await _myDB.add(data);
  // }
}
