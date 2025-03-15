import 'package:flutter/material.dart';
import 'package:food_saver/model/customer_model.dart';
import 'package:food_saver/model/dish_model.dart';
import 'package:food_saver/screens/customer/components/card_category.dart';
import 'package:food_saver/util/constant.dart';
import 'package:food_saver/util/widgets/food_card.dart';
import 'package:food_saver/util/widgets/search_text_field.dart';

class HomeCustomer extends StatefulWidget {
  const HomeCustomer({super.key, required this.customer});
  final CustomerModel customer;
  @override
  State<HomeCustomer> createState() => _HomeCustomerState();
}

class _HomeCustomerState extends State<HomeCustomer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(paddingNormal),
        child: Column(
          spacing: paddingSMedium,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width - 80,
              height: 150,
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(15),
                color: Colors.amber,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: paddingSMedium,
                      children: [
                        Text("Discover  completely"),
                        Text("FREE"),
                        Text("dishes"),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text("Discover"),
                        ),
                      ],
                    ),
                    Image(image: AssetImage(backgroundDishCard), height: 50),
                  ],
                ),
              ),
            ),
            searchTextField((text) {}),
            SizedBox(
              width: size.width,
              height: 90,
              child: Center(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return CardCategory(type: "Beverage");
                  },
                ),
              ),
            ),
            Text("Dishes currently available"),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return FoodCard(
                    dish: DishModel(
                      image: "image",
                      name: "name",
                      price: 5,
                      description: "description",
                      category: "beverage",
                      quantity: 1
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
