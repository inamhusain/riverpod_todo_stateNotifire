// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, prefer_final_fields, unused_field, must_be_immutable, use_key_in_widget_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo/models/todo.dart';
import 'package:riverpod_todo/providers/state_provider.dart';

import '../utils.dart';

final _todoProvider =
    StateNotifierProvider<StateProviderHalper, List<Todo>>((ref) {
  return StateProviderHalper();
});

class AddTodoScreen extends ConsumerWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subTitleController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(_todoProvider);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.grey900,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.black,
        title: Text(
          'Todos'.toUpperCase(),
          style: TextStyle(
              fontSize: Utils.fontsize(context: context, fontsize: 8),
              letterSpacing: width * 0.008,
              color: AppColors.deepPurple),
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: width * 0.03, vertical: height * 0.03),
          child: SingleChildScrollView(
            child: Column(
              children: [
                commonTextField(
                    width: width,
                    context: context,
                    lableText: 'Title',
                    controller: _titleController),
                SizedBox(height: height * 0.03),
                commonTextField(
                    width: width,
                    context: context,
                    lableText: 'Sub Title',
                    controller: _subTitleController),
                SizedBox(height: height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    commonButton(
                        height: height,
                        onPressed: () {
                          ref.read(_todoProvider.notifier).addTodo(
                              title: _titleController.text,
                              subTitle: _subTitleController.text);

                          _titleController.clear();
                          _subTitleController.clear();
                        },
                        width: width,
                        context: context,
                        text: 'submit'),
                    SizedBox(
                      width: width * 0.03,
                    ),
                  ],
                ),
                Divider(
                  color: AppColors.deepPurple,
                  thickness: 2,
                  height: height * 0.05,
                ),
                Text(
                  'Last Added Todo',
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: Utils.fontsize(
                        context: context,
                        fontsize: 5,
                      ),
                      letterSpacing: width * 0.02),
                ),
                SizedBox(height: height * 0.03),
                todosListView(
                  height: height,
                  context: context,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  todosListView({height, context}) {
    return Consumer(
      builder: (context, ref, child) {
        var todos = ref.watch(_todoProvider);
        return SizedBox(
            height: height * 0.45,
            child: todos.isNotEmpty
                ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: todos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: AppColors.grey700,
                        child: ListTile(
                          title: Text(
                            "${todos[index].title.toString()}",
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: Utils.fontsize(
                                    context: context, fontsize: 6)),
                          ),
                          subtitle: Text(todos[index].subTitle.toString()),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: AppColors.black,
                            ),
                            onPressed: () {
                              ref
                                  .read(_todoProvider.notifier)
                                  .deleteTodo(todos[index]);
                            },
                          ),
                        ),
                      );
                    },
                  )
                : Text('No Data Found'));
      },
    );
  }

  commonTextField({width, context, lableText, controller}) {
    return TextField(
      controller: controller,
      cursorColor: AppColors.deepPurple,
      style: TextStyle(
          color: AppColors.white,
          letterSpacing: width * 0.007,
          fontWeight: FontWeight.bold,
          fontSize: Utils.fontsize(context: context, fontsize: 7),
          decoration: TextDecoration.none),
      decoration: InputDecoration(
        label: Text("${lableText}".toUpperCase()),
        labelStyle: TextStyle(
            color: AppColors.white,
            fontSize: Utils.fontsize(context: context, fontsize: 5)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: AppColors.white,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: AppColors.deepPurple,
            width: 2.0,
          ),
        ),
      ),
    );
  }

  commonButton(
      {required void Function()? onPressed, height, width, context, text}) {
    return MaterialButton(
      color: AppColors.deepPurple,
      shape: StadiumBorder(),
      elevation: 5,
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.07, vertical: height * 0.015),
        child: Text(
          '$text'.toUpperCase(),
          style: TextStyle(
              color: AppColors.white,
              letterSpacing: width * 0.008,
              fontSize: Utils.fontsize(
                context: context,
                fontsize: 6,
              )),
        ),
      ),
    );
  }
}
