import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:quality_control_app/common/component/custom_appbar.dart';

class ApplyChecklistScreen extends StatefulWidget {
  const ApplyChecklistScreen({super.key});

  @override
  State<ApplyChecklistScreen> createState() => _ApplyChecklistScreenState();
}

class _ApplyChecklistScreenState extends State<ApplyChecklistScreen> {

  int _selectedStore = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build('Aplicar checklist'),
      body: Column(
        children: [
          const Text(
            'Escolha a loja',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          NumberPicker(
            haptics: true,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue)),
            infiniteLoop: true,
            itemWidth: 70,
            itemCount: 5,
            axis: Axis.horizontal,
            minValue: 1,
            maxValue: 40,
            value: _selectedStore,
            onChanged: (value) {
              setState(() {
              _selectedStore = value;
              });
            },
          ),
          const Divider(),
          // Expanded(
          //   child: ListView.builder(),
          // ),
        ],
      ),
    );
  }
}
