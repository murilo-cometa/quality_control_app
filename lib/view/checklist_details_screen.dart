import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quality_control_app/common/component/simple_navigating_item_card.dart';
import 'package:quality_control_app/common/component/simple_selectable_card_item.dart';

class ChecklistDetailsScreen extends StatefulWidget {
  const ChecklistDetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.rating,
  });

  final double rating;
  final String title;
  final String description;

  @override
  State<ChecklistDetailsScreen> createState() => _ChecklistDetailsScreenState();
}

class _ChecklistDetailsScreenState extends State<ChecklistDetailsScreen> {
  late double finalRating;
  List<Widget> comments = [];
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    finalRating = widget.rating;
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
            Navigator.pop(context, finalRating);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildCardTitle(),
            const Divider(),
            const Text(
              'Descrição',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SimpleNavigatingCardItem(
              text: widget.description,
            ),
            const Divider(),
            const Text(
              'Comentários',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: comments,
              ),
            ),
            TextField(
              controller: commentController,
              decoration: const InputDecoration(
                hintText: 'Escreva seu comentário...',
                suffixIcon: Icon(Icons.comment),
              ),
              onSubmitted: (value) {
                setState(() {
                  comments += [SimpleSelectableCardItem(text: value)];
                  commentController.clear();
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Row _buildCardTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
            RatingBar(
              initialRating: widget.rating,
              glow: false,
              allowHalfRating: true,
              itemSize: 30,
              onRatingUpdate: (value) {
                setState(() {
                  finalRating = value;
                });
              },
              ratingWidget: RatingWidget(
                full: const Icon(
                  Icons.star,
                  // color: Colors.yellow,
                ),
                half: const Icon(
                  Icons.star_half,
                  // color: Colors.yellow,
                ),
                empty: const Icon(
                  Icons.star_border,
                ),
              ),
            ),
          ],
        ),
        // const SizedBox(width: 50),
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
}
