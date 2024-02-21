class MealModel {
  String idMeal;
  String strMeal;
  String strCategory;
  String strArea;

  MealModel({
    required this.idMeal,
    required this.strMeal,

    required this.strCategory,
    required this.strArea,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],

      strCategory: json['strCategory'],
      strArea: json['strArea'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idMeal'] = this.idMeal;
    data['strMeal'] = this.strMeal;

    data['strCategory'] = this.strCategory;
    data['strArea'] = this.strArea;
    return data;
  }
}
