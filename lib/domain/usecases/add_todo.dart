import 'package:todolist/domain/entities/todo.dart';
import 'package:todolist/domain/repositories/todo_repository.dart';

class AddTodo {
  final TodoRepository repository;

  AddTodo(this.repository);

  Future<void> call(Todo todo) async {
    await repository.addTodo(todo);
  }
}



