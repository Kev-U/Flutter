List<GetTasks> fromMapList(List<dynamic> mapList) {
  List<GetTasks> tasksList = [];

  mapList.forEach((item) {
    tasksList.add(GetTasks.fromMap(item));
  });

  return tasksList;
}


class GetTasks{
  late int id;
  late String title;
  late int is_completed;
  late String due_date;

  GetTasks({
    required this.id,
    required this.title,
    required this.is_completed,
    required this.due_date
  });

  factory GetTasks.fromMap(Map<String, dynamic> mapa){
    return new GetTasks(
      id: mapa["id"]??0,
      title: mapa["title"]??"",
      is_completed: mapa["is_completed"]??0,
      due_date: mapa["due_date"]??"",
    );
  }
}