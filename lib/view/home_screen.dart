import 'package:flutter/material.dart';
import 'package:quality_control_app/view/store_selection_screen.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                trailing: const Icon(Icons.arrow_forward),
                title: const Text(
                  'Aplicar checklist',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const StoreSelectionScreen();
                  },),);
                },
              ),
            ),
            const Divider(),
            const Card(
              child: ListTile(
                title: Text(
                  'Checklists aplicados',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
