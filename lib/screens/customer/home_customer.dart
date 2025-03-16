import 'package:flutter/material.dart';
import 'package:food_saver/model/customer_model.dart';
import 'package:food_saver/model/dish_model.dart';
import 'package:food_saver/provider/supabase_crud.dart';
import 'package:food_saver/screens/customer/components/card_category.dart';
import 'package:food_saver/util/constant.dart';
import 'package:food_saver/util/widgets/food_card.dart';
import 'package:food_saver/util/widgets/search_text_field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeCustomer extends StatefulWidget {
  const HomeCustomer({super.key, required this.customer});
  final CustomerModel customer;
  @override
  State<HomeCustomer> createState() => _HomeCustomerState();
}

class _HomeCustomerState extends State<HomeCustomer> {
  final Stream<List<Map<String, dynamic>>> dishStream = CRUD(
    table: dishesTable,
  ).readStream<Map<String, dynamic>>(toElement: (row) => row);
  List<DishModel> dishes = [];
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
            searchTextField((text) {}),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 5,
              children: [
                CardCategory(type: "Electronic", icon: Icons.light),
                CardCategory(type: "Plastic", icon: Icons.ac_unit_rounded),
                CardCategory(
                  type: "Furniture",
                  icon: Icons.house_siding_rounded,
                ),
                CardCategory(
                  type: "Cloth",
                  icon: Icons.airline_seat_flat_sharp,
                ),
                CardCategory(type: "Other", icon: Icons.abc),
              ],
            ),
            Text("Products currently available"),
            StreamBuilder<List<Map<String, dynamic>>>(
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
                  return Expanded(
                    child: ListView.builder(
                      itemCount: dishes.length,
                      itemBuilder: (context, index) {
                        return FoodCard(dish: dishes[index]);
                      },
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
