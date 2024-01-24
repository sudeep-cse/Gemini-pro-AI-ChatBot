import 'package:flutter/material.dart';
import 'package:gemini_pro_ai/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Gemini Pro'),
        ),
        body: const HomePage(),
      ),
    );
  }
}
