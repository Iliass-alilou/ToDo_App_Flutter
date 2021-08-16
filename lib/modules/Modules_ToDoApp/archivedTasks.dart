
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class Archived_Tasks extends StatelessWidget {
  const Archived_Tasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ToDoApp_Cubit, ToDoApp_States>(
        listener: ( context , state)
        {

        },
        builder: ( context , state)
        {
          var tasks = ToDoApp_Cubit.get(context).Archivedtasks;
          return ListView.separated(
            itemBuilder: (context , index ) => ItemTaskBuilder(tasks[index] ,context ),
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
          ) ;
        }
    );
  }
}
