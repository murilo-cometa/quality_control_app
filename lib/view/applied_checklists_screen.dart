import 'package:flutter/material.dart';
import 'package:quality_control_app/common/component/custom_appbar.dart';

class AppliedChecklistsScreen extends StatelessWidget {
  AppliedChecklistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build('Checklists aplicados'),
      body: const Placeholder()
    );
  }
}
