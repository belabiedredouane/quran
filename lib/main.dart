// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:forqan/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'قراني معي',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(
        title: 'قراني معي',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  var title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool home = true;

  @override
  Widget build(BuildContext context) {
    return (home)
        ? Scaffold(
            appBar: AppBar(
              title: Container(
                alignment: Alignment.center,
                child: Text(
                  "قراني معي",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Kitab',
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/quranBackground.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ألا بذكر الله تطمئن القلوب",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kitab',
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 80, top: 20),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              home = !home;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: TextButton(
                              child: Text(
                                "قائمة السور",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              onPressed: () {
                                setState(() {
                                  home = !home;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Text(
                              "تطبيق من طرف بلبيض رضوان",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.copyright_sharp,
                            size: 15,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        : HomeScreen();
  }
}
