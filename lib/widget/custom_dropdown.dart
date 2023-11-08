import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  final List<String> itemList;
  final TextEditingController controller;
  final void Function(String?) onChanged;
  final bool? isExpended;

  const DropDownWidget({
    super.key,
    required this.itemList,
    required this.controller,
    this.isExpended = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Center(
        child: DropdownMenu<String>(
          controller: controller,
          width: MediaQuery.sizeOf(context).width * .91,
          inputDecorationTheme: const InputDecorationTheme(
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.black,
              )),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  borderSide: BorderSide(color: Colors.black, width: .5)),
              filled: true),
          initialSelection: itemList.first,
          onSelected: onChanged,
          dropdownMenuEntries:
              itemList.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(value: value, label: value);
          }).toList(),
        ),
      ),
    );
  }
}

class DropDownsWidget extends StatelessWidget {
  final List<String> itemList;

  final double iconWidth;
  final double iconHeight;
  final double horizontalPadding;
  final TextEditingController controller;
  final void Function(String?) onChanged;

  const DropDownsWidget({
    super.key,
    required this.itemList,
    this.iconWidth = 24,
    this.iconHeight = 24,
    this.horizontalPadding = 14.0,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: DropdownButton(
        icon: Icon(
          Icons.arrow_drop_down,
          size: 16,
        ),
        menuMaxHeight: 300,
        underline: const SizedBox(),
        alignment: Alignment.center,
        items: itemList.map<DropdownMenuItem<String>>((String item) {
          return DropdownMenuItem(
            alignment: Alignment.center,
            enabled: true,
            value: item,
            child: Center(child: Text(item)),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
