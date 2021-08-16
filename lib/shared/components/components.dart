import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';

Widget LoginButton ({
  double width = double.infinity,
  Color background = Colors.blue,
  required String text,
  required Function function,

})=> Container(
  width: width,
  color:background,
  child: MaterialButton(
    onPressed: function() ,
    child: Text(
      text,
      style: TextStyle(
          color: Colors.white
      ),
    ),
  ),
);

Widget textField ({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  required Function validate,
  required String label,
  required IconData Prefexicon,
  bool isPassword =false,
  IconData? Suffixicon,
  Function? obsecure,
  Function? onTap,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  onFieldSubmitted:onSubmit!(),
  onChanged: onChange!(),
  validator: validate(),
  onTap: onTap!(),
  obscureText: isPassword,
  decoration: InputDecoration(
    labelText: label,
    border:OutlineInputBorder(),
    prefixIcon: Icon(
      Prefexicon,
    ),
    suffixIcon:Suffixicon != null ? IconButton(
      icon: Icon(
        Icons.remove_red_eye,
      ),
      onPressed: obsecure!(),
    ):null ,
  ),
);



Widget defaultFormField ({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onchange,
  Function? onTap,
  bool isPassword = false ,
  required Function validate ,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  onFieldSubmitted: onSubmit!(),
  onChanged: onchange!(),
  onTap: onTap!(),
  validator: validate(),
  decoration: InputDecoration(),

);

Widget ItemTaskBuilder (Map tasks , context) => Dismissible(
  key: Key(tasks['id'].toString()),
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40.0,
          child: Text(
            '${tasks['time']}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: 30.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Text(
                '${tasks['title']}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                '${tasks['day']}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 30.0,
        ),
        IconButton(
            onPressed: ()
            {
              ToDoApp_Cubit.get(context).upDateDataBase(
                  status: 'done',
                  id: tasks['id']
              );
            },
            icon: tasks['status'] == 'done'  ? Icon(null) : Icon(
              Icons.check_box_rounded,
              color: Colors.green,
            )
        ),
        IconButton(
            onPressed: ()
            {
              ToDoApp_Cubit.get(context).upDateDataBase(
                  status: 'archived',
                  id: tasks['id']
              );
            },
            icon: tasks['status'] == 'archived'  ? Icon(null) : Icon(
              Icons.archive,
              color: Colors.grey,
            )
        ),
      ],
    ),
  ),
  onDismissed: (direction){
    ToDoApp_Cubit.get(context).deleteDataBase(id: tasks['id']);
  },
);