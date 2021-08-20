import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  FavoritScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
          child: Container(
        child: Text('No Favorite Meals added yet!'),
      ));
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoriteMeals[index].id,
            title: favoriteMeals[index].title,
            imageUrl: favoriteMeals[index].imageUrl,
            duration: favoriteMeals[index].duration,
            complexity: favoriteMeals[index].complexity,
            affordability: favoriteMeals[index].affordability,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}
