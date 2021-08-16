
import 'package:flutter/material.dart';
import 'package:todo_app/shared/components/components.dart';
import '/shared/components/constants.dart';

class New_Tasks extends StatelessWidget {
  const New_Tasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context , index ) => ItemTaskBuilder(tasks[index]),
        separatorBuilder: (context , index ) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0
          ),
          child: Container(
            width: double.infinity,
            height: 2.0,
            color: Colors.grey[300],
          ),
        ),
        itemCount: tasks.length,
    );
  }
}
