import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quality_control_app/common/component/custom_appbar.dart';
import 'package:quality_control_app/common/component/task_card.dart';

class Checklist extends StatefulWidget {
  const Checklist({
    super.key,
    required this.storeCode,
    required this.checklistType,
    this.editMode = true,
  });

  final bool editMode;
  final int checklistType;
  final int storeCode;

  @override
  State<Checklist> createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  final _random = Random();

  final List<Widget> _setores = [
    const TaskCard(task: 'Qualidade do pão'),
    const TaskCard(task: 'Moscas na carne'),
    const TaskCard(task: 'Validade dos vinhos'),
    const TaskCard(task: 'devolução de itens'),
    const TaskCard(task: 'Pontos extras'),
  ];
  List<Widget> _setoresCards = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build('Checklist ${widget.checklistType} na loja ${widget.storeCode}'),
      floatingActionButton: widget.editMode ? _floatingActionButton() : null,
      body: _buildBody(),
    );
  }

  Column _buildBody() {
    return Column(
      children: [
        const SizedBox(
          child: Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Para checar:',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        const Divider(),
        Expanded(
          child: SizedBox(
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 10, right: 10),
              itemCount: widget.editMode ? _setoresCards.length : 10,
              itemBuilder: (context, index) {
                return widget.editMode
                    ? _setoresCards[index]
                    : _setores[_random.nextInt(_setores.length)];
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        setState(() {
          _setoresCards =
              _setoresCards + [_setores[_random.nextInt(_setores.length)]];
        });
      },
    );
  }
}
