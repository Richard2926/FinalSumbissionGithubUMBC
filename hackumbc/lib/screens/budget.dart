import 'package:flutter/material.dart';
import 'package:hackumbc/components/constants.dart';

class Budget extends StatefulWidget {
  const Budget({Key? key}) : super(key: key);

  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<Budget> {
  bool added = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("hello"),
        ],
      ),
    );
  }
}