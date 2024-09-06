import 'package:todolist/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<void> addTodo(Todo todo);
  Future<void> editTodo(int index, Todo updatedTodo);
  Future<void> deleteTodo(int index);
  List<Todo> getTodoList();
}
