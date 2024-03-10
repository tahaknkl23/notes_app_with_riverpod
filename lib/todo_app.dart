import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_state/providers/all_providers.dart';
import 'package:todo_app_state/widget/future_provider_page.dart';
import 'package:todo_app_state/widget/title_widget.dart';
import 'package:todo_app_state/widget/todo_list_item_widget.dart';
import 'package:todo_app_state/widget/toolbar_wdiget.dart';

class TodoApp extends ConsumerWidget {
  TodoApp({super.key});
  final newTodoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(filterTodoList);
    return Scaffold(
        body: ListView(padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40), children: [
      const TitleWidget(),
      TextField(
        controller: newTodoController,
        decoration: const InputDecoration(
          labelText: 'Neler Yapacaksin Bugün?',
        ),
        onSubmitted: (newTodo) {
          ref.read(todoListProvider.notifier).addTodo(newTodo);
          newTodoController.clear();
        },
      ),
      const SizedBox(height: 20),
      const ToolBarWidget(),
      for (var i = 0; i < allTodos.length; i++)
        Dismissible(
            key: ValueKey(allTodos[i].id),
            onDismissed: (_) {
              ref.read(todoListProvider.notifier).remove(allTodos[i]);
            },
            child: TodoListItemWidget(item: allTodos[i])),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FutureProviderExample()));
        },
        child: const Text('Future Provider Example'), // Add this line
      )
    ]));
  }
}
