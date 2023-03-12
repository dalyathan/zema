import 'package:flutter/material.dart';

class TabHeaders extends StatelessWidget {
  const TabHeaders(
      {required this.buttonName,
      super.key,
      required this.width,
      required this.height});
  final String buttonName;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(height * 0.5),
                right: Radius.circular(height * 0.5))),
        child: Text(buttonName));
  }
}
