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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              mealItem.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 14),
            Text(
              "Ingredients",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            for (final ingredient in mealItem.ingredients)
              Text(
                ingredient,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            const SizedBox(height: 12),
            Text(
              "Steps",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            for (final step in mealItem.steps)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
              )
          ],
        ),
      ),
    );
  }
}
