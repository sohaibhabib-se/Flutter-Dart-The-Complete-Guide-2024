import 'package:flutter/material.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

import '../data/dummy_data.dart';

class CatgoriesScreen extends StatelessWidget {
  const CatgoriesScreen({super.key});

  void _selectCategory(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => MealsScreen(title: "Some title", meals: [])));//push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick your category"),
      ),
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for(final category in availableCategories)
            CategoryGridItem(category: category, onSelectCategory: () {
              _selectCategory(context);
            },),
        ],
      ),
    );
  }
}