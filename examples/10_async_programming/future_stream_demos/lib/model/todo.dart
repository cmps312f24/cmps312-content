class ToDo {
  final int id;
  final String title;
  final int userId;
  final bool completed;

  ToDo({
    this.id = 0,
    required this.title,
    this.userId = 1,
    this.completed = false,
  });

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'],
      title: json['title'],
      userId: json['userId'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'userId': userId,
      'completed': completed,
    };
  }

  @override
  String toString() {
    return 'ToDo{id: $id, title: $title, userId: $userId, completed: $completed}';
  }
}
