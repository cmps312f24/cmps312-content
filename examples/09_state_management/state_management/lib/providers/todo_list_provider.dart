import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/models/todo.dart';
import 'package:state_management/repositories/todo_repository.dart';
import 'package:uuid/uuid.dart';

// Notifier class to manage the state of the Todo list
class TodoListNotifier extends Notifier<List<Todo>> {
  static const _uuid = Uuid();

  // Initialize the state with todos from the repository
  @override
  List<Todo> build() {
    return TodoRepository.getTodos();
  }

  // Add a new Todo item to the list
  void add(String description) {
    state = [
      ...state,
      Todo(
        id: _uuid.v4(),
        description: description,
      ),
    ];
  }

  // Toggle the completion status of a Todo item
  void toggle(String id) {
    state = state.map((todo) {
      return todo.id == id
          ? Todo(
              id: todo.id,
              completed: !todo.completed,
              description: todo.description,
            )
          : todo;
    }).toList();
  }

  // Edit the description of a Todo item
  void edit({required String id, required String description}) {
    state = state.map((todo) {
      return todo.id == id
          ? Todo(
              id: todo.id,
              completed: todo.completed,
              description: description,
            )
          : todo;
    }).toList();
  }

  // Remove a Todo item from the list
  void remove(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}

// Provider to expose the TodoListNotifier
final todoListProvider = NotifierProvider<TodoListNotifier, List<Todo>>(
  () => TodoListNotifier(),
);
