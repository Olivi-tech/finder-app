import 'package:finder_app/providers/item_filter_provider.dart';
import 'package:finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CustomFilterChipContainer extends StatelessWidget {
  final String filter;
  final String filterTitle;
  final String filterKey;
  final int index;
  final ItemFilterProvider filterProvider;

  const CustomFilterChipContainer(
      {super.key,
      required this.filter,
      required this.filterKey,
      required this.filterTitle,
      required this.index,
      required this.filterProvider});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: '$filterTitle : ',
              ),
              CustomText(
                text: filter,
                size: 16,
              ),
              InkWell(
                onTap: () {
                  filterProvider.cancelFilterByIndex(
                      filterKey: filterKey, index: index);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Icon(
                    Icons.cancel,
                    size: 20,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
