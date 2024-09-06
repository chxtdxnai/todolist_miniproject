import 'package:todolist/domain/entities/todo.dart';
import 'package:todolist/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final List<Todo> _todoList = [];

  @override
  Future<void> addTodo(Todo todo) async {
    _todoList.add(todo);
  }

  @override
  Future<void> editTodo(int index, Todo updatedTodo) async {
    _todoList[index] = updatedTodo;
  }

  @override
  Future<void> deleteTodo(int index) async {
    _todoList.removeAt(index);
  }

  @override
  List<Todo> getTodoList() {
    return _todoList;
  }
}
