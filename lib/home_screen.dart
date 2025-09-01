import 'package:flutter/material.dart';
import 'recipe_app.dart';
import 'recipe_screen.dart';
import 'recipe_detail.dart';
import 'payment_screen.dart';
import 'order_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Recipe> recipes = [
    // Veg Recipes
    Recipe(title: 'Spaghetti', description: 'Classic Italian pasta', ingredients: 'Pasta, Tomato Sauce', steps: 'Boil pasta, add sauce', category: 'Veg'),
    Recipe(title: 'Paneer Butter Masala', description: 'Rich creamy curry', ingredients: 'Paneer, Butter, Spices', steps: 'Cook paneer in masala', category: 'Veg'),
    Recipe(title: 'Veg Biryani', description: 'Fragrant rice with vegetables', ingredients: 'Rice, Vegetables, Spices', steps: 'Cook rice with veggies and spices', category: 'Veg'),
    Recipe(title: 'Mixed Veg Curry', description: 'Vegetables cooked in gravy', ingredients: 'Mixed Vegetables', steps: 'Cook veggies in sauce', category: 'Veg'),
    Recipe(title: 'Veg Sandwich', description: 'Quick and tasty', ingredients: 'Bread, Veggies, Sauce', steps: 'Assemble sandwich', category: 'Veg'),
    Recipe(title: 'Caesar Salad', description: 'Fresh salad with dressing', ingredients: 'Lettuce, Dressing, Croutons', steps: 'Mix all ingredients', category: 'Veg'),
    Recipe(title: 'Stuffed Capsicum', description: 'Bell peppers with stuffing', ingredients: 'Capsicum, Stuffing', steps: 'Stuff peppers and bake', category: 'Veg'),
    Recipe(title: 'Veg Pulao', description: 'Light rice dish', ingredients: 'Rice, Vegetables', steps: 'Cook rice with veggies', category: 'Veg'),

    // Non-Veg Recipes
    Recipe(title: 'Chicken Curry', description: 'Spicy Indian chicken curry', ingredients: 'Chicken, Spices', steps: 'Cook chicken with spices', category: 'Non-Veg'),
    Recipe(title: 'Grilled Fish', description: 'Lightly spiced and grilled', ingredients: 'Fish, Spices', steps: 'Marinate fish and grill', category: 'Non-Veg'),
    Recipe(title: 'Mutton Biryani', description: 'Fragrant rice with mutton', ingredients: 'Rice, Mutton, Spices', steps: 'Cook rice with mutton', category: 'Non-Veg'),
    Recipe(title: 'Egg Curry', description: 'Eggs in spicy gravy', ingredients: 'Eggs, Spices', steps: 'Cook eggs in sauce', category: 'Non-Veg'),
    Recipe(title: 'Prawn Masala', description: 'Tangy prawn curry', ingredients: 'Prawns, Spices', steps: 'Cook prawns with masala', category: 'Non-Veg'),
    Recipe(title: 'Chicken Tikka', description: 'Grilled marinated chicken', ingredients: 'Chicken, Spices', steps: 'Marinate and grill chicken', category: 'Non-Veg'),
    Recipe(title: 'Fish Fry', description: 'Crispy fried fish', ingredients: 'Fish, Oil, Spices', steps: 'Fry the fish until crispy', category: 'Non-Veg'),
    Recipe(title: 'Chicken Biryani', description: 'Fragrant rice with chicken', ingredients: 'Rice, Chicken, Spices', steps: 'Cook rice with chicken', category: 'Non-Veg'),
  ];

  String selectedCategory = 'All';
  Map<Recipe, bool> selectedItems = {};

  @override
  void initState() {
    super.initState();
    for (var r in recipes) {
      selectedItems[r] = false; // Initially not selected
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Recipe> filteredRecipes = selectedCategory == 'All'
        ? recipes
        : recipes.where((r) => r.category == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Book'),
        actions: [
          IconButton(
            icon: const Icon(Icons.payment),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaymentScreen(),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newRecipe = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddRecipeScreen(),
            ),
          );

          if (newRecipe != null && newRecipe is Recipe) {
            setState(() {
              recipes.add(newRecipe);
              selectedItems[newRecipe] = false;
            });
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Category Filter Buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                categoryButton('All'),
                categoryButton('Veg'),
                categoryButton('Non-Veg'),
              ],
            ),
          ),
          // Recipe List
          Expanded(
            child: ListView.builder(
              itemCount: filteredRecipes.length,
              itemBuilder: (context, index) {
                final recipe = filteredRecipes[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Checkbox(
                      value: selectedItems[recipe] ?? false,
                      onChanged: (val) {
                        setState(() {
                          selectedItems[recipe] = val!;
                        });
                      },
                    ),
                    title: Text(recipe.title),
                    subtitle: Text(recipe.description),
                    trailing: Text(recipe.category),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RecipeDetailScreen(recipe: recipe),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          // Go to Order Screen Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                List<Recipe> orderItems = selectedItems.entries
                    .where((entry) => entry.value)
                    .map((entry) => entry.key)
                    .toList();
                if (orderItems.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Select at least one item")),
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderScreen(orderItems: orderItems),
                  ),
                );
              },
              child: const Text(
                "Go to Order",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget categoryButton(String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedCategory = category;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              selectedCategory == category ? Colors.orangeAccent : Colors.grey,
        ),
        child: Text(category),
      ),
    );
  }
}
