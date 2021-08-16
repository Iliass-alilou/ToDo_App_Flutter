import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import '/shared/components/constants.dart';


class ToDo_App extends StatelessWidget {



  var scaffolKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dayController = TextEditingController();


  // @override
  // void initState() {
  //   // TODO: implement initState
  //   createDatabase();
  // }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext contex)=> ToDoApp_Cubit()..createDatabase(),
      child: BlocConsumer<ToDoApp_Cubit,ToDoApp_States>(
        listener: ( context , state){
          if(state is InsertIntoDataBaseState)
          {
            Navigator.pop(context);
          }
        },
        builder: (context , state ){
          return Scaffold(
            key: scaffolKey,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                ToDoApp_Cubit.get(context).title_appBar[ToDoApp_Cubit.get(context).currentIndex],    //[currentIndex],
              ),
            ),
            body:/*ToDoApp_Cubit.get(context).Newtasks.length==0 ? Center(child: CircularProgressIndicator()) :*/ ToDoApp_Cubit.get(context).screens[ToDoApp_Cubit.get(context).currentIndex],
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(
                bottom: 40.0,
              ),
              child: FloatingActionButton(
                onPressed: ()
                {
                  if(ToDoApp_Cubit.get(context).BottomSheet_Shown){
                    if(formKey.currentState!.validate()){
                      ToDoApp_Cubit.get(context).insertIntoDatabase(
                          title: titleController.text,
                          time: timeController.text,
                          day: dayController.text,
                      );

                      // insertIntoDatabase(
                      //   title: titleController.text,
                      //   time: timeController.text,
                      //   day: dayController.text,
                      // ).then((value) {
                      //   getFromDataBase(database).then((value) {
                      //
                      //     Navigator.pop(context);
                      //     // setState(() {
                      //     //   BottomSheet_Shown = false;
                      //     //   floatIcon = Icons.edit;
                      //     //   tasks = value;
                      //     //   print(tasks);
                      //     // });
                      //   });
                      // });
                    }
                  }
                  else
                  {
                    scaffolKey.currentState!.showBottomSheet(
                            (context) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              color: Colors.white,
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      controller: titleController,
                                      decoration: InputDecoration(
                                        labelText: 'Title Task',
                                        border:OutlineInputBorder(),
                                        prefixIcon: Icon(
                                          Icons.title,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'title should not be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    TextFormField(
                                      enabled: true,
                                      keyboardType: TextInputType.datetime,
                                      controller: timeController,
                                      decoration: InputDecoration(
                                        labelText: 'Time Task',
                                        border:OutlineInputBorder(),
                                        prefixIcon: Icon(
                                          Icons.watch_later,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'time should not be empty';
                                        }
                                        return null;
                                      },
                                      onTap: (){
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value)
                                        {
                                          timeController.text = value!.format(context).toString();
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    TextFormField(
                                      enabled: true,
                                      keyboardType: TextInputType.datetime,
                                      controller: dayController,
                                      decoration: InputDecoration(
                                        labelText: 'Day Task',
                                        border:OutlineInputBorder(),
                                        prefixIcon: Icon(
                                          Icons.calendar_today_outlined,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'day should not be empty';
                                        }
                                        return null;
                                      },
                                      onTap: (){
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now() ,
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.parse('2021-12-29'),
                                        ).then((value)
                                        {
                                          dayController.text = DateFormat.yMMMd().format(value!) ;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ) ;
                        }).closed.then((value){
                      ToDoApp_Cubit.get(context).BottomSheet_Show_Close(
                          isBottomSheet_shown: false,
                          icon: Icons.edit,
                      );
                    });
                    ToDoApp_Cubit.get(context).BottomSheet_Show_Close(
                      isBottomSheet_shown: true,
                      icon: Icons.add,
                    );
                  }
                },
                child: Icon(
                  ToDoApp_Cubit.get(context).floatIcon,
                ),
              ),
            ),
            bottomNavigationBar:BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items:[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.done,
                  ),
                  label: 'Done Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive,
                  ),
                  label: 'Archived Tasks',
                ),
              ],
              currentIndex: ToDoApp_Cubit.get(context).currentIndex,
              onTap: (index)
              {
                ToDoApp_Cubit.get(context).changeIndexNaveBar(index);
              },
            ),
          );
        },
      ),
    );
  }


}

