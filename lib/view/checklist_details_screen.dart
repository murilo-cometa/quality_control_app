import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quality_control_app/common/component/simple_navigating_item_card.dart';
import 'package:quality_control_app/common/component/simple_selectable_card_item.dart';

class ChecklistDetailsScreen extends StatefulWidget {
  const ChecklistDetailsScreen({
    super.key,
    required this.taskIndex,
  });

  final int taskIndex;

  @override
  State<ChecklistDetailsScreen> createState() => _ChecklistDetailsScreenState();
}

class _ChecklistDetailsScreenState extends State<ChecklistDetailsScreen> {
  TextEditingController commentController = TextEditingController();
  late final CollectionReference _myDB;

  @override
  void initState() {
    _myDB = FirebaseFirestore.instance.collection('tasks');
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

              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildCardTitle(title: title, rating: rating, docID: id),
                    const Divider(), //-----------------------------------------------
                    const Text(
                      'Descrição',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SimpleNavigatingCardItem(
                      text: description,
                    ),
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
                          return SimpleSelectableCardItem(
                              text: comments[index]);
                        },
                      ),
                    ),
                    TextField(
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
            Text(
              title,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
            RatingBar(
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

  Future<void> _update({
    required String docID,
    required Map<Object, Object?> data,
  }) async{
    await _myDB.doc(docID).update(data);
  }

  Future<void> _create({
    required Map<Object, Object?> data,
  }) async {
    await _myDB.add(data);
  }

}
