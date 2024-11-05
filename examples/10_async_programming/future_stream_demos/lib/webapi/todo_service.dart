import 'package:dio/dio.dart';
import 'package:future_stream_demos/model/todo.dart';

class ToDoService {
  static const String BASE_URL = 'https://jsonplaceholder.typicode.com/todos';
  final Dio _dio = Dio();

  ToDoService() {
    _dio.options.baseUrl = BASE_URL;
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  Future<List<ToDo>> getToDos() async {
    final response = await _dio.get("/");
    return (response.data as List).map((json) => ToDo.fromJson(json)).toList();
  }

  Future<ToDo> getToDo(int toDoId) async {
    final response = await _dio.get('/$toDoId');
    return ToDo.fromJson(response.data);
  }

  Future<ToDo> addToDo(ToDo toDo) async {
    final response = await _dio.post("/", data: toDo.toJson());
    return ToDo.fromJson(response.data);
  }

  Future<ToDo> updateToDo(ToDo toDo) async {
    final response = await _dio.put('/${toDo.id}', data: toDo.toJson());
    return ToDo.fromJson(response.data);
  }

  Future<bool> deleteToDo(int toDoId) async {
    final response = await _dio.delete('/$toDoId');
    return response.statusCode == 200;
  }
}
