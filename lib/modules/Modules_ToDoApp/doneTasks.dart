
import 'package:flutter/material.dart';

class Done_Task extends StatelessWidget {
  const Done_Task({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Done Tasks',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0
          ),
        ),
      ],
    );
  }
}
