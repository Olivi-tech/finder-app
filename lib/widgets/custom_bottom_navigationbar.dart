import 'package:finder_app/utils/utils.dart';
import 'package:finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final NavigateCurrentIndex? getSelectedIndex;

  const CustomBottomNavigationBar({Key? key, this.getSelectedIndex})
      : super(key: key);

  @override
  CustomBottomNavigationBarState createState() =>
      CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  Color _getIconColor(int index) {
    return _selectedIndex == index ? AppColors.green : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          child: BottomNavigationBar(
            elevation: 5,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            currentIndex: _selectedIndex,
            showUnselectedLabels: true,
            selectedFontSize: 5,
            unselectedFontSize: 5,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
                widget.getSelectedIndex!(index);
              });
            },
            items: [
              _bottomNavigationView(
                index: 0,
                icon: Icons.home,
              ),
              _bottomNavigationView(
                index: 1,
                icon: Icons.add,
              ),
              _bottomNavigationView(
                index: 2,
                icon: Icons.settings,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: TabIndicators(
            activeIdx: _selectedIndex,
            activeColor: AppColors.green,
            numTabs: 3,
            padding: 40,
            height: 5,
          ),
        ),
      ],
    );
  }

  BottomNavigationBarItem _bottomNavigationView(
      {required IconData icon, required int index}) {
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: _getIconColor(index),
            size: 30,
          ),
        ],
      ),
      label: "",
    );
  }
}
