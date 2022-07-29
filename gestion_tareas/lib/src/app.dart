import 'package:flutter/material.dart';

import 'package:gestion_tareas/src/routes/routes.dart' as routes;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion de tareas',
      routes: routes.getApplicationRoutes(),
      initialRoute: "home",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}