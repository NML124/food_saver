import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:food_saver/model/dish_model.dart';
import 'package:food_saver/model/seller_model.dart';
import 'package:food_saver/provider/supabase_crud.dart';
import 'package:food_saver/screens/seller/components/card_dish.dart';
import 'package:food_saver/util/constant.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
    List<DishModel> dishes = [];
    final Stream<List<Map<String, dynamic>>> dishStream = CRUD(
      table: dishesTable,
    ).readStream<Map<String, dynamic>>(toElement: (row) => row);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: StreamBuilder<List<Map<String, dynamic>>>(
            stream: dishStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                    color: primary,
                    size: 50,
                  ),
                );
              }
              if (!snapshot.hasData) {
                return Center(child: Text("No products available now 😅"));
              }
              if (snapshot.hasData) {
                dishes = DishModel.fromList(snapshot.data);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Welcome, ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextSpan(
                            text: widget.seller.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: textSizeNormal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey, thickness: 1),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${dishes.length}",
                                style: TextStyle(
                                  fontSize: textSizeLarge,
                                  color: primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: " products available for delivery",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    /*  Padding(
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
                    ),*/
                    SizedBox(height: paddingSmall),
                    Text(
                      "Products currently available",
                      style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: dishes.length,
                        itemBuilder: (context, index) {
                          return CardDish(dish: dishes[index]);
                        },
                      ),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
