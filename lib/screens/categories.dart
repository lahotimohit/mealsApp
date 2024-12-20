 import 'package:flutter/material.dart';
import 'package:mealsapp/data/dummy_data.dart';
import 'package:mealsapp/models/category.dart';
import 'package:mealsapp/screens/meals.dart';
import 'package:mealsapp/widgets/category_grid_item.dart';
import 'package:mealsapp/models/meal.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen(
      {super.key,
      required this.onToggleFavourite,
      required this.availableMeals});

  final void Function(Meal meal) onToggleFavourite;
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
    late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, 
    duration: const  Duration(milliseconds: 300),
    lowerBound: 0,
    upperBound: 1);

    _animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _selectedCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScreen(
              title: category.title,
              meal: filteredMeals,
              onToggleFavourite: widget.onToggleFavourite,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
    animation: _animationController,
    child: GridView(
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
    ), 
    builder: (context, child) => SlideTransition(
      position: Tween(
        begin: const Offset(0, 0.3),
        end: const Offset(0, 0)
      ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)),
      child: child,)) ;
  }
}
