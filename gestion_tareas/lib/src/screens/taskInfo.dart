import 'package:flutter/material.dart';

class TaskInfo extends StatefulWidget {
  const TaskInfo({Key? key}) : super(key: key);

  @override
  State<TaskInfo> createState() => _TaskInfoState();
}

class _TaskInfoState extends State<TaskInfo> {
  @override
  Widget build(BuildContext context) {

    Map? parametros = ModalRoute
        .of(context)!
        .settings
        .arguments as Map?;

    String taskId = parametros!['taskId'];

    double _w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: _w / 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(taskId),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("tasksList.due_date"),
                  ),
                  /*Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: tasksList.is_completed == 1 ? Text("Completada") : Text("Incompleta"),
                  ),*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
