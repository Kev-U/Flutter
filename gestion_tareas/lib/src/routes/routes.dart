import 'package:flutter/material.dart';

import 'package:gestion_tareas/src/screens/addNewTask_screen.dart';
import 'package:gestion_tareas/src/screens/home_screen.dart';
import 'package:gestion_tareas/src/screens/taskInfo.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'home': (BuildContext context) => HomeScreen(),
    'addNewTask': (BuildContext context) => AddNewTaskScreen(),
    'taskInfo': (BuildContext context) => TaskInfo(),
  };
}