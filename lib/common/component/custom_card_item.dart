import 'package:flutter/material.dart';

class CustomCardItem extends StatelessWidget {
  const CustomCardItem({
    super.key,
    required this.text,
    this.textSize,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.selected = false,
    this.onTap,
    this.cardColor,
    this.onLongPress,
  });

  final String text;
  final double? textSize;
  final Widget? leading;
  final Widget? trailing;
  final Color? cardColor;
  final bool enabled;
  final bool selected;
  final void Function()? onTap;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: selected ? Colors.green : null,
      elevation: 3,
      child: ListTile(
        enabled: enabled,
        leading: leading,
        trailing: trailing,
        selectedColor: Colors.white,
        selected: selected,
        onTap: onTap,
        onLongPress: onLongPress,
        title: Text(
          text,
          style: TextStyle(
            fontSize: textSize,
          ),
        ),
      ),
    );
  }
}
