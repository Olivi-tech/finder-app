import 'package:flutter/material.dart';

class TabIndicators extends StatelessWidget {
  final int _numTabs;
  final int _activeIdx;
  final Color _activeColor;
  final Color _inactiveColor;
  final double _padding;
  final double _height;

  const TabIndicators(
      {required int numTabs,
      required int activeIdx,
      required Color activeColor,
      required double padding,
      required double height,
      Color inactiveColor = const Color(0x00FFFFFF),
      Key? key})
      : _numTabs = numTabs,
        _activeIdx = activeIdx,
        _activeColor = activeColor,
        _inactiveColor = inactiveColor,
        _padding = padding,
        _height = height,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final elements = <Widget>[];

    for (var i = 0; i < _numTabs; ++i) {
      elements.add(Expanded(
          child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: _padding,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
            color: i == _activeIdx ? _activeColor : _inactiveColor,
          ),
        ),
      )));
    }

    return SizedBox(
      height: _height,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: elements,
      ),
    );
  }
}
