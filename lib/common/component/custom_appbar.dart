import 'package:flutter/material.dart';

class CustomAppBar {
  static AppBar build(String title) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 255, 232, 164),
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
