import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quality_control_app/common/component/custom_appbar.dart';
import 'package:quality_control_app/common/component/task_card.dart';
import 'package:quality_control_app/view/create_task_screen.dart';

class Checklist extends StatefulWidget {
  const Checklist({
    super.key,
    this.editMode = true,
    required this.title,
    this.firstTask,
  });

  final bool editMode;
  final String title;
  final Map<String, String>? firstTask;
  @override
  State<Checklist> createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  final _random = Random();

  late List<Widget> _setores;

  @override
  void initState() {
    _setores = [
      // const TaskCard(task: 'Qualidade do pão'),
      // const TaskCard(task: 'Moscas na carne'),
      // const TaskCard(task: 'Validade dos vinhos'),
      // const TaskCard(task: 'devolução de itens'),
      // const TaskCard(task: 'Pontos extras'),
      if (widget.firstTask != null)
        TaskCard(
          task: widget.firstTask!['title'] ?? 'Sem título',
          description: widget.firstTask!['description'],
        ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(widget.title),
      floatingActionButton: widget.editMode ? _floatingActionButton() : null,
      body: _buildBody(),
    );
  }

  Column _buildBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Para checar:',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              if (widget.editMode)
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
        const Divider(height: 1,),
        Expanded(
          child: SizedBox(
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
              itemCount: widget.editMode ? _setores.length : 10,
              itemBuilder: (context, index) {
                return widget.editMode
                    ? _setores[index]
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
      onPressed: () async {
        final Map<String, String> info = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateTaskScreen(),
          ),
        );

        String title = info['title'] == null || info['title']!.isEmpty
            ? 'Sem título'
            : info['title']!;
        String? description =
            info['description'] == null || info['description']!.isEmpty
                ? 'Sem descrição'
                : info['description']!;

        setState(() {
          _setores = _setores +
              [
                TaskCard(
                  task: title,
                  description: description,
                )
              ];
        });
      },
    );
  }
}
