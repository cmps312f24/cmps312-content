import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/providers/todo_filter_provider.dart';
import 'package:state_management/providers/todo_list_provider.dart';

/// The widget that that displays the components of an individual Todo Item
class TodoTile extends ConsumerStatefulWidget {
  const TodoTile({super.key});

  @override
  _TodoTileState createState() => _TodoTileState();
}

class _TodoTileState extends ConsumerState<TodoTile> {
  late FocusNode itemFocusNode;
  late FocusNode textFieldFocusNode;
  late TextEditingController textEditingController;
  bool itemIsFocused = false;

  @override
  void initState() {
    super.initState();
    itemFocusNode = FocusNode();
    textFieldFocusNode = FocusNode();
    textEditingController = TextEditingController();

    itemFocusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    itemFocusNode.removeListener(_handleFocusChange);
    itemFocusNode.dispose();
    textFieldFocusNode.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      itemIsFocused = itemFocusNode.hasFocus;
    });

    if (!itemIsFocused) {
      final todo = ref.read(currentTodo);
      ref.read(todoListProvider.notifier).edit(
            id: todo.id,
            description: textEditingController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final todo = ref.watch(currentTodo);

    return Material(
      color: Colors.white,
      elevation: 6,
      child: Focus(
        focusNode: itemFocusNode,
        onFocusChange: (focused) {
          if (focused) {
            textEditingController.text = todo.description;
          }
        },
        child: ListTile(
          onTap: () {
            itemFocusNode.requestFocus();
            textFieldFocusNode.requestFocus();
          },
          leading: Checkbox(
            value: todo.completed,
            onChanged: (value) =>
                ref.read(todoListProvider.notifier).toggle(todo.id),
          ),
          title: itemIsFocused
              ? TextField(
                  autofocus: true,
                  focusNode: textFieldFocusNode,
                  controller: textEditingController,
                )
              : Text(todo.description),
        ),
      ),
    );
  }
}
