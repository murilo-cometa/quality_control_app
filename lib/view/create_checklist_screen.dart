import 'package:flutter/material.dart';
import 'package:quality_control_app/common/component/simple_selectable_card_item.dart';
import 'package:quality_control_app/common/component/simple_navigating_item_card.dart';
import 'package:quality_control_app/view/checklist_list.dart';

class CreateChecklistScreen extends StatefulWidget {
  const CreateChecklistScreen({super.key});

  @override
  State<CreateChecklistScreen> createState() => _CreateChecklistScreenState();
}

class _CreateChecklistScreenState extends State<CreateChecklistScreen> {
  int _selectedStore = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 232, 164),
        centerTitle: true,
        title: const Text(
          'Cometa Checklists',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
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
        GridView.builder(
          shrinkWrap: true,
          itemCount: 10,
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          itemBuilder: (context, index) {
            int storeCode = index + 1;
            bool selected = storeCode == _selectedStore;
            return SimpleSelectableCardItem(
              text: 'loja $storeCode',
              selected: selected,
              cardColor: selected ? Colors.green : null,
              onTap: () {
                setState(() {
                  _selectedStore = storeCode;
                });
              },
            );
          },
        ),
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
                goTo: ChecklistList(
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
