import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quality_control_app/common/component/task_card.dart';

class Checklist extends StatefulWidget {
  const Checklist({
    super.key,
    required this.storeCode,
    required this.checklistType,
  });

  final int checklistType;
  final int storeCode;

  @override
  State<Checklist> createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  final _random = Random();

  final List<Widget> setores = [
    const TaskCard(task: 'pão'),
    const TaskCard(task: 'carnes'),
    const TaskCard(task: 'vinhos'),
    const TaskCard(task: 'pets'),
    const TaskCard(task: 'brinquedos'),
  ];
  List<Widget> setoresCards = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 232, 164),
        title: Text(
          'Checklist ${widget.checklistType} na loja ${widget.storeCode}',
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      floatingActionButton: _floatingActionButton(),
      body: Column(
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
              itemCount: setoresCards.length,
              itemBuilder: (context, index) {
                return setoresCards[index];
              },
            )),
          ),
        ],
      ),
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        setState(() {
          setoresCards =
              setoresCards + [setores[_random.nextInt(setores.length)]];
        });
      },
    );
  }
}
