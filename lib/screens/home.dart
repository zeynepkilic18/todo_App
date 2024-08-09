import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/constants/color.dart';
import 'package:todo_app/constants/tasktype.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/screens/add_new_task.dart';
import 'package:todo_app/service/todo_service.dart';
import 'package:todo_app/todoitem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //List<String> todo = ["Study Lessons", "Run 5K", "Go to party"];
  //List<String> completed = ["Game meetup", "Take out trash"];
  List<Task> todo = [
    Task(
        type: Tasktype.note,
        title: "Study Lessons",
        description: "Study COMP117",
        isCompleted: false),
    Task(
        type: Tasktype.calendar,
        title: "Go to party",
        description: "Attend to party",
        isCompleted: false),
    Task(
        type: Tasktype.contest,
        title: "Run 5K",
        description: "Run 5 kimoleters",
        isCompleted: false),
  ];

  List<Task> completed = [
    Task(
        type: Tasktype.calendar,
        title: "Go to party",
        description: "Attend to party",
        isCompleted: false),
    Task(
        type: Tasktype.contest,
        title: "Run 5K",
        description: "Run 5 kimoleters",
        isCompleted: false),
  ];

  void addNewTask(Task newTask) {
    setState(() {
      todo.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    TodoService todoService = TodoService();

    double deviceWidth = MediaQuery.of(context)
        .size
        .width; //telefonun genişliğine göre ayarlanıcak
    double deviceHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: SafeArea(
        //Widget'ı yukarıdaki ve aşağıdaki tuşlara taşırmaz
        child: Scaffold(
          backgroundColor: HexColor(backgroundColor),
          body: Column(
            children: [
              //Header
              Container(
                width: deviceWidth,
                height: deviceHeight / 3,
                color: const Color.fromARGB(255, 102, 63, 109),
                child: const Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 20), //Top'tan 20lik boşluk bırak
                      child: Text(
                        "July 29,2024",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text(
                        "My Todo List ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              //Top Column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: SingleChildScrollView(
                    //bottom overflow hatası almamak için yaparız
                    child: FutureBuilder(
                      future: todoService.getUncompletedTodos(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const CircularProgressIndicator();
                        } else {
                          return ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return TodoItem(
                                task: snapshot.data![index],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              //Completed Text
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Completed",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              //Bottom Column

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: SingleChildScrollView(
                    child: FutureBuilder(
                      future: todoService.getCompletedTodos(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const CircularProgressIndicator();
                        } else {
                          return ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return TodoItem(
                                task: snapshot.data![index],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddNewTaskScreen(
                      addNewTask: (newTask) => addNewTask(newTask),
                    ),
                  ));
                },
                child: const Text("Add New Task"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
