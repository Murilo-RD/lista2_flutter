import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista2_flutter/Pages/list_page.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const ListPage();
  }
}
