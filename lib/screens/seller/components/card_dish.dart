import 'package:flutter/material.dart';
import 'package:food_saver/model/dish_model.dart';

class CardDish extends StatelessWidget {
  const CardDish({super.key, required this.dish});
  final DishModel dish;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 30, height: 30, color: Colors.green),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(dish.name), Text(dish.category)],
              ),
            ],
          ),
          Text("₹${dish.price}"),
        ],
      ),
    );
  }
}
