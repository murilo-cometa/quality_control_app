import 'package:flutter/material.dart';
import 'package:quality_control_app/common/component/custom_appbar.dart';
import 'package:quality_control_app/common/library/custom_navigator.dart';

class CreateChecklistScreen extends StatefulWidget {
  const CreateChecklistScreen({super.key});

  @override
  State<CreateChecklistScreen> createState() => _CreateChecklistScreenState();
}

class _CreateChecklistScreenState extends State<CreateChecklistScreen> {
  final TextEditingController _checklistNameController =
      TextEditingController();
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build('Criar Checklist'),
      body: _buildBody(),
    );
  }

  Padding _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Escreva o nome do checklist:',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          TextField(
            controller: _checklistNameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Escreva aqui...',
            ),
          ),
          const Divider(
            height: 50,
          ),
          const Text(
            'Escreva o título da primeira tarefa:',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          TextField(
            controller: _taskTitleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Escreva aqui...',
            ),
          ),
          const Divider(
            height: 50,
          ),
          const Text(
            'Escreva a descrição:',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Escreva aqui...',
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          FilledButton(
            child: const Text('Salvar'),
            onPressed: () {
              if (_checklistNameController.text.isEmpty ||
                  _taskTitleController.text.isEmpty ||
                  _descriptionController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Não deixe campos vazios!!!'),
                  ),
                );
              } else {
                // CustomNavigator.goTo(
                //   context: context,
                //   destination: Checklist(
                //     newTask: true,
                //     editMode: true,
                //     title: _checklistNameController.text,
                //     firstTask: {
                //       'title': _taskTitleController.text,
                //       'description': _descriptionController.text,
                //     },
                //   ),
                // );
              }
            },
          )
        ],
      ),
    );
  }
}
