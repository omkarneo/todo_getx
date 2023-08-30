import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todo_getx/Controller/todocontroller.dart';
import 'package:todo_getx/Pages/updatedialog.dart';
import 'dart:convert';

import 'dialog.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});
  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(seconds: 1));
    controller.getdata();
  }

  final TodoController controller = Get.put(TodoController());
  final DropdownController dropcontroller = Get.put(DropdownController());
  @override
  Widget build(BuildContext context) {
    controller.getdata();
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO"),
      ),
      body: Obx(
        () => ListView.separated(
            // reverse: true,
            itemCount: controller.all.length,
            // itemExtent: 60,
            padding: const EdgeInsets.all(20),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
            itemBuilder: (context, index) {
              var sd = json.decode(controller.all[index]);
              print(sd);
              return ListTile(
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: Text("${sd["Task"]}"),

                subtitle: Text("${sd["Dropdown"]} ${sd["Time"]} "),

                leading: const Icon(Icons.add_task_rounded),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => {controller.deleteData(index)},
                ),
                onLongPress: () async {
                  dropcontroller.updatedialogchanger(sd['Dropdown']);
                  Map data = await showDialog(
                      context: context,
                      builder: (context) => UpdateDialogTodo(data: sd));

                  if (data['Changed'] == true) {
                    controller.updatedata(data, index);
                  }
                },
                // tileColor: ,
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          dropcontroller.createdialogchanger("AT HOME");
          Map todotask = await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => const DialogTodo());
          if (todotask['Changed'] == true) {
            controller.setdata(todotask);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
