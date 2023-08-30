import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/todocontroller.dart';

// import 'package:todoapp/Pages/todopage.dart';

class DialogTodo extends StatefulWidget {
  const DialogTodo({super.key});

  @override
  State<DialogTodo> createState() => _DialogTodoState();
}

class _DialogTodoState extends State<DialogTodo> {
  Map data = {"Task": "", "Time": "", "Dropdown": "AT HOME", "Changed": false};

  final formKey = GlobalKey<FormState>();
  TextEditingController task = TextEditingController();
  final DropdownController dropcontroller = Get.put(DropdownController());
  @override
  Widget build(BuildContext context) {
    List option = ["AT OFFICE", "AT HOME", "AWAY"];
    return Form(
      key: formKey,
      child: AlertDialog(
        title: const Text("Add Task"),
        content: const Text("Add the Task for the List"),
        actions: [
          TextFormField(
            decoration: const InputDecoration(hintText: "Task"),
            controller: task,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return ("Please Enter a Task");
              }
              return (null);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text("Location :- "),
              Obx(
                () => DropdownButton(
                  value: dropcontroller.createdialog.value,
                  items: option
                      .map<DropdownMenuItem<String>>(
                          (e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) =>
                      {dropcontroller.createdialogchanger(value!)},
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  data['Dropdown'] = dropcontroller.createdialog.value;
                  data['Changed'] = true;
                  data['Task'] = task.text;
                  data['Time'] =
                      "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
                  Navigator.pop(context, data);
                }
              },
              child: const Text("Add Task")),
        ],
      ),
    );
  }
}
