import '../constants/constants.dart';

class ItemFilterModel {
  final String itemCategory;
  final String itemSubCategory;
  final String companyCategory;
  final String companyName;
  final String brand;
  final String series;
  final String date;
  final String color;
  final String country;
  final String city;

  ItemFilterModel({
    required this.date,
    required this.itemCategory,
    required this.brand,
    required this.series,
    required this.itemSubCategory,
    required this.color,
    required this.companyName,
    required this.companyCategory,
    required this.city,
    required this.country,
  });

  Map<String, dynamic> toJson() {
    return {
      AppText.checkFilterItemCat: itemCategory,
      AppText.checkFilterItemSubCat: itemSubCategory,
      AppText.checkFilterComCat: companyCategory,
      AppText.checkFilterComName: companyName,
      AppText.checkFilterBrand: brand,
      AppText.checkFilterSeries: series,
      AppText.checkFilterDate: date,
      AppText.checkFilterColor: color,
      AppText.checkFilterCountry: country,
      AppText.checkFilterCity: city,
    };
  }
}
