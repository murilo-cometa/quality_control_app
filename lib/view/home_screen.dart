import 'package:flutter/material.dart';
import 'package:quality_control_app/common/component/custom_appbar.dart';
import 'package:quality_control_app/common/component/simple_navigating_item_card.dart';
import 'package:quality_control_app/view/applied_checklists_screen.dart';
import 'package:quality_control_app/view/apply_checklist_screen.dart';
import 'package:quality_control_app/view/assign_checklist_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build('Cometa Checklists'),
      body: _buildBody(),
    );
  }

  Padding _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
            const SimpleNavigatingCardItem(
            text: 'Aplicar checklist',
            textSize: 30,
            trailing: Icon(Icons.arrow_forward),
            goTo: ApplyChecklistScreen(),
          ),
          const Divider(),
          SimpleNavigatingCardItem(
            text: 'Checklists aplicados',
            textSize: 30,
            trailing: const Icon(Icons.arrow_forward),
            goTo: AppliedChecklistsScreen(),
          ),
          const Divider(),
          const SimpleNavigatingCardItem(
            text: 'Atribuir checklist',
            textSize: 30,
            trailing: Icon(Icons.arrow_forward),
            goTo: AssignChecklistScreen(),
          ),
        ],
      ),
    );
  }
}
