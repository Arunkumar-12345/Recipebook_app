import 'package:flutter/material.dart';
import 'recipe_app.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Description: ${recipe.description}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text('Ingredients: ${recipe.ingredients}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text('Steps: ${recipe.steps}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text('Category: ${recipe.category}', style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
