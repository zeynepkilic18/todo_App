import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({super.key, required this.task});
  final Todo task;

  @override
  State<TodoItem> createState() => _TodoState();
}

class _TodoState extends State<TodoItem> {
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
    isChecked = widget.task.completed!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: widget.task.completed! ? Colors.grey : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ), //kartın şekliyle oynamamızı sağlar
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /* 
              widget.task.type == Tasktype.note
                  ? Image.asset("lib/assets/images/category_1.png")
                  : widget.task.type == Tasktype.contest
                      ? Image.asset("lib/assets/images/category_3.png")
                      : Image.asset("lib/assets/images/category_2.png"),
              */
              Image.asset("lib/assets/images/category_1.png"),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      widget.task.todo!,
                      style: TextStyle(
                        decoration: widget.task.completed!
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                    ),
                    Text("User: ${widget.task.userId!}",
                        style: TextStyle(
                            decoration: widget.task.completed!
                                ? TextDecoration.lineThrough
                                : TextDecoration.none))
                  ],
                ),
              ),

              Checkbox(
                value: isChecked,
                onChanged: (val) => {
                  setState(
                    () {
                      widget.task.completed = !widget.task.completed!;
                      isChecked = val!; //sadece vaş değişkeni varsa işleme sok
                    },
                  )
                },
              ) //onchanged tetiklendiği zaman value set edilir
            ],
          ),
        ));
  }
}
