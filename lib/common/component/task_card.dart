import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quality_control_app/view/checklist_details_screen.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.description,
    this.leading,
    this.editMode = false,
    this.rating = 0.0, required this.index,
  });

  final Widget? leading;
  final String task;
  final String description;
  final bool editMode;
  final double rating;
  final int index;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late double rating;

  @override
  void initState() {
    rating = widget.rating;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: widget.editMode
            ? const Icon(Icons.edit)
            : const Icon(Icons.comment),
        title: Center(child: Text(widget.task)),
        trailing: RatingBar(
          initialRating: rating,
          glow: false,
          allowHalfRating: true,
          itemSize: 25,
          onRatingUpdate: (value) {
            setState(() {
              rating = value;
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
        onTap: () async {
          final double newRating = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChecklistDetailsScreen(taskIndex: widget.index,editMode: true,),
            ),
          );

          setState(() {
            rating = newRating;
          });
        },
      ),
    );
  }
}
