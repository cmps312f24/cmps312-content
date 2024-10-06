import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/providers/todo_list_provider.dart';
import 'package:state_management/providers/todo_filter_provider.dart';
import 'package:state_management/widgets/todo_tile.dart';
import 'package:state_management/widgets/todo_toolbar.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(filteredTodos);
    final newTodoController = TextEditingController();

    return GestureDetector(
      onTap: () =>
          // Dismiss keyboard on tap outside
          FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              TextField(
                controller: newTodoController,
                decoration: const InputDecoration(
                  labelText: 'What needs to be done?',
                ),
                onSubmitted: (value) {
                  ref.read(todoListProvider.notifier).add(value);
                  newTodoController.clear();
                },
              ),
              const SizedBox(height: 24),
              const TodoToolbar(),
              if (todos.isNotEmpty) const Divider(height: 0),
              Expanded(
                child: ListView.builder(
                  itemCount: todos.length,
/*                   separatorBuilder: (context, index) =>
                      const Divider(height: 0), */
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return Dismissible(
                      key: ValueKey(todo.id),
                      onDismissed: (_) {
                        ref.read(todoListProvider.notifier).remove(todo.id);
                      },
                      child: ProviderScope(
                        overrides: [
                          currentTodo.overrideWithValue(todo),
                        ],
                        child: const TodoTile(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
