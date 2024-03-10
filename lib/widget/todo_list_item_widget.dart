import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_state/models/todo_model.dart';

import '../providers/all_providers.dart';

class TodoListItemWidget extends ConsumerWidget {
  final TodoModel item;
  final FocusNode _textFocusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  final bool _hasfocus = false;

  TodoListItemWidget({
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          _textEditingController.text = item.description;
        } else {
          ref.read(todoListProvider.notifier).edit(id: item.id, newDescription: _textEditingController.text);
        }
      },
      child: ListTile(
        onTap: () {
          FocusScope.of(context).requestFocus(_textFocusNode);
        },
        leading: Checkbox(
            value: item.completed,
            onChanged: (value) {
              ref.read(todoListProvider.notifier).toggle(item.id);
            }),
        title: _hasfocus ? const TextField() : Text(item.description),
      ),
    );
  }
}
