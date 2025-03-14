import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:food_saver/model/dish_model.dart';
import 'package:food_saver/model/seller.dart';
import 'package:food_saver/screens/seller/components/card_dish.dart';

class HomeSellerScreen extends StatefulWidget {
  const HomeSellerScreen({super.key, required this.seller});
  final SellerModel seller;
  @override
  State<HomeSellerScreen> createState() => _HomeSellerScreenState();
}

class _HomeSellerScreenState extends State<HomeSellerScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double width = size.width;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              Text("Welcome,${widget.seller.name}"),
              Divider(color: Colors.grey, thickness: 1),
              Row(
                children: [
                  Text(
                    "24",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(" dishes delivered with love"),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 18,
                  left: 12,
                  top: 24,
                  bottom: 12,
                ),
                child: Container(
                  width: width,
                  height: 120,
                  color: Colors.green,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Dishes currently available"),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return CardDish(
                            dish: DishModel(
                              image: "image",
                              name: "Food",
                              price: 78000,
                              description: "bla bla car",
                              category: "Beverage",
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
