import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoController extends GetxController {
  var all = [].obs;
  void setdata(data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String>? alltodos = prefs.getStringList('mytodo');
    if (alltodos == null) {
      prefs.setStringList("mytodo", []);
    } else {
      String encode = json.encode(data);
      alltodos.add(encode);
      prefs.setStringList("mytodo", alltodos);
      getdata();
    }
  }

  void getdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List? alltodos = prefs.getStringList("mytodo");

    if (alltodos == null) {
      prefs.setStringList("mytodo", []);
    } else {
      all.value = alltodos;
    }
  }

  void deleteData(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? alltodos = prefs.getStringList('mytodo');
    if (alltodos == null) {
      prefs.setStringList("mytodo", []);
    } else {
      alltodos.removeAt(index);
      prefs.setStringList("mytodo", alltodos);
      getdata();
    }
  }

  void updatedata(data, index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? alltodos = prefs.getStringList("mytodo");
    if (alltodos == null) {
      prefs.setStringList("mytodo", []);
    } else {
      String encode = json.encode(data);
      alltodos[index] = encode;
      prefs.setStringList("mytodo", alltodos);
      getdata();
    }
  }
}

class DropdownController extends GetxController {
  var updatedialog = "".obs;
  var createdialog = "AT HOME".obs;
  void updatedialogchanger(String value) {
    updatedialog.value = value;
  }

  void createdialogchanger(String value) {
    createdialog.value = value;
  }
}
