import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quality_control_app/common/component/custom_appbar.dart';
import 'package:quality_control_app/common/component/simple_navigating_item_card.dart';

class ChecklistDetailsScreen extends StatelessWidget {
  const ChecklistDetailsScreen({
    super.key,
    required this.title,
    this.description,
  });

  final String title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build('Detalhes do checklist'),
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
              text: description ?? 'Sem descrição.',
            ),
            const Divider(),
            const Text(
              'Comentários',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const SimpleNavigatingCardItem(
                    text:
                        'Um simples comentário.',
                  );
                },
              ),
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
              title,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
            RatingBar(
              glow: false,
              allowHalfRating: true,
              itemSize: 30,
              onRatingUpdate: (value) {},
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
