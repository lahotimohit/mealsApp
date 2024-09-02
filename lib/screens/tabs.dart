import 'package:flutter/material.dart';
import 'package:mealsapp/data/dummy_data.dart';
import 'package:mealsapp/screens/categories.dart';
import 'package:mealsapp/screens/filters.dart';
import 'package:mealsapp/screens/meals.dart';
import 'package:mealsapp/models/meal.dart';
import 'package:mealsapp/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegeterian: false,
  Filter.vegan: false
};

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
  Map<Filter, bool> _selectedFilters = kInitialFilters;

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

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "Filters") {
      final result =
          await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
              builder: (ctx) => FiltersScreen(
                    currentFilters: _selectedFilters,
                  )));
      _selectedFilters = result ?? kInitialFilters;
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeal = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegeterian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    var selectPageTitle = "Categories";
    Widget currentPage = CategoriesScreen(
      onToggleFavourite: _ontoggleFavMealStatus,
      availableMeals: availableMeal,
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
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
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
