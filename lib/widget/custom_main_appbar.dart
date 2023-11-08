import 'package:finder_app/constant/constant.dart';
import 'package:finder_app/widget/widget.dart';
import 'package:flutter/material.dart';


class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String location;
  final Color? backgroundColor;
  final double customAppBarHeight; 

  const AppBarCustom({
    Key? key,
    this.backgroundColor,
    required this.name,
    required this.location,
    this.customAppBarHeight = kToolbarHeight + 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: customAppBarHeight,
      titleSpacing: 0,
      elevation: 0.0,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: name,
              size: 22,
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                   color: Colors.white,
                  size: 16,
                ),
                SizedBox(
                  width: 5,
                ),
                CustomText(
                  text: location,
                  size: 16,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(AppImages.companylogo),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(customAppBarHeight);
}
