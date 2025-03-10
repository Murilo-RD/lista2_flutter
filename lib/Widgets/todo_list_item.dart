import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../Models/todo_item.dart';

class TodoListItem extends StatefulWidget {
  const TodoListItem({super.key, required this.todo, required this.save, required this.delete});

  final Function save;
  final Function delete;
  final Todo todo;

  @override
  State<TodoListItem> createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => widget.delete(widget.todo),
              label: 'Delete',
              icon: Icons.delete_outline,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CheckboxListTile(
                secondary: Icon(
                  widget.todo.check
                      ? Icons.check_circle_outline
                      : Icons.crisis_alert_rounded,
                  color: Colors.blue,
                  size: 30,
                ),
                value: widget.todo.check,
                title: Text(
                  widget.todo.title,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onChanged: (context) {
                  setState(() {
                    setState(() {
                      widget.todo.check
                          ? widget.todo.check = false
                          : widget.todo.check = true;
                      widget.save();
                    });
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
