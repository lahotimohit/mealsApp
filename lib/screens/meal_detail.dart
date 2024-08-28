import 'package:flutter/material.dart';
import 'package:mealsapp/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({super.key, required this.mealItem});
  final Meal mealItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mealItem.title),
      ),
      body: Image.network(
        mealItem.imageUrl,
        width: double.infinity,
        height: 300,
        fit: BoxFit.cover,
      ),
    );
  }
}
