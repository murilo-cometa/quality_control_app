import 'package:flutter/material.dart';

class SimpleSelectableCardItem extends StatelessWidget {
  const SimpleSelectableCardItem({
    super.key,
    required this.text,
    this.textSize,
    this.leading,
    this.trailing,
    this.selected = false,
    this.onTap,
    this.cardColor,
    this.enabled = true
  });

  final String text;
  final double? textSize;
  final Widget? leading;
  final Widget? trailing;
  final Color? cardColor;
  final bool enabled;
  final bool selected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      elevation: 3,
      child: ListTile(
        enabled: enabled,
        selectedColor: Colors.white,
        selected: selected,
        leading: leading,
        trailing: trailing,
        title: Text(
          text,
          style: TextStyle(
            fontSize: textSize,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
