import 'package:country_picker/country_picker.dart';
import 'package:finder_app/providers/check_list_filter_provider.dart';
import 'package:finder_app/providers/item_filter_provider.dart';
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
  ValueNotifier<String> dateNotifier = ValueNotifier('');
  late CheckListFilterProvider checkListFilterProvider;
  late ItemFilterProvider itemFilterProvider;

  @override
  void initState() {
    super.initState();
    checkListFilterProvider =
        Provider.of<CheckListFilterProvider>(context, listen: false);
    itemFilterProvider =
        Provider.of<ItemFilterProvider>(context, listen: false);
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
                              .contains(AppText.checkFilterItemCat)
                          ? true
                          : false,
                      onTap: (value) {
                        if (checkListFilter.getCheckListFilter
                            .contains(AppText.checkFilterItemCat)) {
                          itemCategoryController.clear();
                          checkListFilterProvider.removeCheckListFilter =
                              AppText.checkFilterItemCat;
                        } else {
                          checkListFilterProvider.setCheckListFilter =
                              AppText.checkFilterItemCat;
                        }
                      },
                      title: 'Item Category'),
                  _CustomCheckBox(
                      checkValue: checkListFilter.getCheckListFilter
                              .contains(AppText.checkFilterItemSubCat)
                          ? true
                          : false,
                      onTap: (value) {
                        if (checkListFilter.getCheckListFilter
                            .contains(AppText.checkFilterItemSubCat)) {
                          itemSubCategoryController.clear();
                          checkListFilterProvider.removeCheckListFilter =
                              AppText.checkFilterItemSubCat;
                        } else {
                          checkListFilterProvider.setCheckListFilter =
                              AppText.checkFilterItemSubCat;
                        }
                      },
                      title: 'Item Sub Category'),
                  _CustomCheckBox(
                      checkValue: checkListFilter.getCheckListFilter
                              .contains(AppText.checkFilterComCat)
                          ? true
                          : false,
                      onTap: (value) {
                        if (checkListFilter.getCheckListFilter
                            .contains(AppText.checkFilterComCat)) {
                          companyCategoryController.clear();
                          checkListFilterProvider.removeCheckListFilter =
                              AppText.checkFilterComCat;
                        } else {
                          checkListFilterProvider.setCheckListFilter =
                              AppText.checkFilterComCat;
                        }
                      },
                      title: 'Company Category'),
                  _CustomCheckBox(
                      checkValue: checkListFilter.getCheckListFilter
                              .contains(AppText.checkFilterComName)
                          ? true
                          : false,
                      onTap: (value) {
                        if (checkListFilter.getCheckListFilter
                            .contains(AppText.checkFilterComName)) {
                          companyNameController.clear();
                          checkListFilterProvider.removeCheckListFilter =
                              AppText.checkFilterComName;
                        } else {
                          checkListFilterProvider.setCheckListFilter =
                              AppText.checkFilterComName;
                        }
                      },
                      title: 'Company Name'),
                  Row(
                    children: [
                      Expanded(
                        child: _CustomCheckBox(
                            checkValue: checkListFilter.getCheckListFilter
                                    .contains(AppText.checkFilterBrand)
                                ? true
                                : false,
                            onTap: (value) {
                              if (checkListFilter.getCheckListFilter
                                  .contains(AppText.checkFilterBrand)) {
                                brandController.clear();
                                checkListFilterProvider.removeCheckListFilter =
                                    AppText.checkFilterBrand;
                              } else {
                                checkListFilterProvider.setCheckListFilter =
                                    AppText.checkFilterBrand;
                              }
                            },
                            title: 'Brand'),
                      ),
                      Expanded(
                        child: _CustomCheckBox(
                            checkValue: checkListFilter.getCheckListFilter
                                    .contains(AppText.checkFilterSeries)
                                ? true
                                : false,
                            onTap: (value) {
                              if (checkListFilter.getCheckListFilter
                                  .contains(AppText.checkFilterSeries)) {
                                seriesController.clear();
                                checkListFilterProvider.removeCheckListFilter =
                                    AppText.checkFilterSeries;
                              } else {
                                checkListFilterProvider.setCheckListFilter =
                                    AppText.checkFilterSeries;
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
                                    .contains(AppText.checkFilterDate)
                                ? true
                                : false,
                            onTap: (value) {
                              dateNotifier.value = DateTime.now().toString();
                              if (checkListFilter.getCheckListFilter
                                  .contains(AppText.checkFilterDate)) {
                                checkListFilterProvider.removeCheckListFilter =
                                    AppText.checkFilterDate;
                              } else {
                                checkListFilterProvider.setCheckListFilter =
                                    AppText.checkFilterDate;
                              }
                            },
                            title: 'Date'),
                      ),
                      Expanded(
                        child: _CustomCheckBox(
                            checkValue: checkListFilter.getCheckListFilter
                                    .contains(AppText.checkFilterColor)
                                ? true
                                : false,
                            onTap: (value) {
                              if (checkListFilter.getCheckListFilter
                                  .contains(AppText.checkFilterColor)) {
                                colorController.clear();
                                checkListFilterProvider.removeCheckListFilter =
                                    AppText.checkFilterColor;
                              } else {
                                checkListFilterProvider.setCheckListFilter =
                                    AppText.checkFilterColor;
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
                                    .contains(AppText.checkFilterCountry)
                                ? true
                                : false,
                            onTap: (value) {
                              if (checkListFilter.getCheckListFilter
                                  .contains(AppText.checkFilterCountry)) {
                                countryController.clear();
                                checkListFilterProvider.removeCheckListFilter =
                                    AppText.checkFilterCountry;
                              } else {
                                checkListFilterProvider.setCheckListFilter =
                                    AppText.checkFilterCountry;
                              }
                            },
                            title: 'Country'),
                      ),
                      Expanded(
                        child: _CustomCheckBox(
                            checkValue: checkListFilter.getCheckListFilter
                                    .contains(AppText.checkFilterCity)
                                ? true
                                : false,
                            onTap: (value) {
                              if (checkListFilter.getCheckListFilter
                                  .contains(AppText.checkFilterCity)) {
                                cityController.clear();
                                checkListFilterProvider.removeCheckListFilter =
                                    AppText.checkFilterCity;
                              } else {
                                checkListFilterProvider.setCheckListFilter =
                                    AppText.checkFilterCity;
                              }
                            },
                            title: 'City'),
                      ),
                    ],
                  ),
                  if (checkListFilter.getCheckListFilter
                      .contains(AppText.checkFilterItemCat))
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
                      .contains(AppText.checkFilterItemSubCat))
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
                      .contains(AppText.checkFilterBrand))
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
                      .contains(AppText.checkFilterSeries))
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
                      .contains(AppText.checkFilterDate))
                    InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ValueListenableBuilder(
                          valueListenable: dateNotifier,
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
                      .contains(AppText.checkFilterColor))
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
                      .contains(AppText.checkFilterCountry))
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
                      .contains(AppText.checkFilterCity))
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
                      .contains(AppText.checkFilterComCat))
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
                      .contains(AppText.checkFilterComName))
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
                  if (checkListFilter.getCheckListFilter.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: InkWell(
                        onTap: () {
                          List<Map<String, dynamic>> filterData = [
                            {
                              AppText.checkFilterItemCat: checkListFilter
                                      .getCheckListFilter
                                      .contains(AppText.checkFilterItemCat)
                                  ? itemCategoryController.text
                                  : ''
                            },
                            {
                              AppText.checkFilterItemSubCat: checkListFilter
                                      .getCheckListFilter
                                      .contains(AppText.checkFilterItemSubCat)
                                  ? itemSubCategoryController.text
                                  : ''
                            },
                            {
                              AppText.checkFilterComCat: checkListFilter
                                      .getCheckListFilter
                                      .contains(AppText.checkFilterComCat)
                                  ? companyCategoryController.text
                                  : ''
                            },
                            {
                              AppText.checkFilterComName: checkListFilter
                                      .getCheckListFilter
                                      .contains(AppText.checkFilterComName)
                                  ? companyNameController.text
                                  : ''
                            },
                            {
                              AppText.checkFilterBrand: checkListFilter
                                      .getCheckListFilter
                                      .contains(AppText.checkFilterBrand)
                                  ? brandController.text
                                  : ''
                            },
                            {
                              AppText.checkFilterSeries: checkListFilter
                                      .getCheckListFilter
                                      .contains(AppText.checkFilterSeries)
                                  ? seriesController.text
                                  : ''
                            },
                            {
                              AppText.checkFilterDate: checkListFilter
                                      .getCheckListFilter
                                      .contains(AppText.checkFilterDate)
                                  ? dateNotifier.value.toString()
                                  : ''
                            },
                            {
                              AppText.checkFilterColor: checkListFilter
                                      .getCheckListFilter
                                      .contains(AppText.checkFilterColor)
                                  ? colorController.text
                                  : ''
                            },
                            {
                              AppText.checkFilterCountry: checkListFilter
                                      .getCheckListFilter
                                      .contains(AppText.checkFilterCountry)
                                  ? countryController.text
                                  : ''
                            },
                            {
                              AppText.checkFilterCity: checkListFilter
                                      .getCheckListFilter
                                      .contains(AppText.checkFilterCity)
                                  ? cityController.text
                                  : ''
                            },
                          ];

                          itemFilterProvider.setFilterData = filterData;

                          print(filterData.toString());
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 45,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.blue,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(
                                Icons.done_all,
                                size: 14,
                                color: Colors.white,
                              ),
                              CustomText(
                                text: 'Apply Filter',
                                size: 14,
                                weight: FontWeight.w500,
                                letterSpacing: 0.50,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
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

    dateNotifier.value = picked.toString();
  }
}
