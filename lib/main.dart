import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/feature/homepages/view/pages/First.dart';

import 'feature/homepages/view/widgets/bottombar.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 106, 81, 206),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 106, 81, 206),
        ),
      ),
      home: Firstpage()
    );
  }
}