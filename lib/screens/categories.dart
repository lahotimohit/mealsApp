import 'package:flutter/material.dart';
import 'package:mealsapp/data/dummy_data.dart';
import 'package:mealsapp/models/category.dart';
import 'package:mealsapp/screens/meals.dart';
import 'package:mealsapp/widgets/category_grid_item.dart';
import 'package:mealsapp/models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key,
      required this.onToggleFavourite,
      required this.availableMeals});

  final void Function(Meal meal) onToggleFavourite;
  final List<Meal> availableMeals;

  void _selectedCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScreen(
              title: category.title,
              meal: filteredMeals,
              onToggleFavourite: onToggleFavourite,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onselectedCategory: () {
              _selectedCategory(context, category);
            },
          )
      ],
    );
  }
}
