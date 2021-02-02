import 'Meal.dart';

class MealResponse {
  final List<Meal> meal;
  final String error;

  MealResponse(this.meal, this.error);

  MealResponse.fromJson(Map<String, dynamic> json)
      : meal = (json["categories"] as List)
      .map((i) => new Meal.fromJson(i))
      .toList(),
        error = "";

  MealResponse.withError(String errorValue)
      : meal = List(),
        error = errorValue;
}