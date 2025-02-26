import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoListItem extends StatefulWidget {
  const TodoListItem({super.key});

  @override
  State<TodoListItem> createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 16,
                ),
                Icon(
                  Icons.crisis_alert_outlined,
                  color: Colors.blue,
                  size: 40,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  'Todo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Checkbox(
                    value: true,
                    onChanged: null,
                    checkColor: Colors.blue,

                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
