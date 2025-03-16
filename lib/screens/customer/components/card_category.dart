import 'package:flutter/material.dart';

class CardCategory extends StatelessWidget {
  const CardCategory({super.key, required this.type, required this.icon});
  final String type;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(children: [Icon(icon), Text(type)]);
  }
}
