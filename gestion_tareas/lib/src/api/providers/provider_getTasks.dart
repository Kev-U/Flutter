import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/model_task.dart';
import '../response.dart';

class GetTasksProvider{

  Future<Respuesta> getTasksProv() async {

    const String baseURL = "ecsdevapi.nextline.mx";

    const String jwt = "e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd";

    final Map<String, String> _queryParameters = <String, String>{
      'token': '123456',
    };

    final url = new Uri.https(baseURL, "vdev/tasks-challenge/tasks", _queryParameters);

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt',
    };

    //final Map<String, dynamic> data = {};

    //final body = json.encode(data);
    //print(body);

    http.Response resp = await http.get(url, headers: headers);

    print("El response es: "+ resp.body);

    final responseMap = json.decode(resp.body);

    //int status = resp.statusCode;
    String mensaje = "";
    int status = resp.statusCode;

    //print("response map: " +responseMap);



    List<dynamic> getTasksMap = responseMap;
    List<GetTasks> tasksList = fromMapList(getTasksMap);


    return Respuesta(true, status, mensaje, data: tasksList);

  }
}