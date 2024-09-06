import 'package:todolist/domain/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel({
    required String title,
    required String description,
    required DateTime dueDate, // เพิ่ม required dueDate
  }) : super(
          title: title,
          description: description,
          dueDate: dueDate, // ส่งผ่าน dueDate ไปยัง superclass
        );
}
