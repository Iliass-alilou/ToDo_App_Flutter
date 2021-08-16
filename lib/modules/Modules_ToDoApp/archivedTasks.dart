
import 'package:flutter/material.dart';

class Archived_Tasks extends StatelessWidget {
  const Archived_Tasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Archived Tasks',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0
          ),
        ),
      ],
    );
  }
}
