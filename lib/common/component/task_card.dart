import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quality_control_app/common/library/custom_navigator.dart';
import 'package:quality_control_app/view/checklist_details_screen.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    this.description,
  });

  final String task;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: const Icon(Icons.comment),
        title: Center(child: Text(task)),
        trailing: RatingBar(
          glow: false,
          allowHalfRating: true,
          itemSize: 25,
          onRatingUpdate: (value) {
            debugPrint('$value');
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
        onTap: () {
          CustomNavigator.goTo(
            context: context,
            destination: ChecklistDetailsScreen(
              title: task,
              description: description,
            ),
          );
        },
      ),
    );
  }
}
