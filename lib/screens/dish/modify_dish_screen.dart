import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:food_saver/lib/constant.dart';
import 'package:food_saver/model/dish_model.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/utils/form_validation.dart';

class ModifyDishScreen extends StatefulWidget {
  const ModifyDishScreen({super.key, required this.dish});
  final DishModel dish;
  @override
  State<ModifyDishScreen> createState() => _ModifyDishScreenState();
}

class _ModifyDishScreenState extends State<ModifyDishScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  String? selectedCategory;
  double heightMaterialUI = 90;


  
  @override
  void initState() {
    nameController.text=widget.dish.name;
    priceController.text=widget.dish.price.toString();
    descriptionController.text=widget.dish.description;
    categoryController.text=widget.dish.category;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double width = size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Add a dish")),
      body: Padding(
        padding: const EdgeInsets.all(paddingNormal),
        child: SingleChildScrollView(
          child: Column(
            spacing: paddingSMedium,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: width,
                  height: 250,
                  color: Colors.amber,
                ),
              ),
              SizedBox(
                width: width,
                height: heightMaterialUI,
                child: MaterialTextField(
                  keyboardType: TextInputType.text,
                  labelText: 'Name',
                  textInputAction: TextInputAction.next,
                  controller: nameController,
                  validator: FormValidation.requiredTextField,
                ),
              ),
              SizedBox(
                width: width,
                height: heightMaterialUI,
                child: MaterialTextField(
                  keyboardType: TextInputType.number,
                  labelText: 'Price',
                  prefixIcon: Icon(Icons.currency_rupee_rounded),
                  textInputAction: TextInputAction.next,
                  controller: priceController,
                  validator: FormValidation.requiredTextField,
                ),
              ),
              SizedBox(
                width: width * 0.9,
                child: DropdownButtonFormField<String>(
                  dropdownColor: white,
                  focusColor: white,
                  value: selectedCategory,
                  validator: (value) {
                    return (value == "" || value == null)
                        ? "This field cannot be empty"
                        : null;
                  },
                  hint: const AutoSizeText(
                    "Category",
                    maxLines: 1,
                    style: TextStyle(fontSize: textSizeLargeMedium),
                  ),
                  items:
                      ["Beverage", "Dinner", "BreakFast"].map((type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: SizedBox(
                            width: width * 0.75,
                            child: AutoSizeText(
                              type,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: textSizeLargeMedium,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      }).toList(),
                  onChanged: (text) {},
                  decoration: const InputDecoration(
                    fillColor: white,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
              ),
              SizedBox(
                width: width,
                height: heightMaterialUI,
                child: MaterialTextField(
                  keyboardType: TextInputType.number,
                  labelText: 'Description',
                  maxLines: 3,
                  prefixIcon: Icon(Icons.text_format),

                  textInputAction: TextInputAction.next,
                  controller: descriptionController,
                  validator: FormValidation.requiredTextField,
                ),
              ),

              SizedBox(
                width: width,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Add", style: TextStyle(color: white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
