import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  const Empty({Key? key, required this.assetName, this.padding})
      : super(key: key);

  final String assetName;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: padding ?? 15),
        child: Image.asset(assetName, fit: BoxFit.cover),
      ),
    );
  }
}
