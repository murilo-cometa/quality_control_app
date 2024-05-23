import 'package:flutter/material.dart';
import 'package:quality_control_app/common/library/custom_navigator.dart';

class SimpleCardItem extends StatelessWidget {
  const SimpleCardItem(
      {super.key,
      required this.text,
      this.textSize,
      this.leading,
      this.trailing,
      this.goTo});

  final String text;
  final double? textSize;
  final Widget? leading;
  final Widget? trailing;
  final Widget? goTo;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: leading,
        trailing: trailing,
        title: Text(
          text,
          style: TextStyle(
            fontSize: textSize,
          ),
        ),
        onTap: goTo == null
            ? null
            : () {
                CustomNavigator.goTo(
                  context: context,
                  destination: goTo!,
                );
              },
      ),
    );
  }
}
