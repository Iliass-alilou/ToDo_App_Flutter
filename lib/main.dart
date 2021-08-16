import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit_Observer.dart';

import 'layout/toDoApp.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDo_App(),
    );
  }
}
