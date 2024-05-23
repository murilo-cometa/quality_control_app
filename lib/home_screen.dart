import 'package:flutter/material.dart';

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
            Card(
              child: ListTile(
                title: Text(
                  'Aplicar checklist',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
            Divider(),
            Card(
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
