
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/Modules_ToDoApp/archivedTasks.dart';
import 'package:todo_app/modules/Modules_ToDoApp/doneTasks.dart';
import 'package:todo_app/modules/Modules_ToDoApp/newTasks.dart';
import 'package:todo_app/shared/cubit/states.dart';

class ToDoApp_Cubit extends Cubit <ToDoApp_States>{

  ToDoApp_Cubit() : super(ToDoApp_InitialState());

  static ToDoApp_Cubit get(context) => BlocProvider.of(context);

  List<Map> Newtasks = [];
  List<Map> Donetasks = [];
  List<Map> Archivedtasks = [];

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
          getFromDataBase(database);
          print("database opened");
        }
    ).then((value) {
      database = value;

    });

  }

   insertIntoDatabase ({
    required String title,
    required String time,
    required String day,
  }) async{
    await database.transaction((txn) async
    {
      txn.rawInsert(
          'INSERT INTO tasks (title, time, day , status)VALUES("$title","$time","$day" ,"new Task")'
      ).then((value)
      {
        print ("$value inserted successfully ");
        emit(InsertIntoDataBaseState());

        getFromDataBase(database);
      }).catchError((error)
      {
        print("error when when iserting ${error.toString()}");
      });
      return null;
    });

  }

   void upDateDataBase ({
     required String status,
     required int id
   }) async
   {
       database.rawUpdate(
         'UPDATE tasks SET status = ? WHERE id = ?',
         ['$status', '$id']).then((value){
           getFromDataBase(database);
           emit(UpdateDataBaseState());
       });

   }

  void deleteDataBase ({
    required int id
  }) async
  {
    database
        .rawDelete('DELETE FROM tasks WHERE id = ?',
        ['$id']).then((value){
          getFromDataBase(database);
          emit(UpDeleteDataBaseState());
    });
  }



 void getFromDataBase (database)
  {
    Newtasks = [];
    Donetasks = [];
    Archivedtasks = [];
    database.rawQuery('SELECT * FROM tasks').then((value)
    {
      value.forEach((element) {
        if(element['status'] == 'new Task')
        {
          Newtasks.add(element);
        }
        else if (element['status'] == 'done'){
          Donetasks.add(element);
        }
        else Archivedtasks.add(element);
      });
      emit(GetDataBaseState());
    });
  }
  bool BottomSheet_Shown = false;
  IconData floatIcon = Icons.edit;

  void BottomSheet_Show_Close ({
    required bool isBottomSheet_shown,
    required IconData icon
  })
  {
    BottomSheet_Shown = isBottomSheet_shown;
    floatIcon = icon;
    emit(BotoomSheetShowState());
  }

}