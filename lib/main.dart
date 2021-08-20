import 'package:flutter/material.dart';
import 'package:meal_app/models/dummy_data.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/bottom_tab_screen.dart';
import 'package:meal_app/screens/filter_screen.dart';
import 'package:meal_app/screens/meals_detail_screen.dart';
import 'package:meal_app/screens/tab_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/categotry_meals_screen.dart';
import 'screens/categotry_meals_screen.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> _avaliableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];



  void _toggleFavoriteMeals(String mealId) {
    final existanceIndex =
    _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existanceIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existanceIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });

    }
  }

  bool _isMealFavorite(String id){
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  void _setFilter(Map<String, bool> filteredData) {
    setState(() {
      _filters = filteredData;

      _avaliableMeals = DUMMY_MEALS.where((meals) {
        if (_filters['gluten'] == true && !meals.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] == true && !meals.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] == true && !meals.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] == true && !meals.isVegetarian) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: CategoriesScreen(),
      routes: {
        '/': (ctx) => BottomTabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_avaliableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavoriteMeals,_isMealFavorite),
        FilterScreen.routeName: (ctx) => FilterScreen(_filters, _setFilter),
      },
    );
  }
}
