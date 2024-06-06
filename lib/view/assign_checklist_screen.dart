import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:quality_control_app/common/component/custom_appbar.dart';
import 'package:quality_control_app/common/component/custom_card_item.dart';
import 'package:quality_control_app/common/library/custom_navigator.dart';
import 'package:quality_control_app/view/checklist.dart';

class AssignChecklistScreen extends StatefulWidget {
  const AssignChecklistScreen({super.key});

  @override
  State<AssignChecklistScreen> createState() => _AssignChecklistScreenState();
}

class _AssignChecklistScreenState extends State<AssignChecklistScreen> {
  int _selectedStore = 1;
  final List<int> _selectedChecklists = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build('Atribuir Checklist'),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        const SizedBox(
          height: 35,
          child: Text(
            'Escolha a loja',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        NumberPicker(
          haptics: true,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue),
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
        const Divider(), //--------------------------------------------------------------------------------------------
        SizedBox(
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Escolha a o tipo de checklist',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFFFFE8A4)),
                ),
                child: const Text('Salvar'),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            itemBuilder: (context, index) {
              int checklistType = index + 1;
              bool selected = _selectedChecklists.contains(checklistType);
              String title = 'Checklist $checklistType';
              return CustomCardItem(
                leading: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    CustomNavigator.goTo(
                      context: context,
                      destination: Checklist(
                        editMode: true,
                        title: title,
                      ),
                    );
                  },
                ),
                selected: selected,
                text: 'tipo de checklist $checklistType',
                onTap: () {
                  setState(() {
                    selected
                        ? _selectedChecklists.remove(checklistType)
                        : _selectedChecklists.add(checklistType);
                  });
                },
              );
            },
          ),
        )
      ],
    );
  }
}
