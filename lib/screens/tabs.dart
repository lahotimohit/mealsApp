import 'package:flutter/material.dart';
import 'package:mealsapp/screens/categories.dart';
import 'package:mealsapp/screens/meals.dart';
import 'package:mealsapp/models/meal.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends State<TabsScreen> {
  var selectPageIndex = 0;

  final List<Meal> _favoriteMeals = [];

  void _ontoggleFavMealStatus(Meal meal) {
    if (_favoriteMeals.contains(meal)) {
      _favoriteMeals.remove(meal);
    } else {
      _favoriteMeals.add(meal);
    }
  }

  void setPage(index) {
    setState(() {
      selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var selectPageTitle = "Categories";
    Widget currentPage = CategoriesScreen(
      onToggleFavourite: _ontoggleFavMealStatus,
    );

    if (selectPageIndex == 1) {
      currentPage = MealsScreen(
        meal: _favoriteMeals,
        onToggleFavourite: _ontoggleFavMealStatus,
      );
      selectPageTitle = "Your Favourites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(selectPageTitle),
      ),
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: setPage,
        currentIndex: selectPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favourites")
        ],
      ),
    );
  }
}
