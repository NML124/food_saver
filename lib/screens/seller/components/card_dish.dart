import 'package:flutter/material.dart';
import 'package:food_saver/model/dish_model.dart';
import 'package:food_saver/screens/dish/modify_dish_screen.dart';
import 'package:food_saver/util/constant.dart';
import 'package:get/route_manager.dart';

class CardDish extends StatelessWidget {
  const CardDish({super.key, required this.dish});
  final DishModel dish;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(ModifyDishScreen(dish: dish));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.network(dish.image, fit: BoxFit.fill),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dish.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(dish.category, style: TextStyle(color: grey)),
                  ],
                ),
              ],
            ),
            Text(
              "₹${dish.price}",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
