import 'package:flutter/material.dart';

class CustomAppBar {
  static AppBar build(String title) {
    return AppBar(
      backgroundColor: const Color(0xFFFFE8A4),
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 30,
        ),
      ),
    );
  }
}
