import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista2_flutter/Widgets/todo_list_item.dart';
import '../Models/todo_item.dart';
import '../Repositories/todo_repository.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final TodoRepository todoRepository = TodoRepository();
  final TextEditingController textController = TextEditingController();
  late List<Todo> todos = [];

  String? erroText;
  late Todo _lastDelete;
  late int _lastDeletePos;

  Future<void> _onRefresh() async{
  await Future.delayed(Duration(seconds: 1));
  setState(() {
    todos.sort((a,b){
      if(a.check && !b.check) return 1;
      else if(!a.check && b.check) return -1;
      else return 0;
    });
    saveData();
  });

  }

  void deleteItem(Todo item) {
    setState(() {
      _lastDeletePos = todos.indexOf(item);
      _lastDelete = item;
      todos.remove(item);
      saveData();

      ScaffoldMessenger.of(context).clearSnackBars();

      final snackBar = SnackBar(
        content: Text('Tarefa (${_lastDelete.title}) Removida!!'),
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: Colors.blue,
          onPressed: () {
            setState(() {
              todos.insert(_lastDeletePos, _lastDelete);
              saveData();
            });
          },
        ),
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  void saveData() {
    setState(() {
      todoRepository.saveTodoList(todos);
      print("ok");
    });
  }

  void addTodo(String value) {
    setState(() {
      erroText = null;
      value == '' ? erroText = 'O Titulo Esta Vazio!' : todos.add(Todo(value));
      textController.clear();
      saveData();
    });
  }

  @override
  void initState() {
    super.initState();
    todoRepository.getTodoList().then((value) {
      setState(() {
        todos = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Lista De Tarefas",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textController,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.blue,
                        onSubmitted: addTodo,
                        decoration: InputDecoration(
                            errorText: erroText,
                            label: Text('Adicionar Aarefa'),
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 20),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            counterStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue))),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addTodo(textController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(18),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Icon(
                        Icons.add_task,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (Todo todo in todos)
                          TodoListItem(
                            todo: todo,
                            save: saveData,
                            delete: deleteItem,
                          )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
