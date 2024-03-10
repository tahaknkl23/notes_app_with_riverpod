import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_state/providers/todo_list_manager.dart';
import 'package:uuid/uuid.dart';
import '../models/todo_model.dart';

enum TodoListFilter {
  all,
  active,
  completed,
}

final todoListFilter = StateProvider<TodoListFilter>((ref) => TodoListFilter.all);

final todoListProvider = StateNotifierProvider<TodoListManager, List<TodoModel>>((ref) {
  return TodoListManager([
    TodoModel(id: const Uuid().v4(), description: 'spora git', completed: true),
    TodoModel(id: const Uuid().v4(), description: 'Alisveris yap', completed: true),
    TodoModel(id: const Uuid().v4(), description: 'Ders calis', completed: false),
    TodoModel(id: const Uuid().v4(), description: 'Yemek yap', completed: false),
  ]);
});

final filterTodoList = Provider<List<TodoModel>>((ref) {
  final filter = ref.watch(todoListFilter);
  final allTodo = ref.watch(todoListProvider);
  switch (filter) {
    // Use filter directly
    case TodoListFilter.all:
      return allTodo;
    case TodoListFilter.completed:
      return allTodo.where((todo) => todo.completed).toList();
    case TodoListFilter.active:
      return allTodo.where((todo) => !todo.completed).toList();
    default:
      return []; // Return an empty list as the default value
  }
});
final unCompletedTodoCount = Provider<int>((ref) {
  final allTodo = ref.watch(todoListProvider);
  final count = allTodo.where((todo) => !todo.completed).length;
  return count;
});

final currentTodo = Provider<TodoModel?>((ref) {
  throw UnimplementedError();
});
