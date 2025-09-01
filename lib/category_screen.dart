import 'package:flutter/material.dart';
import 'recipe_app.dart';

class CategoryScreen extends StatelessWidget {
  final List<Recipe> allrecipes;

  const CategoryScreen({super.key, required this.allrecipes});

  @override
  Widget build(BuildContext context) {
    // Get unique categories from recipes
    final categories = allrecipes
        .map((recipe) => recipe.category)
        .toSet()
        .toList(); // remove duplicates

    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            title: Text(category),
            onTap: () {
              // Filter recipes by category
              final categoryRecipes = allrecipes
                  .where((recipe) => recipe.category == category)
                  .toList();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryRecipesScreen(
                    category: category,
                    recipes: categoryRecipes,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Screen to show recipes of selected category
class CategoryRecipesScreen extends StatelessWidget {
  final String category;
  final List<Recipe> recipes;

  const CategoryRecipesScreen({
    super.key,
    required this.category,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return ListTile(
            title: Text(recipe.title),
            subtitle: Text(recipe.description),
          );
        },
      ),
    );
  }
}
