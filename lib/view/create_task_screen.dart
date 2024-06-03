import 'package:flutter/material.dart';
import 'package:quality_control_app/common/component/custom_appbar.dart';

class CreateTaskScreen extends StatelessWidget {
  CreateTaskScreen({super.key});
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build('Adicionar tarefa'),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Digite o título:',
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              controller: _controllerTitle,
              decoration: const InputDecoration(
                hintText: 'Seu título aqui...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Digite a descrição:',
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              controller: _controllerDescription,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Sua descrição aqui...',
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              child: const Text('Salvar'),
              onPressed: () {
                Map<String, String> textList = {'title': _controllerTitle.text,'description': _controllerDescription.text};
                Navigator.pop(context, textList);
              },
            )
          ],
        ),
      ),
    );
  }
}
