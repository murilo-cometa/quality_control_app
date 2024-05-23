import 'package:flutter/material.dart';
import 'package:quality_control_app/common/component/simple_card_item.dart';
import 'package:quality_control_app/view/checklist_list.dart';

class StoreSelectionScreen extends StatelessWidget {
  const StoreSelectionScreen({super.key});

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
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        const Text(
          'Escolha a loja',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount: 10,
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          itemBuilder: (context, index) {
            int storeCode = index + 1;
            return SimpleCardItem(
              text: 'loja $storeCode',
              goTo: ChecklistList(
                storeCode: storeCode,
              ),
            );
          },
        ),
        const Divider(),
        const Text(
          'Escolha a o tipo de checklist',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        // ListView.builder(
        //   itemCount: 5,
        //   itemBuilder: (context, index) {
        //     return null;
        //   },
        // )
      ],
    );
  }
}
