import 'package:flutter/material.dart';
import 'package:food_saver/util/constant.dart';

class CardCategory extends StatelessWidget {
  const CardCategory({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(children: [Container(child: Text('😏')), Text(type)]),
        SizedBox(width: paddingMedium),
      ],
    );
  }
}
