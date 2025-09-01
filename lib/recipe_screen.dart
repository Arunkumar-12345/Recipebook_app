import 'package:flutter/material.dart';
import 'package:recipebook_app/recipe_app.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _stepsController = TextEditingController();
  String category = "Veg"; // Default category

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Recipe")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Title
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter recipe title" : null,
                ),

                // Description
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: "Description"),
                ),

                // Ingredients
                TextFormField(
                  controller: _ingredientsController,
                  decoration: const InputDecoration(labelText: "Ingredients"),
                  maxLines: 3,
                ),

                // Steps
                TextFormField(
                  controller: _stepsController,
                  decoration: const InputDecoration(labelText: "Steps"),
                  maxLines: 3,
                ),

                // Category Dropdown
                DropdownButtonFormField<String>(
                  value: category,
                  items: ["Veg", "Non-Veg"]
                      .map((c) => DropdownMenuItem(
                            value: c,
                            child: Text(c),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      category = value!;
                    });
                  },
                  decoration:
                      const InputDecoration(labelText: "Category (Veg/Non-Veg)"),
                ),

                const SizedBox(height: 20),

                // Add Recipe Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Create new recipe
                      final newRecipe = Recipe(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        ingredients: _ingredientsController.text,
                        steps: _stepsController.text,
                        category: category,
                      );

                      // Return recipe to previous screen
                      Navigator.pop(context, newRecipe);
                    }
                  },
                  child: const Text("Add Recipe"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
