import 'package:app_resep_makanan/API/MealRepo.dart';
import 'package:app_resep_makanan/Model/MealResponse.dart';
import 'package:rxdart/rxdart.dart';

class MealList {
  final MealRepo _mealRepo = MealRepo();
  final BehaviorSubject<MealResponse> _subject =
  BehaviorSubject<MealResponse>();

  getListCategoryMeal() async {
    MealResponse response = await _mealRepo.getCategoryMeal();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MealResponse> get subject => _subject;
}

final mealBloc = MealList();