import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/model_task.dart';
import '../response.dart';

class AddNewTask{

  Future<Respuesta> addNewTaskProv(String token, String title, int is_completed, String date, String comments, String description, String tags) async {

    const String baseURL = "ecsdevapi.nextline.mx";

    const String jwt = "e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd";

    final Map<String, String> _queryParameters = <String, String>{
      'token': '123456',
    };

    final url = new Uri.https(baseURL, "vdev/tasks-challenge/tasks");

    final Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $jwt',
    };

    var token2 = 123456;

     var data = "token=$token&title=$title&is_completed=$is_completed&due_date=$date&comments=$comments&description=$description&tags=$tags";


    //final body = json.encode(data);
    final body = data;
    //print(body);

    http.Response resp = await http.post(url, headers: headers, body: body);

    print("El response es: "+ resp.body);

    final responseMap = json.decode(resp.body);

    //int status = resp.statusCode;
    String mensaje = "";
    int status = resp.statusCode;

    //print("response map: " +responseMap);



    //List<dynamic> getTasksMap = responseMap;
    //List<GetTasks> tasksList = fromMapList(getTasksMap);


    return Respuesta(true, status, mensaje, data: resp.body);

  }
}