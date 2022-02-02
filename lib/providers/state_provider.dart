import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo/models/todo.dart';

class StateProviderHalper extends StateNotifier<List<Todo>> {
  StateProviderHalper() : super([]);

  addTodo({title, subTitle}) {
    // it add current state + new todo
    var id = 0;
    if (state.isNotEmpty) {
      id = state.last.id;
    } else {
      id = 0;
    }
    id++;
    state = [...state, Todo(id: id, title: title, subTitle: subTitle)];
  }

  deleteTodo(Todo todo) {
    // state = state;
    state = state.where((_todo) => _todo.id != todo.id).toList();
  }
}
