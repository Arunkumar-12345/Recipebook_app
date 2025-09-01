class Recipe {
  final String title;
  final String description;
  final String ingredients;
  final String steps;
  final String category; // Veg or Non-Veg

  Recipe({
    required this.title,
    required this.description,
    required this.ingredients,
    required this.steps,
    required this.category,
  });
}
