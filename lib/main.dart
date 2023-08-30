import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Controller/todocontroller.dart';
import 'Pages/todopage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Todo App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      // unknownRoute: GetPage(name: '/notfound', page: () => UnknownRoutePage()), //like 404 page in web
      getPages: [
        GetPage(name: '/', page: () => const FirstPage()),
        GetPage(
          name: '/todo',
          page: () => const TodoList(),
          // transition: Transition.zoom
        ),
      ],
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    super.initState();
    var duration = const Duration(seconds: 1);

    Timer(duration, () => Get.offAllNamed("/todo"));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.flutter_dash, size: 150),
              Text(
                "Todo App",
                style: TextStyle(fontSize: 50),
              ),
            ]),
      ),
    );
  }
}
