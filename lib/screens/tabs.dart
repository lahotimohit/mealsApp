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

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _ontoggleFavMealStatus(Meal meal) {
    if (_favoriteMeals.contains(meal)) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showMessage("Your meal is no longer favourite...");
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showMessage("Meal added to your favourite List...");
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
