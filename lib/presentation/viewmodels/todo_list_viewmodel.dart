import 'package:flutter/cupertino.dart';
import 'package:todolist/domain/entities/todo.dart';
import 'package:todolist/domain/repositories/todo_repository.dart';
import 'package:todolist/domain/usecases/add_todo.dart';
import 'package:todolist/domain/usecases/delete_todo.dart';
import 'package:todolist/domain/usecases/edit_todo.dart';

class TodoListViewModel extends ChangeNotifier {
  final AddTodo addTodo;
  final EditTodo editTodo;
  final DeleteTodo deleteTodo;
  final TodoRepository repository;

  TodoListViewModel({
    required this.addTodo,
    required this.editTodo,
    required this.deleteTodo,
    required this.repository,
  });

  List<Todo> get todos => repository.getTodoList();

  Future<void> add(String title, String description, DateTime dueDate) async {
    await addTodo(Todo(title: title, description: description, dueDate: dueDate));
    notifyListeners();
  }

  Future<void> edit(int index, String newTitle, String newDescription, DateTime newDueDate) async {
    await editTodo(index, Todo(title: newTitle, description: newDescription, dueDate: newDueDate));
    notifyListeners();
  }

  Future<void> delete(int index) async {
    await deleteTodo(index);
    notifyListeners();
  }
}
