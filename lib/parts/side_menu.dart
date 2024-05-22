import 'package:flutter/material.dart';
import 'package:quality_control_app/screens/checklist_list.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const SizedBox(
            height: 130,
            width: 310,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 232, 164),
              ),
              child: Text(
                'Cometa Checklists',
                style: TextStyle(fontSize: 28),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: ListView.builder(
                // shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  int storeCode = index + 1;
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return ChecklistList(
                                storeCode: storeCode,
                              );
                            },
                          ),
                        );
                      },
                      title: Text(
                        'loja $storeCode',
                      ),
                    ),
                  );
                },
                itemCount: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
