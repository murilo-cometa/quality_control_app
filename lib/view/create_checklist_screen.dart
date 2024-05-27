import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:quality_control_app/common/component/custom_appbar.dart';
import 'package:quality_control_app/common/component/simple_navigating_item_card.dart';
import 'package:quality_control_app/view/checklist.dart';

class CreateChecklistScreen extends StatefulWidget {
  const CreateChecklistScreen({super.key});

  @override
  State<CreateChecklistScreen> createState() => _CreateChecklistScreenState();
}

class _CreateChecklistScreenState extends State<CreateChecklistScreen> {
  int _selectedStore = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build('Criar Checklist'),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
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
            border: Border.all(
              color: Colors.blue
            )
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
        // SizedBox(
        //   height: 200,
        //   child: GridView.builder(
        //     shrinkWrap: true,
        //     itemCount: 40,
        //     padding: const EdgeInsets.only(
        //       left: 10,
        //       right: 10,
        //     ),
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 5,
        //       childAspectRatio: 2,
        //       crossAxisSpacing: 2,
        //       mainAxisSpacing: 2,
        //     ),
        //     itemBuilder: (context, index) {
        //       int storeCode = index + 1;
        //       bool selected = storeCode == _selectedStore;
        //       return SimpleSelectableCardItem(
        //         text: 'loja $storeCode',
        //         selected: selected,
        //         cardColor: selected ? Colors.green : null,
        //         onTap: () {
        //           setState(() {
        //             _selectedStore = storeCode;
        //           });
        //         },
        //       );
        //     },
        //   ),
        // ),
        const Divider(),
        const Text(
          'Escolha a o tipo de checklist',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 20,
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            itemBuilder: (context, index) {
              int checklistType = index + 1;
              bool enabled = _selectedStore != -1;
              return SimpleNavigatingCardItem(
                enabled: enabled,
                text: 'tipo de checklist $checklistType',
                goTo: Checklist(
                  storeCode: _selectedStore,
                  checklistType: checklistType,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
