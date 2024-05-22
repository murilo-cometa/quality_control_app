import 'package:flutter/material.dart';
import 'package:quality_control_app/screens/checklist_list.dart';

class StoreSelectionScreen extends StatelessWidget {
  const StoreSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 232, 164),
        centerTitle: true,
        title: const Text('Cometa Checklists'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        const Text(
          'Escolha a loja:',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        const Divider(),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              int storeCode = index + 1;
              return Card(
                elevation: 3,
                child: ListTile(
                  title: Text('loja $storeCode'),
                  leading: const Icon(Icons.house),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ChecklistList(storeCode: storeCode);
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
