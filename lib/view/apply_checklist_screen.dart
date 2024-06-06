import 'dart:math';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:quality_control_app/common/component/custom_appbar.dart';
import 'package:quality_control_app/common/component/simple_navigating_item_card.dart';
import 'package:quality_control_app/view/checklist.dart';

class ApplyChecklistScreen extends StatefulWidget {
  const ApplyChecklistScreen({super.key});

  @override
  State<ApplyChecklistScreen> createState() => _ApplyChecklistScreenState();
}

class _ApplyChecklistScreenState extends State<ApplyChecklistScreen> {
  final _random = Random();

  int _selectedStore = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build('Aplicar checklist'),
      body: Column(
        children: [
          const Text(
            'Escolha a loja',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          NumberPicker(
            haptics: true,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue)),
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
          const Divider(),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _random.nextInt(10),
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              itemBuilder: (context, index) {
                int checklistType = _random.nextInt(10) + 1;
                bool isSelected = false;
                String title = 'Aplicando $checklistType na loja $_selectedStore';
                return SimpleNavigatingCardItem(
                  text: 'Checklist $checklistType',
                  trailing: Checkbox(
                    value: false,
                    onChanged: (value) {
                      isSelected = !isSelected;
                    },
                  ),
                  goTo: Checklist(
                    editMode: false,
                    title: title,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
