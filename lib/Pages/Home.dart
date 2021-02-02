import 'package:app_resep_makanan/BloC/GetMeal.dart';
import 'package:app_resep_makanan/Model/Meal.dart';
import 'package:app_resep_makanan/Model/MealResponse.dart';
import 'package:flutter/material.dart';

import '../Widget/MealWidget.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,

        title: Text("Meal App"),
      ),
      body: ListView(
        children: [MealWidget()],
      ),
    );
  }
}
