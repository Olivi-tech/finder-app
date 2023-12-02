class AppText {
  static const List<String> categoryList = [
    'Electronic',
    'Cloth',
    'Bag',
    'Sport',
    'key',
    'Toy',
    'Book',
    'Medicine',
    'Accessories',
    'Other',
  ];
  static const List<String> brandList = [
    'Apple',
    'Samsung',
    'Sony',
    'Dell',
    'HP',
    'LG',
    'Canon',
    'Panasonic',
    'Nike',
    'Adidas',
    'Gucci',
    'Zara',
    'H&M',
    'Levi\'s',
    'Tommy Hilfiger',
    'Ralph Lauren',
    'Calvin Klein',
    'Versace',
    'Bose',
    'Fitbit',
    'Louis Vuitton',
    'Coach',
    'Michael Kors',
    'Kate Spade',
    'Fossil',
    'Herschel',
    'Timbuk2',
    'Samsonite',
    'Tumi',
    'JanSport',
    'MAC Cosmetics',
    'Sephora',
    'NARS',
    'Maybelline',
    'Urban Decay',
    'Estée Lauder',
    'Too Faced',
    'Clinique',
    'Anastasia',
    'Fenty Beauty',
    'Chanel',
    'Prada',
    'Dior',
    'Balenciaga',
    'Alexander',
    'Valentino',
    'Gucci',
    'Burberry',
    'Fendi',
    'Yves Saint',
    'Other',
  ];
  static const List<String> colorList = [
    'Red',
    'Blue',
    'Green',
    'Yellow',
    'Orange',
    'Purple',
    'Pink',
    'Brown',
    'Black',
    'White',
    'Gray',
    'Sky Blue',
    'Beige',
    'Turquoise',
    'Lime',
    'Cyan',
    'Magenta',
    'Indigo',
    'Teal',
    'Lavender',
    'Maroon',
    'Olive',
    'Navy',
    'Silver',
    'Gold',
    'Other',
  ];
  static const String welcomeText =
      'Welcome to Finder App, your trusted companion in locating lost items.';
  static const String registerText =
      'Enter essential details below to register and amplify your presence on Finder.';

  ///  firebase collection
  static const String userDataCollection = 'user_data';
  static const String itemCollection = 'item';

  ///  data const
  static const String name = 'name';
  static const String category = 'category';
  static const String email = 'email';
  static const String password = 'password';
  static const String phoneNumber = 'phone_number';
  static const String country = 'country';
  static const String city = 'city';
  static const String address = 'address';
  static const String roleModel = 'role_model';
  static const String crNumber = 'cr_number';
  static const String image = 'image';
  static const String itemID = 'item_id';
  static const String series = 'series';
  static const String brand = 'brand';
  static const String quantity = 'quantity';
  static const String color = 'color';
  static const String date = 'date';
  static const String time = 'time';
  static const String description = 'description';
  static const String companyName = 'company_name';
  static const String companyAddress = 'company_address';
  static const String companyCategory = 'company_category';
  static const String companyCity = 'company_city';
  static const String companyCountry = 'company_country';
  static const String companyPhoneNumber = 'company_phone_number';



  /// filter check ////

  static const String checkItemCat = 'check_item_cat';
  static const String checkItemSubCat = 'check_item_sub_cat';
  static const String checkDate =  'date';
  static const String checkBrand =  'brand';
  static const String checkSeries =  'series';
  static const String checkColor =  'color';
  static const String checkCountry =  'country';
  static const String checkCity =  'city';
  static const String checkComCat =  'com_cat';
  static const String checkComName =  'com_name';

}
