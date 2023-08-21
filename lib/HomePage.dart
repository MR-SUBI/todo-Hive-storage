import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/util/dilogBox.dart';
import 'package:todoapp/util/todo_tile.dart';

class HomePageTo extends StatefulWidget {
  const HomePageTo({super.key});

  @override
  State<HomePageTo> createState() => _HomePageToState();
}

class _HomePageToState extends State<HomePageTo> {

  //reference the hive box
  final _myBox = Hive.box('myBox');
  TodoDatabase db = TodoDatabase();

  final _controller = TextEditingController();

  @override
  void initState() {

      if(_myBox.get("TODOLIST")== null){
        db.createinitialData();

      }
      else{
        db.loadData();
      }


    super.initState();
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
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: db.todolist.length,
          itemBuilder: ((context, index) {
            return TodoTile(

                taskName: db.todolist[index][0],
                taskComplete: db.todolist[index][1],
                deleteFunction: (context) =>deleteTask(index) ,
                onChanged: (value) => checkboxChanged(value, index));
          }),
        ));
  }

  //checkbox taped;
  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.todolist[index][1] = !db.todolist[index][1];

    });
    db.uPDATEData();
  }
  void deleteTask(int index){
    setState(() {
      db.todolist.removeAt(index); 
    });
    db.uPDATEData();

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
    db.uPDATEData();

  }

  void saveNewTask() {
    setState(() {
    db.todolist.add([_controller.text, false]);
      
    });
    Navigator.of(context).pop();
    db.uPDATEData();

  }
}
