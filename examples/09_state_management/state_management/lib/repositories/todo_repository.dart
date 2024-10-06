import 'package:state_management/models/todo.dart';

class TodoRepository {
  // In real app, this method will fetch Todos from API
  /*Future<List<Todo>> fetchTodos() async {
    // Fetch Todos from API
  }*/

  //Return sample Todos data
  static getTodos() => const [
        Todo(id: 'todo-1', description: 'Learn Navigation'),
        Todo(
            id: 'todo-2',
            description: 'Practice state management using Riverpod'),
        Todo(id: 'todo-3', description: 'Explore more widgets and layouts'),
      ];
}
