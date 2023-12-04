import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/constants/constants.dart';
import 'package:finder_app/db_servies/cloud_services.dart';
import 'package:finder_app/providers/item_filter_provider.dart';
import 'package:finder_app/screens/guest_screens.dart/filter_screen.dart';
import 'package:finder_app/utils/app_routs.dart';
import 'package:finder_app/utils/app_utils.dart';
import 'package:finder_app/widgets/custom_filter_chip_container.dart';
import 'package:finder_app/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../providers/check_list_filter_provider.dart';
import 'item_details_screen.dart';

class GuestHomeScreen extends StatefulWidget {
  const GuestHomeScreen({super.key});

  @override
  State<GuestHomeScreen> createState() => GuestHomeScreenState();
}

class GuestHomeScreenState extends State<GuestHomeScreen> {
  TextEditingController searchController = TextEditingController();
  ValueNotifier<String> categoryNotifierFilter = ValueNotifier('');
  ValueNotifier<String> searchValueNotifier = ValueNotifier('');
  late ItemFilterProvider itemFilterProvider;
  bool isCatInit = false;

  final categoryImages = [
    AppImages.electronic,
    AppImages.accessories,
    AppImages.bag,
    AppImages.sports,
    AppImages.keyIcon,
    AppImages.toy,
    AppImages.books,
    AppImages.clothes,
    AppImages.medicine,
  ];
  final categoryList = [
    'Electronic',
    'Accessories',
    'Bag',
    'Sport',
    'key',
    'Toy',
    'Book',
    'Cloth',
    'Medicine',
  ];

  @override
  void initState() {
    super.initState();
    itemFilterProvider =
        Provider.of<ItemFilterProvider>(context, listen: false);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.all(7),
          child: Icon(
            Icons.person,
            color: AppColors.grey,
          ),
        ),
        leadingWidth: 30,
        title: Row(
          children: [
            CustomText(
              text: 'Hi,',
              letterSpacing: 1,
              color: AppColors.blue,
              size: 16,
              weight: FontWeight.w500,
            ),
            SizedBox(
              width: 10,
            ),
            FutureBuilder(
              future: CloudServices.fetchUserData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CustomText(
                    text: snapshot.data![AppText.name],
                    letterSpacing: 1,
                    color: AppColors.black,
                    size: 16,
                    weight: FontWeight.w400,
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.guestSettingScreen);
            },
            child: Icon(
              Icons.settings,
              color: AppColors.grey,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 5),
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Find your items here',
                          color: AppColors.black,
                          letterSpacing: 1,
                          size: 22,
                          weight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text:
                          'We would like to inform you about\nsome lost items that have been \nfound. You can check them out below.',
                          color: AppColors.black,
                          size: 12,
                          weight: FontWeight.w300,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(AppImages.companylogo),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 5),
              child: CustomSearchField(
                filterIcon: InkWell(
                    onTap: () {
                      Provider.of<CheckListFilterProvider>(context,
                          listen: false)
                          .clear();
                      itemFilterProvider.clear();
                      isCatInit = false;
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: FilterItemScreen()),
                      );
                    },
                    child: Icon(Icons.filter_alt, color: AppColors.grey)),
                controller: searchController,
                hintText: 'Search',
                onChanged: (query) {
                  searchValueNotifier.value = query;
                },
              ),
            ),
            Consumer<ItemFilterProvider>(
              builder: (context, filter, child) {
                if (filter.filterData.isNotEmpty) {
                  if (!isCatInit) {
                    Future.delayed(Duration.zero).then((value) {
                      categoryNotifierFilter.value = filter.filterData[0]
                      [AppText.checkFilterItemCat]
                          .toString();
                      isCatInit = true;
                    });
                  }

                  return FilterChips(
                    filter: filter,
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Categories',
                    letterSpacing: 1,
                    size: 20,
                    weight: FontWeight.w600,
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<CheckListFilterProvider>(context,
                          listen: false)
                          .clear();
                      itemFilterProvider.clear();
                      isCatInit = false;
                      categoryNotifierFilter.value = '';
                    },
                    child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.blue,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.filter,
                            size: 14,
                            color: Colors.white,
                          ),
                          CustomText(
                            text: 'Show All',
                            size: 14,
                            weight: FontWeight.w500,
                            letterSpacing: 0.50,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 8, bottom: 8, left: 4),
                    child: GestureDetector(
                      onTap: () {
                        categoryNotifierFilter.value =
                            categoryList[index].toString();
                      },
                      child: ValueListenableBuilder(
                        valueListenable: categoryNotifierFilter,
                        builder: (context, notifyValue, child) =>
                            CustomViewContainer(
                              borderColor: notifyValue != categoryList[index]
                                  ? Colors.white
                                  : AppColors.green,
                              labelText: categoryList[index],
                              imagePath: categoryImages[index],
                            ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: CustomText(
                text: 'Recent Posts',
                color: AppColors.black,
                letterSpacing: 1,
                size: 20,
                weight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ValueListenableBuilder(
              valueListenable: searchValueNotifier,
              builder: (context, searchNotify, child) =>
                  Consumer<ItemFilterProvider>(
                    builder: (context, filterProvider, child) =>
                        ValueListenableBuilder(
                          valueListenable: categoryNotifierFilter,
                          builder: (context, catNotifier, child) =>
                              StreamBuilder(
                                stream: filterProvider.filterData.isEmpty
                                    ? catNotifier == ''
                                    ? CloudServices.getItemCollection()
                                    .snapshots()
                                    : CloudServices.getItemCollection()
                                    .where(AppText.category,
                                    isEqualTo: catNotifier)
                                    .snapshots()
                                    : CloudServices.getItemCollection()
                                    .where(AppText.category,
                                    isEqualTo: catNotifier == ''
                                        ? null
                                        : catNotifier)
                                    .where(AppText.name,
                                    isEqualTo: filterProvider.filterData[1]
                                    [AppText.checkFilterItemSubCat]
                                        .toString()
                                        .isEmpty
                                        ? null
                                        : filterProvider.filterData[1]
                                    [AppText.checkFilterItemSubCat])
                                    .where(AppText.companyCategory,
                                    isEqualTo: filterProvider
                                        .filterData[2][AppText
                                        .checkFilterComCat].toString() == ''
                                        ? null
                                        : filterProvider.filterData[2]
                                    [AppText.checkFilterComCat])
                                    .where(AppText.companyName,
                                    isEqualTo: filterProvider
                                        .filterData[3][AppText
                                        .checkFilterComName].toString() == ''
                                        ? null
                                        : filterProvider.filterData[3]
                                    [AppText.checkFilterComName])
                                    .where(AppText.brand,
                                    isEqualTo: filterProvider
                                        .filterData[4][AppText
                                        .checkFilterBrand].toString() == ''
                                        ? null
                                        : filterProvider.filterData[4]
                                    [AppText.checkFilterBrand])

                                    .where(
                                    AppText.series, isEqualTo: filterProvider
                                    .filterData[5][AppText.checkFilterSeries]
                                    .toString() == '' ? null : filterProvider
                                    .filterData[5][AppText.checkFilterSeries])

                                    .where(
                                    AppText.date, isEqualTo: filterProvider
                                    .filterData[6][AppText
                                    .checkFilterDate].toString() == ''
                                    ? null
                                    : DateTime.parse(
                                    filterProvider.filterData[6][AppText
                                        .checkFilterDate]))

                                    .where(
                                    AppText.color, isEqualTo: filterProvider
                                    .filterData[7]
                                [AppText.checkFilterColor].toString() == ''
                                    ? null
                                    : filterProvider.filterData[7]
                                [AppText.checkFilterColor])

                                    .where(
                                    AppText.country, isEqualTo: filterProvider
                                    .filterData[8]
                                [AppText.checkFilterCountry].toString() == ''
                                    ? null
                                    : filterProvider.filterData[8]
                                [AppText.checkFilterCountry])
                                    .where(AppText.city,
                                    isEqualTo: filterProvider
                                        .filterData[9]
                                    [AppText.checkFilterCity].toString() == ''
                                        ? null
                                        : filterProvider.filterData[9]
                                    [AppText.checkFilterCity])
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    var data = searchNotify.isEmpty
                                        ? snapshot.data!.docs
                                        : snapshot.data!.docs
                                        .where((item) =>
                                        item[AppText.name]
                                            .toLowerCase()
                                            .contains(
                                            searchNotify
                                                .toLowerCase()))
                                        .toList();
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: PostContainer(
                                            imagePath: data[index][AppText
                                                .image],
                                            containerText: data[index][AppText
                                                .name],
                                            timeText: data[index][AppText.time],
                                            locationText: data[index][AppText
                                                .companyCountry],
                                            dateText: AppUtils
                                                .formatDateWithoutTime(
                                                (data[index][AppText
                                                    .date] as Timestamp)
                                                    .toDate()),
                                            descriptionText: data[index][AppText
                                                .description],
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                  child: GuestItemDetailsPage(
                                                    data: data[index],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    return const CupertinoActivityIndicator();
                                  }
                                },
                              ),
                        ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterChips extends StatelessWidget {
  final ItemFilterProvider filter;

  const FilterChips({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Wrap(
        children: [
          if (filter.filterData[0][AppText.checkFilterItemCat] != '' &&
              filter.filterData[0][AppText.checkFilterItemCat]
                  .toString()
                  .isNotEmpty)
            CustomFilterChipContainer(
                filterKey: AppText.checkFilterItemCat,
                filterProvider: filter,
                index: 0,
                filter: filter.filterData[0][AppText.checkFilterItemCat],
                filterTitle: 'Item Category'),
          if (filter.filterData[1][AppText.checkFilterItemSubCat] != '' &&
              filter.filterData[1][AppText.checkFilterItemSubCat]
                  .toString()
                  .isNotEmpty)
            CustomFilterChipContainer(
                filterKey: AppText.checkFilterItemSubCat,
                filterProvider: filter,
                index: 1,
                filter: filter.filterData[1][AppText.checkFilterItemSubCat],
                filterTitle: 'Item Sub Category'),
          if (filter.filterData[2][AppText.checkFilterComCat] != '' &&
              filter.filterData[2][AppText.checkFilterComCat]
                  .toString()
                  .isNotEmpty)
            CustomFilterChipContainer(
                filterKey: AppText.checkFilterComCat,
                filterProvider: filter,
                index: 2,
                filter: filter.filterData[2][AppText.checkFilterComCat],
                filterTitle: 'Company Category'),
          if (filter.filterData[3][AppText.checkFilterComName] != '' &&
              filter.filterData[3][AppText.checkFilterComName]
                  .toString()
                  .isNotEmpty)
            CustomFilterChipContainer(
                filterKey: AppText.checkFilterComName,
                filterProvider: filter,
                index: 3,
                filter: filter.filterData[3][AppText.checkFilterComName],
                filterTitle: 'Company Name'),
          if (filter.filterData[4][AppText.checkFilterBrand] != '' &&
              filter.filterData[4][AppText.checkFilterBrand]
                  .toString()
                  .isNotEmpty)
            CustomFilterChipContainer(
                filterKey: AppText.checkFilterBrand,
                filterProvider: filter,
                index: 4,
                filter: filter.filterData[4][AppText.checkFilterBrand],
                filterTitle: 'Brand'),
          if (filter.filterData[5][AppText.checkFilterSeries] != '' &&
              filter.filterData[5][AppText.checkFilterSeries]
                  .toString()
                  .isNotEmpty)
            CustomFilterChipContainer(
                filterKey: AppText.checkFilterSeries,
                filterProvider: filter,
                index: 5,
                filter: filter.filterData[5][AppText.checkFilterSeries],
                filterTitle: 'Series'),
          if (filter.filterData[6][AppText.checkFilterDate] != '' &&
              filter.filterData[6][AppText.checkFilterDate]
                  .toString()
                  .isNotEmpty)
            CustomFilterChipContainer(
                filterKey: AppText.checkFilterDate,
                filterProvider: filter,
                index: 6,
                filter: filter.filterData[6][AppText.checkFilterDate]
                    .toString()
                    .substring(0, 10),
                filterTitle: 'Date'),
          if (filter.filterData[7][AppText.checkFilterColor] != '' &&
              filter.filterData[7][AppText.checkFilterColor]
                  .toString()
                  .isNotEmpty)
            CustomFilterChipContainer(
                filterKey: AppText.checkFilterColor,
                filterProvider: filter,
                index: 7,
                filter: filter.filterData[7][AppText.checkFilterColor],
                filterTitle: 'Color'),
          if (filter.filterData[8][AppText.checkFilterCountry] != '' &&
              filter.filterData[8][AppText.checkFilterCountry]
                  .toString()
                  .isNotEmpty)
            CustomFilterChipContainer(
                filterKey: AppText.checkFilterCountry,
                filterProvider: filter,
                index: 8,
                filter: filter.filterData[8][AppText.checkFilterCountry],
                filterTitle: 'Country'),
          if (filter.filterData[9][AppText.checkFilterCity] != '' &&
              filter.filterData[9][AppText.checkFilterCity]
                  .toString()
                  .isNotEmpty)
            CustomFilterChipContainer(
                filterKey: AppText.checkFilterCity,
                filterProvider: filter,
                index: 9,
                filter: filter.filterData[9][AppText.checkFilterCity],
                filterTitle: 'City'),
        ],
      ),
    );
  }
}
