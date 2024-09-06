import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/domain/usecases/edit_todo.dart';
import 'data/repositories/todo_repository_impl.dart';
import 'domain/usecases/add_todo.dart';
import 'domain/usecases/delete_todo.dart';
import 'presentation/viewmodels/todo_list_viewmodel.dart';
import 'presentation/pages/todo_list_page.dart';

void main() {
  final repository = TodoRepositoryImpl();
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoListViewModel(
        addTodo: AddTodo(repository),
        editTodo: EditTodo(repository),
        deleteTodo: DeleteTodo(repository),
        repository: repository,
      ),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clean Architecture Todo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TodoListPage(),
    );
  }
}
