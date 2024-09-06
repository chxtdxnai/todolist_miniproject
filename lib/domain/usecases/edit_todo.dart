import 'package:todolist/domain/entities/todo.dart';
import 'package:todolist/domain/repositories/todo_repository.dart';

class EditTodo {
  final TodoRepository repository;

  EditTodo(this.repository);

  Future<void> call(int index, Todo updatedTodo) async {
    await repository.editTodo(index, updatedTodo);
  }
}