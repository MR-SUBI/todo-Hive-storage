import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todoapp/util/todo_tile.dart';

class HomePageTo extends StatefulWidget {
  const HomePageTo({super.key});

  @override
  State<HomePageTo> createState() => _HomePageToState();
}

class _HomePageToState extends State<HomePageTo> {
  List todolist = [
    ["Make Project", false],
    ["Make book", false],
  ];

  //checkbox taped;
  void checkboxChanged(bool? value, int index){
    setState(() {
      todolist[index][1] = !todolist[index][1];
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          title: Text('TO DO'),
          centerTitle: true,
          elevation: 0,
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
}
