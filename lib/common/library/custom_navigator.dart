import 'package:flutter/material.dart';

class CustomNavigator {
  static goTo({
    required BuildContext context,
    required Widget destination,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return destination;
        },
      ),
    );
  }
}

/*
  CustomNavigator.goTo(
    context: context,
    destinaton: HomeScreen(),
  )
*/