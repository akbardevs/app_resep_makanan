class Meal {
  final String idCategory;
  final String strCategory;
  final String strCategoryThumb;
  final String strCategoryDescription;

  Meal(this.idCategory, this.strCategory, this.strCategoryThumb, this.strCategoryDescription);

  Meal.fromJson(Map<String, dynamic> json)
      : idCategory = json["idCategory"],
        strCategory = json["strCategory"],
        strCategoryThumb = json["strCategoryThumb"],
        strCategoryDescription = json["strCategoryDescription"];
}