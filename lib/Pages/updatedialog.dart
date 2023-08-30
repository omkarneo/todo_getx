import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/todocontroller.dart';
// import 'package:todoapp/Pages/todopage.dart';

class UpdateDialogTodo extends StatefulWidget {
  final data;
  const UpdateDialogTodo({super.key, this.data});

  @override
  State<UpdateDialogTodo> createState() => _UpdateDialogTodoState();
}

class _UpdateDialogTodoState extends State<UpdateDialogTodo> {
  Map data = {"Task": "", "Time": "", "Dropdown": "AT HOME", "Changed": false};

  @override
  void initState() {
    task.text = widget.data['Task'];
    data["Task"] = widget.data['Task'];
    data["Time"] = widget.data['Time'];
    data["Dropdown"] = widget.data['Dropdown'];

    super.initState();
  }

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
            onChanged: (value) {
              data["Changed"] = true;
            },
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
                  value: dropcontroller.updatedialog.value,
                  // value: ref.watch(DropdownProvider).updatedialog,
                  items: option
                      .map<DropdownMenuItem<String>>(
                          (e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) => {
                    dropcontroller.updatedialogchanger(value!),
                    // ref.read(DropdownProvider).updatedialogchanger(value),
                    data['Changed'] = true
                  },
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
                  data['Dropdown'] = dropcontroller.updatedialog.value;
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
