import 'package:app_resep_makanan/Model/MealResponse.dart';
import 'package:dio/dio.dart';

class MealRepo {
  static String mainUrl = "https://www.themealdb.com/api/json/v1/1";

  final Dio _dio = Dio();
  var getCategory = '$mainUrl/categories.php';

  Future<MealResponse> getCategoryMeal() async {
    try {
      Response response = await _dio.get(getCategory);
      return MealResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MealResponse.withError("$error");
    }
  }
}