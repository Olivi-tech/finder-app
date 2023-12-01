import 'package:country_picker/country_picker.dart';
import 'package:finder_app/providers/check_list_filter_provider.dart';
import 'package:finder_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../widgets/widgets.dart';

class FilterItemScreen extends StatefulWidget {
  const FilterItemScreen({super.key});

  @override
  State<FilterItemScreen> createState() => _FilterItemScreenState();
}

class _FilterItemScreenState extends State<FilterItemScreen> {
  TextEditingController itemCategoryController = TextEditingController();
  TextEditingController companyCategoryController = TextEditingController();
  TextEditingController itemSubCategoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController seriesController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  ValueNotifier<String> DateNotifier = ValueNotifier('');
  late CheckListFilterProvider checkListFilterProvider;

  @override
  void initState() {
    super.initState();
    checkListFilterProvider =
        Provider.of<CheckListFilterProvider>(context, listen: false);
  }

  @override
  void dispose() {
    itemCategoryController.dispose();
    brandController.dispose();
    itemSubCategoryController.dispose();
    seriesController.dispose();
    colorController.dispose();
    cityController.dispose();
    countryController.dispose();
    companyCategoryController.dispose();
    companyNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
        title: const CustomText(
          text: 'Filter Items',
          letterSpacing: 1,
          color: AppColors.black,
          size: 18,
          weight: FontWeight.w500,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Consumer<CheckListFilterProvider>(
              builder: (context, checkListFilter, child) => Column(
                children: [
                  _CustomCheckBox(
                      checkValue: checkListFilter.getCheckListFilter
                              .contains(AppText.checkItemCat)
                          ? true
                          : false,
                      onTap: (value) {
                        if (checkListFilter.getCheckListFilter
                            .contains(AppText.checkItemCat)) {
                          itemCategoryController.clear();
                          checkListFilterProvider.removeCheckListFilter =
                              AppText.checkItemCat;
                        } else {
                          checkListFilterProvider.setCheckListFilter =
                              AppText.checkItemCat;
                        }
                      },
                      title: 'Item Category'),
                  _CustomCheckBox(
                      checkValue: checkListFilter.getCheckListFilter
                              .contains(AppText.checkItemSubCat)
                          ? true
                          : false,
                      onTap: (value) {
                        if (checkListFilter.getCheckListFilter
                            .contains(AppText.checkItemSubCat)) {
                          itemSubCategoryController.clear();
                          checkListFilterProvider.removeCheckListFilter =
                              AppText.checkItemSubCat;
                        } else {
                          checkListFilterProvider.setCheckListFilter =
                              AppText.checkItemSubCat;
                        }
                      },
                      title: 'Item Sub Category'),
                  _CustomCheckBox(
                      checkValue: checkListFilter.getCheckListFilter
                              .contains(AppText.checkComCat)
                          ? true
                          : false,
                      onTap: (value) {
                        if (checkListFilter.getCheckListFilter
                            .contains(AppText.checkComCat)) {
                          companyCategoryController.clear();
                          checkListFilterProvider.removeCheckListFilter =
                              AppText.checkComCat;
                        } else {
                          checkListFilterProvider.setCheckListFilter =
                              AppText.checkComCat;
                        }
                      },
                      title: 'Company Category'),
                  _CustomCheckBox(
                      checkValue: checkListFilter.getCheckListFilter
                              .contains(AppText.checkComName)
                          ? true
                          : false,
                      onTap: (value) {
                        if (checkListFilter.getCheckListFilter
                            .contains(AppText.checkComName)) {
                          companyNameController.clear();
                          checkListFilterProvider.removeCheckListFilter =
                              AppText.checkComName;
                        } else {
                          checkListFilterProvider.setCheckListFilter =
                              AppText.checkComName;
                        }
                      },
                      title: 'Company Name'),
                  Row(
                    children: [
                      Expanded(
                        child: _CustomCheckBox(
                            checkValue: checkListFilter.getCheckListFilter
                                    .contains(AppText.checkBrand)
                                ? true
                                : false,
                            onTap: (value) {
                              if (checkListFilter.getCheckListFilter
                                  .contains(AppText.checkBrand)) {
                                brandController.clear();
                                checkListFilterProvider.removeCheckListFilter =
                                    AppText.checkBrand;
                              } else {
                                checkListFilterProvider.setCheckListFilter =
                                    AppText.checkBrand;
                              }
                            },
                            title: 'Brand'),
                      ),
                      Expanded(
                        child: _CustomCheckBox(
                            checkValue: checkListFilter.getCheckListFilter
                                    .contains(AppText.checkSeries)
                                ? true
                                : false,
                            onTap: (value) {
                              if (checkListFilter.getCheckListFilter
                                  .contains(AppText.checkSeries)) {
                                seriesController.clear();
                                checkListFilterProvider.removeCheckListFilter =
                                    AppText.checkSeries;
                              } else {
                                checkListFilterProvider.setCheckListFilter =
                                    AppText.checkSeries;
                              }
                            },
                            title: 'Series'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _CustomCheckBox(
                            checkValue: checkListFilter.getCheckListFilter
                                    .contains(AppText.checkDate)
                                ? true
                                : false,
                            onTap: (value) {
                              if (checkListFilter.getCheckListFilter
                                  .contains(AppText.checkDate)) {
                                checkListFilterProvider.removeCheckListFilter =
                                    AppText.checkDate;
                              } else {
                                checkListFilterProvider.setCheckListFilter =
                                    AppText.checkDate;
                              }
                            },
                            title: 'Date'),
                      ),
                      Expanded(
                        child: _CustomCheckBox(
                            checkValue: checkListFilter.getCheckListFilter
                                    .contains(AppText.checkColor)
                                ? true
                                : false,
                            onTap: (value) {
                              if (checkListFilter.getCheckListFilter
                                  .contains(AppText.checkColor)) {
                                colorController.clear();
                                checkListFilterProvider.removeCheckListFilter =
                                    AppText.checkColor;
                              } else {
                                checkListFilterProvider.setCheckListFilter =
                                    AppText.checkColor;
                              }
                            },
                            title: 'Color'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _CustomCheckBox(
                            checkValue: checkListFilter.getCheckListFilter
                                    .contains(AppText.checkCountry)
                                ? true
                                : false,
                            onTap: (value) {
                              if (checkListFilter.getCheckListFilter
                                  .contains(AppText.checkCountry)) {
                                countryController.clear();
                                checkListFilterProvider.removeCheckListFilter =
                                    AppText.checkCountry;
                              } else {
                                checkListFilterProvider.setCheckListFilter =
                                    AppText.checkCountry;
                              }
                            },
                            title: 'Country'),
                      ),
                      Expanded(
                        child: _CustomCheckBox(
                            checkValue: checkListFilter.getCheckListFilter
                                    .contains(AppText.checkCity)
                                ? true
                                : false,
                            onTap: (value) {
                              if (checkListFilter.getCheckListFilter
                                  .contains(AppText.checkCity)) {
                                cityController.clear();
                                checkListFilterProvider.removeCheckListFilter =
                                    AppText.checkCity;
                              } else {
                                checkListFilterProvider.setCheckListFilter =
                                    AppText.checkCity;
                              }
                            },
                            title: 'City'),
                      ),
                    ],
                  ),
                  if (checkListFilter.getCheckListFilter
                      .contains(AppText.checkItemCat))
                    CustomTextField(
                      readOnly: true,
                      hintText: 'Item category',
                      obscureText: false,
                      controller: itemCategoryController,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Please enter Category';
                        }
                        return null;
                      },
                      suffixIcon: DropDownsWidget(
                        itemList: AppText.categoryList,
                        controller: itemCategoryController,
                        onChanged: (String? selectedOption) {
                          itemCategoryController.text = selectedOption ?? '';
                        },
                      ),
                    ),
                  if (checkListFilter.getCheckListFilter
                      .contains(AppText.checkItemSubCat))
                    CustomTextField(
                      hintText: 'Item Sub Category',
                      obscureText: false,
                      controller: itemSubCategoryController,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                    ),
                  if (checkListFilter.getCheckListFilter
                      .contains(AppText.checkBrand))
                    CustomTextField(
                      readOnly: true,
                      hintText: 'Item brand',
                      obscureText: false,
                      controller: brandController,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Please enter Brand name';
                        }
                        return null;
                      },
                      suffixIcon: DropDownsWidget(
                        itemList: AppText.brandList,
                        controller: brandController,
                        onChanged: (String? selectedOption) {
                          brandController.text = selectedOption ?? '';
                        },
                      ),
                    ),
                  if (checkListFilter.getCheckListFilter
                      .contains(AppText.checkSeries))
                    CustomTextField(
                      hintText: 'Series',
                      obscureText: false,
                      controller: seriesController,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Please enter series';
                        }
                        return null;
                      },
                    ),
                  if (checkListFilter.getCheckListFilter
                      .contains(AppText.checkDate))
                    InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ValueListenableBuilder(
                          valueListenable: DateNotifier,
                          builder: (context, date, child) => Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 0.2,
                                color: AppColors.black,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CustomText(
                                    text: 'Date : ',
                                    size: 18,
                                  ),
                                  const Spacer(),
                                  Text(
                                    date != ''
                                        ? (DateFormat('dd-MM-yyyy')
                                            .format((DateTime.parse(date))))
                                        : (DateFormat('dd-MM-yyyy')
                                            .format((DateTime.now()))),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (checkListFilter.getCheckListFilter
                      .contains(AppText.checkColor))
                    CustomTextField(
                      readOnly: true,
                      hintText: 'Black',
                      obscureText: false,
                      controller: colorController,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Please enter color';
                        }
                        return null;
                      },
                      suffixIcon: DropDownsWidget(
                        itemList: AppText.colorList,
                        controller: colorController,
                        onChanged: (String? selectedOption) {
                          colorController.text = selectedOption ?? '';
                        },
                      ),
                    ),
                  if (checkListFilter.getCheckListFilter
                      .contains(AppText.checkCountry))
                    CustomTextField(
                      readOnly: true,
                      hintText: 'Country',
                      obscureText: false,
                      controller: countryController,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Please enter color';
                        }
                        return null;
                      },
                      suffixIcon: InkWell(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            showPhoneCode: false,
                            // optional. Shows phone code before the country name.
                            onSelect: (Country country) {
                              countryController.text = country.name.toString();
                            },
                          );
                        },
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 16,
                        ),
                      ),
                    ),
                  if (checkListFilter.getCheckListFilter
                      .contains(AppText.checkCity))
                    CustomTextField(
                      obscureText: false,
                      hintText: 'City',
                      controller: cityController,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Please enter City';
                        } else if (!isValidName(input)) {
                          return 'Invalid city';
                        }
                        return null;
                      },
                    ),
                  if (checkListFilter.getCheckListFilter
                      .contains(AppText.checkComCat))
                    CustomTextField(
                      hintText: 'Company Category',
                      readOnly: true,
                      obscureText: false,
                      controller: companyCategoryController,
                      suffixIcon: DropDownsWidget(
                        itemList: ['Mall', 'Park'],
                        controller: companyCategoryController,
                        onChanged: (String? selectedOption) {
                          companyCategoryController.text = selectedOption ?? '';
                        },
                      ),
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Please enter Category';
                        }
                        return null;
                      },
                    ),
                  if (checkListFilter.getCheckListFilter
                      .contains(AppText.checkComName))
                    CustomTextField(
                      obscureText: false,
                      hintText: 'Company Name',
                      controller: companyNameController,
                      keyboardType: TextInputType.name,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Please enter Company Name';
                        } else if (!isValidName(input)) {
                          return 'Invalid Name';
                        }
                        return null;
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _CustomCheckBox(
      {required bool checkValue,
      required CheckBoxCallBack onTap,
      required String title}) {
    return CheckboxListTile(
      value: checkValue,
      onChanged: onTap,
      title: Text(title),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.green,
            ),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    ))!;

    DateNotifier.value = picked.toString();
  }
}
