import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todo_app/models/tasks_data.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String newTaskTitle = 's';
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 20.0, left: 35.0, right: 35.0, bottom: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add Task',
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 25.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              autofocus: true,
              cursorColor: Colors.lightBlueAccent,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Your Task',
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w200,
                ),
                fillColor: Colors.grey.withOpacity(0.1),
                filled: true,
                border: InputBorder.none,
              ),
              onChanged: (value) {
                newTaskTitle = value;
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
              ),
              onPressed: () {
                Provider.of<TasksData>(context, listen: false)
                    .addTask(newTaskTitle);
                Navigator.pop(context);
              },
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
