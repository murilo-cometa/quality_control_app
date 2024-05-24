import 'package:flutter/material.dart';
import 'package:quality_control_app/common/library/custom_navigator.dart';

class SimpleNavigatingCardItem extends StatelessWidget {
  const SimpleNavigatingCardItem({
    super.key,
    required this.text,
    this.textSize,
    this.leading,
    this.trailing,
    this.goTo,
    this.enabled = true,
  });

  final String text;
  final double? textSize;
  final Widget? leading;
  final Widget? trailing;
  final Widget? goTo;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        enabled: enabled,
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
