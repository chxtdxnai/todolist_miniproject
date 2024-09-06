import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:todolist/presentation/viewmodels/todo_list_viewmodel.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Consumer<TodoListViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            itemCount: viewModel.todos.length,
            itemBuilder: (context, index) {
              final todo = viewModel.todos[index];
              return ListTile(
                title: Text(todo.title),
                subtitle: Text(
                  '${todo.description}\nDue: ${DateFormat.yMMMd().add_jm().format(todo.dueDate)}',
                ),
                isThreeLine: true,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _showEditTodoDialog(context, viewModel, index, todo);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        viewModel.delete(index);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddTodoDialog(BuildContext context) async {
    String title = '';
    String description = '';
    DateTime? dueDate;
    final viewModel = Provider.of<TodoListViewModel>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'Title'),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Description'),
                onChanged: (value) {
                  description = value;
                },
              ),
              TextButton(
                onPressed: () async {
                  dueDate = await _selectDateTime(context);
                },
                child: Text('Select Due Date'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (title.isNotEmpty &&
                    description.isNotEmpty &&
                    dueDate != null) {
                  viewModel.add(title, description, dueDate!);
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditTodoDialog(BuildContext context,
      TodoListViewModel viewModel, int index, todo) async {
    String newTitle = todo.title;
    String newDescription = todo.description;
    DateTime newDueDate = todo.dueDate;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'Title'),
                controller: TextEditingController(text: newTitle),
                onChanged: (value) {
                  newTitle = value;
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Description'),
                controller: TextEditingController(text: newDescription),
                onChanged: (value) {
                  newDescription = value;
                },
              ),
              TextButton(
                onPressed: () async {
                  newDueDate = await _selectDateTime(context) ?? newDueDate;
                },
                child: Text('Select Due Date'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newTitle.isNotEmpty && newDescription.isNotEmpty) {
                  viewModel.edit(index, newTitle, newDescription, newDueDate);
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<DateTime?> _selectDateTime(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        return DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
      }
    }
    return null;
  }
}
