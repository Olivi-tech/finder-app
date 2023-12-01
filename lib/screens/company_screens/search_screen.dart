import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/constants/constants.dart';
import 'package:finder_app/db_servies/cloud_services.dart';
import 'package:finder_app/screens/company_screens/item_details_screen.dart';
import 'package:finder_app/utils/app_utils.dart';
import 'package:finder_app/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SearchPostScreen extends StatefulWidget {
  const SearchPostScreen({super.key});

  @override
  State<SearchPostScreen> createState() => _SearchPostScreenState();
}

class _SearchPostScreenState extends State<SearchPostScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CloudServices.fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var companyData = snapshot.data!;
          return Scaffold(
            appBar: AppBarCustom(
              backgroundColor: AppColors.green,
              location: companyData[AppText.address],
              name: companyData[AppText.name],
              imagepath: AppImages.companylogo,
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 14, top: 10, bottom: 10),
                    child: CustomText(
                      text: 'Search Posts',
                      color: AppColors.black,
                      letterSpacing: 1,
                      size: 16,
                      weight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 14, top: 10, bottom: 20, right: 14),
                    child: CustomSearchField(
                      controller: searchController,
                      hintText: 'Search',
                      onChanged: (query) {
                        // _filterItems(query);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14, bottom: 10),
                    child: CustomText(
                      text: 'Recent Posts',
                      color: AppColors.black,
                      letterSpacing: 1,
                      size: 16,
                      weight: FontWeight.w500,
                    ),
                  ),
                  StreamBuilder(
                    stream: CloudServices.getItemCollection().snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data!.docs;
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: GestureDetector(
                                onLongPress: () {
                                  _showDeleteDialog(docID: data[index].id);
                                },
                                child: ImageContainer(
                                  imagePath: data[index][AppText.image],
                                  containerText: data[index][AppText.name],
                                  locationText: companyData[AppText.country],
                                  timeText: data[index][AppText.time],
                                  dateText: AppUtils.formatDateWithoutTime(
                                      (data[index][AppText.date] as Timestamp)
                                          .toDate()),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: ItemDetailsPage(
                                          data: data[index],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const CupertinoActivityIndicator();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }

  _showDeleteDialog({required String docID}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              CustomText(
                letterSpacing: 1,
                weight: FontWeight.w600,
                color: AppColors.red,
                text: 'Delete',
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.warning_amber,
                color: AppColors.red,
                size: 24,
              ),
            ],
          ),
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: CustomText(
                letterSpacing: 1,
                text: 'Cancel',
                color: AppColors.black,
              ),
            ),
            TextButton(
              onPressed: () {
                _deleteItem(docID, context);
                Navigator.of(context).pop();
              },
              child: CustomText(
                letterSpacing: 1,
                color: AppColors.red,
                text: 'Delete',
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteItem(String documentId, BuildContext context) async {
    try {
      CloudServices.getItemCollection().doc(documentId).delete();

      CustomSnackBar.show(
          context: context,
          text: 'Delete Successfully',
          backgroundColor: Colors.green);
    } catch (error) {
      print('Error deleting item: $error');
    }
  }

// void _filterItems(String query) {
//   setState(() {
//     filteredItems = items
//         .where(
//             (item) => item.name.toLowerCase().contains(query.toLowerCase()))
//         .toList();
//   });
// }
}
