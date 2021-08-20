import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/meal_item.dart';
import '../models/dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const String routeName = "/category-meals";

  final List<Meal> avaliableMeals;
  CategoryMealsScreen(this.avaliableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
 late String? categoryTitile;
 late  List<Meal> displayMeals;
 var _loadedDataInit = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(!_loadedDataInit){
      final routeArg =
      ModalRoute.of(context)?.settings?.arguments as Map<String, String>;
      categoryTitile = routeArg['title'];
      final categoryId = routeArg['id'];
      displayMeals = widget.avaliableMeals.where((male) {
        return male.categories.contains(categoryId);
      }).toList();

      _loadedDataInit = true;
    }

    super.didChangeDependencies();
  }

  void _removeMale(String mealId) {
    setState(() {
      displayMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitile!),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayMeals[index].id,
              title: displayMeals[index].title,
              imageUrl: displayMeals[index].imageUrl,
              duration: displayMeals[index].duration,
              complexity: displayMeals[index].complexity,
              affordability: displayMeals[index].affordability,
            //  removeItem: _removeMale,
            );
          },
          itemCount: displayMeals.length,
        ));
  }
}
