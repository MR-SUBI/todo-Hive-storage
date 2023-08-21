import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todoapp/util/dilogBox.dart';
import 'package:todoapp/util/todo_tile.dart';

class HomePageTo extends StatefulWidget {
  const HomePageTo({super.key});

  @override
  State<HomePageTo> createState() => _HomePageToState();
}

class _HomePageToState extends State<HomePageTo> {
  final _controller = TextEditingController();

  List todolist = [
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          title: Text('TO DO'),
          centerTitle: true,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: todolist.length,
          itemBuilder: ((context, index) {
            return TodoTile(
                taskName: todolist[index][0],
                taskComplete: todolist[index][1],
                onChanged: (value) => checkboxChanged(value, index));
          }),
        ));
  }

  //checkbox taped;
  void checkboxChanged(bool? value, int index) {
    setState(() {
      todolist[index][1] = !todolist[index][1];
    });
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void saveNewTask() {
    setState(() {
    todolist.add([_controller.text, false]);
      
    });
    Navigator.of(context).pop();
  }
}
