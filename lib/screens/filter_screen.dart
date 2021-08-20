import 'dart:ffi';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  Map<String, bool> currentFilters;

  FilterScreen(this.currentFilters,this.saveFilters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _isGlutenFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;
  bool _isLactoseFree = false;

  @override
  initState(){
    if(widget.currentFilters['gluten'] == true){
      _isGlutenFree = true;
    } else {
      _isGlutenFree = false;
    }

    if(widget.currentFilters['lactose'] == true){
      _isLactoseFree = true;
    } else {
      _isLactoseFree = false;
    }

    if(widget.currentFilters['vegan'] == true){
      _isVegan = true;
    } else {
      _isVegan = false;
    }

    if(widget.currentFilters['vegetarian'] == true){
      _isVegetarian = true;
    } else {
      _isVegetarian = false;
    }
   // _isGlutenFree = widget.currentFilters['gluten'];
  //  _isLactoseFree = widget.currentFilters['lactose'];
  //  _isVegan = widget.currentFilters['vegan'];
  //  _isVegetarian = widget.currentFilters['vegetarian'];

    super.initState();
  }

  Widget _buildSwitchListTile(String title, String subTitile, bool currentValue,
      Function(bool) updateValue) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(subTitile),
        value: currentValue,
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Filters!'),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  'gluten': _isGlutenFree,
                  'lactose': _isLactoseFree,
                  'vegan': _isVegan,
                  'vegetarian': _isVegetarian
                };
                widget.saveFilters(selectedFilters);
              },
            )
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchListTile(
                      'Gluten-Free',
                      'Only include Gluten Free Meals',
                      _isGlutenFree, (newValue) {
                    setState(() {
                      _isGlutenFree = newValue;
                    });
                  }),
                  _buildSwitchListTile(
                      'Vegan-Free', 'Only include Vegan Free Meals', _isVegan,
                      (newValue) {
                    setState(() {
                      _isVegan = newValue;
                    });
                  }),
                  _buildSwitchListTile(
                      'Vegetarian-Free',
                      'Only include Vegetarian Free Meals',
                      _isVegetarian, (newValue) {
                    setState(() {
                      _isVegetarian = newValue;
                    });
                  }),
                  _buildSwitchListTile(
                      'Lactose-Free',
                      'Only include Lactose Free Meals',
                      _isLactoseFree, (newValue) {
                    setState(() {
                      _isLactoseFree = newValue;
                    });
                  }),
                ],
              ),
            ),
          ],
        ));
  }
}
