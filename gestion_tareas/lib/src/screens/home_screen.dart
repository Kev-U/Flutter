import 'package:flutter/material.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gestion_tareas/src/api/models/model_task.dart';
import 'package:gestion_tareas/src/api/providers/provider_getTasks.dart';
import 'package:gestion_tareas/src/screens/addNewTask_screen.dart';
import 'package:gestion_tareas/src/utils/scaleTransactionPage.dart';

import '../api/response.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//AddSocialMediaProvider socialMediaProvider = new AddSocialMediaProvider();

GetTasksProvider getTasksProv = new GetTasksProvider();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text("Home page"),
          centerTitle: true,
          ),
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
        child: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text("Add new task"),
          onPressed: (){Navigator.popAndPushNamed(context, "addNewTask");},
        ),
      ),
      body: FutureBuilder(
        future: getTasksProv.getTasksProv(),
        builder: (context, AsyncSnapshot<Respuesta> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey, strokeWidth: 4,));
          }

          Respuesta resp = snapshot.data ?? new Respuesta(false, 0, "");
          //if (resp.statusCode == 0) return DataNotFoundGen();

          if (resp.statusCode != 200){
            return Container(child: Text("Error"));
          }else {
            //if (resp.statusCode == 404) return DataNotFoundGen();

            //if (resp.statusCode == 403) return DataNotFoundGen();

            print(resp.statusCode);
            List<GetTasks> tasksList = resp.data ?? [];

            //sucursalesLista.addAll(resp.data ?? []);

            //if(syncDevicesL.isEmpty){
            //return _listaVacia();
            //}else{
            return _body(tasksList);
            //}
          }
        },
      ),
    );
  }


  Widget _body(List<GetTasks> tasksList){
    double _w = MediaQuery.of(context).size.width;
    return AnimationLimiter(
      child: ListView.builder(
        padding: EdgeInsets.all(_w / 30),
        physics:
        BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemCount: tasksList.length,
        itemBuilder: (context, index) =>
            _socialMediaList(tasksList[index], index),
      ),
    );
  }

  Widget _socialMediaList(GetTasks tasksList, int index){
    double _w = MediaQuery.of(context).size.width;
    return AnimationConfiguration.staggeredList(
      position: index,
      delay: Duration(milliseconds: 100),
      child: SlideAnimation(
        duration: Duration(milliseconds: 2500),
        curve: Curves.fastLinearToSlowEaseIn,
        horizontalOffset: 30,
        verticalOffset: 300.0,
        child: FlipAnimation(
          duration: Duration(milliseconds: 3000),
          curve: Curves.fastLinearToSlowEaseIn,
          flipAxis: FlipAxis.y,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: GestureDetector(
              onTap: () {
                Navigator.popAndPushNamed(context, "taskInfo",
                    arguments: {
                      "taskId": tasksList.id.toString(),
                    }
                );
              },
              child: Container(
                margin: EdgeInsets.only(bottom: _w / 20),
                height: _w / 2,
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
                      child: Text(tasksList.title),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(tasksList.due_date),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: tasksList.is_completed == 1 ? Text("Completada") : Text("Incompleta"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
