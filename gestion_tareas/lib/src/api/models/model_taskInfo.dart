class TaskInfo{
  late int id;
  late String title;
  late int is_completed;
  late String due_date;
  late String comments;
  late String description;
  late String tags;
  late String token;
  late String created_at;
  late String update_at;

  TaskInfo({
    required this.id,
    required this.title,
    required this.is_completed,
    required this.due_date,
    required this.comments,
    required this.description,
    required this.tags,
    required this.token,
    required this.created_at,
    required this.update_at
  });

  factory TaskInfo.fromMap(Map<String, dynamic> mapa){
    return new TaskInfo(
      id: mapa["id"]??0,
      title: mapa["title"]??"",
      is_completed: mapa["is_completed"]??0,
      due_date: mapa["due_date"]??"",
      comments: mapa["comments"]??"",
      description: mapa["description"]??"",
      tags: mapa["tags"]??"",
      token: mapa["token"]??"",
      created_at: mapa["created_at"]??"",
      update_at: mapa["update_at"]??"",
    );
  }
}