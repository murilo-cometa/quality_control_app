import 'package:flutter/material.dart';
import 'package:quality_control_app/common/component/simple_navigating_item_card.dart';
import 'package:quality_control_app/view/create_checklist_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      body: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            SimpleNavigatingCardItem(
              text: 'Aplicar checklist',
              textSize: 30,
              trailing: Icon(Icons.arrow_forward),
              goTo: null,  // adicionar tela depois
            ),
            Divider(),
            SimpleNavigatingCardItem(
              text: 'Checklists aplicados',
              textSize: 30,
              trailing: Icon(Icons.arrow_forward),
              goTo: null,  // adicionar tela depois
            ),
            Divider(),
            SimpleNavigatingCardItem(
              text: 'Criar checklist',
              textSize: 30,
              trailing: Icon(Icons.arrow_forward),
              goTo: CreateChecklistScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
