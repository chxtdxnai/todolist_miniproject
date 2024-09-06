import 'package:todolist/domain/repositories/todo_repository.dart';

class DeleteTodo {
  final TodoRepository repository;

  DeleteTodo(this.repository);

  Future<void> call(int index) async {
    await repository.deleteTodo(index);
  }
}