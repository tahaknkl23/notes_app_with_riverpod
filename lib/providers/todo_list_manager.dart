import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_state/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoListManager extends StateNotifier<List<TodoModel>> {
  TodoListManager(List<TodoModel>? initialTodos) : super(initialTodos ?? []);
  void addTodo(String descriription) {
    var eklenecekTodo = TodoModel(id: const Uuid().v4(), description: descriription);
    state = [...state, eklenecekTodo];
  }

  void toggle(String id) {
    state = [
      for (var todo in state)
        if (todo.id == id) TodoModel(id: id, description: todo.description, completed: !todo.completed) else todo
    ];
  }

  void edit({required id, required String newDescription}) {
    state = [
      for (var todo in state)
        if (todo.id == id) TodoModel(id: id, description: newDescription, completed: todo.completed) else todo
    ];
  }

  void remove(TodoModel silinecekTodo) {
    state = state.where((todo) => todo.id != silinecekTodo.id).toList();
  }

  void onCompletedTodoCount() {
    state.where((todo) => todo.completed).length;
  }
}
