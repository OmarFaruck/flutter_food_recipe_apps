class FoodRecipe {
  final String title;
  final String description;
  final List<String> ingredients;

  FoodRecipe({
    required this.title,
    required this.description,
    required this.ingredients,
  });

  factory FoodRecipe.fromJson(Map<String, dynamic> json) {
    return FoodRecipe(
      title: json['title'],
      description: json['description'],
      ingredients: List<String>.from(json['ingredients']),
    );
  }
}
