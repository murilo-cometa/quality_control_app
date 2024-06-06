import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quality_control_app/common/component/custom_appbar.dart';
import 'package:quality_control_app/common/component/simple_navigating_item_card.dart';
import 'package:quality_control_app/view/checklist.dart';

class AppliedChecklistsScreen extends StatelessWidget {
  AppliedChecklistsScreen({super.key});

  final _random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build('Checklists aplicados'),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          int storeCode = _random.nextInt(40) + 1;
          int checklistType = _random.nextInt(10) + 1;
          String title = '$checklistType na loja $storeCode';
          return SimpleNavigatingCardItem(
            text: title,
            goTo: Checklist(
              editMode: false,
              title: title,
            ),
          );
        },
      ),
    );
  }
}
