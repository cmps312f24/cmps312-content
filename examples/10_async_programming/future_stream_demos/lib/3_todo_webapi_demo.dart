
import 'package:future_stream_demos/model/todo.dart';
import 'package:future_stream_demos/webapi/todo_service.dart';

void main() async {
  final toDoService = ToDoService();
  final toDos = await toDoService.getToDos();
  print(">> ToDos\n: $toDos");

  final toDo1 = await toDoService.getToDo(1);
  print(">> ToDo\n: $toDo1");

  var toDo = ToDo(title: "Study Async Dart");
  toDo = await toDoService.addToDo(toDo);
  print(">> New ToDo \n: $toDo");

  final isOk = await toDoService.deleteToDo(1);
  print(">> Was delete Ok \n: $isOk");
}