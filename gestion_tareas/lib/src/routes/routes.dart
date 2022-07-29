import 'package:flutter/material.dart';
import 'package:gestion_tareas/src/screens/home_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'home': (BuildContext context) => HomeScreen(),
  };
}