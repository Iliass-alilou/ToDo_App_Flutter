
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/Modules_ToDoApp/archivedTasks.dart';
import 'package:todo_app/modules/Modules_ToDoApp/doneTasks.dart';
import 'package:todo_app/modules/Modules_ToDoApp/newTasks.dart';
import 'package:todo_app/shared/components/constants.dart';
import 'package:todo_app/shared/cubit/states.dart';

class ToDoApp_Cubit extends Cubit <ToDoApp_States>{

  ToDoApp_Cubit() : super(ToDoApp_InitialState());

  static ToDoApp_Cubit get(context) => BlocProvider.of(context);

  late Database database ;
  int currentIndex = 0;
  List <Widget> screens = [
    New_Tasks(),
    Done_Task(),
    Archived_Tasks(),
  ];
  List <String> title_appBar =[
    "New Tasks",
    "Done Tasks",
    "Archived Tasks"
  ];

  void changeIndexNaveBar(int index){
    currentIndex = index;
    emit(BottomNavBarState());
  }

  void createDatabase()
  {
    openDatabase(
        'toDo.db',
        version: 1,
        onCreate: (database , version)
        {
          print("database created");
          database.execute("CREATE TABLE tasks (id INTEGER PRIMARY KEY, title Text, time Text, day Text ,status Text)").then((value)
          {
            print("database is succefully created");
          }).catchError((error){
            print("error when creating Table ${error.toString()}");
          });
        },
        onOpen: (database)
        {
          // getFromDataBase(database).then((value)
          // {
          //   tasks = value;
          //   print(tasks);
          // });
          print("database opned");
        }
    ).then((value) {
      database = value;
      emit(CreateDataBaseState());
    });

  }

  Future insertIntoDatabase ({
    required String title,
    required String time,
    required String day,
  }) async{
    return await database.transaction((txn) async
    {
      txn.rawInsert('INSERT INTO tasks (title, time, day , status)VALUES("$title","$time","$day" ,"new Task")').then((value)
      {
        print ("$value inserted successfully ");
      }).catchError((error)
      {
        print("error when when iserting ${error.toString()}");
      });
      return null;
    });

  }

  Future<List<Map>> getFromDataBase (database) async
  {
    return await database.rawQuery('SELECT * FROM tasks');
  }

}