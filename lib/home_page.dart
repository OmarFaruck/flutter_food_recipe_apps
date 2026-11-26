import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_recipe_apps/Model/food_recipe.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  final String jsonData = '''
  {
    "recipes": [
      {
        "title": "Pasta Carbonara",
        "description": "Creamy pasta dish with bacon and cheese.",
        "ingredients": ["spaghetti", "bacon", "egg", "cheese"]
      },
      {
        "title": "Caprese Salad",
        "description": "Simple and refreshing salad with tomatoes, mozzarella, and basil.",
        "ingredients": ["tomatoes", "mozzarella", "basil"]
      },
      {
        "title": "Banana Smoothie",
        "description": "Healthy and creamy smoothie with bananas and milk.",
        "ingredients": ["bananas", "milk"]
      },
      {
        "title": "Chicken Stir-Fry",
        "description": "Quick and flavorful stir-fried chicken with vegetables.",
        "ingredients": ["chicken breast", "broccoli", "carrot", "soy sauce"]
      },
      {
        "title": "Grilled Salmon",
        "description": "Delicious grilled salmon with lemon and herbs.",
        "ingredients": ["salmon fillet", "lemon", "olive oil", "dill"]
      },
      {
        "title": "Vegetable Curry",
        "description": "Spicy and aromatic vegetable curry.",
        "ingredients": ["mixed vegetables", "coconut milk", "curry powder"]
      },
      {
        "title": "Berry Parfait",
        "description": "Layered dessert with fresh berries and yogurt.",
        "ingredients": ["berries", "yogurt", "granola"]
      }
    ]
  }
  ''';

  List<FoodRecipe> parseRecipes(String jsonData) {
    final Map<String, dynamic> data = json.decode(jsonData);
    final List<dynamic> recipesJson = data['recipes'];
    return recipesJson.map((json) => FoodRecipe.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Food Recipe App'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: parseRecipes(jsonData).length,
        itemBuilder: (context, index) {
          final recipe = parseRecipes(jsonData)[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: ListTile(
              title: Text(recipe.title),
              subtitle: Text(recipe.description),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(recipe.title),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(recipe.description),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Ingredients:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ...recipe.ingredients.map(
                          (ingredient) => Text('- $ingredient'),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
