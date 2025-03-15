import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:food_saver/model/dish_model.dart';
import 'package:food_saver/provider/supabase_crud.dart';
import 'package:food_saver/util/constant.dart';
import 'package:food_saver/util/methods.dart';
import 'package:food_saver/util/widgets/file_widget_picker.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/utils/form_validation.dart';
import 'package:uuid/uuid.dart';

class AddDishScreen extends StatefulWidget {
  const AddDishScreen({super.key});

  @override
  State<AddDishScreen> createState() => _AddDishScreenState();
}

class _AddDishScreenState extends State<AddDishScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  final crud = CRUD(table: dishesTable);
  String? selectedCategory;
  String? fileName;
  FilePickerResult? file;
  double heightMaterialUI = 90;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double width = size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Add a product")),
      body: Padding(
        padding: const EdgeInsets.all(paddingNormal),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              spacing: paddingSMedium,
              children: [
                FileWidgetForm(
                  title: "Product picture",
                  fileName: fileName,
                  widthScreen: size.width,
                  heightScreen: size.height,
                  onSelectedFile: (filePickerResult, name) {
                    fileName = name;
                    file = filePickerResult;
                    setState(() {});
                  },
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
                  width: width,
                  height: heightMaterialUI,
                  child: MaterialTextField(
                    keyboardType: TextInputType.number,
                    labelText: 'Quantity',
                    prefixIcon: Icon(Icons.onetwothree_rounded),
                    textInputAction: TextInputAction.next,
                    controller: quantityController,
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
                        ["Plastic", "Electronic", "Furniture", "Cloth"].map((
                          type,
                        ) {
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
                    onChanged: (text) {
                      selectedCategory = text;
                    },
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

                isLoading
                    ? loadingUploadFile(size: 30)
                    : SizedBox(
                      width: width,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await addProduct(context);
                        },
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
      ),
    );
  }

  Future<void> addProduct(BuildContext context) async {
    const uuid = Uuid();
    final idDocument = uuid.v4();
    if (formKey.currentState!.validate()) {
      try {
        String? path = await crud.uploadFile(
          dishesBucket,
          idDocument,
          dishesDocument,
          file,
        );
        if (path != null) {
          DishModel model = DishModel(
            image: path,
            name: nameController.text,
            price: double.parse(priceController.text),
            description: descriptionController.text,
            category: selectedCategory!,
            quantity: int.parse(quantityController.text),
          );

          final data = model.toMap();
          await crud.create(data);

          showNotification(
            title: "Message",
            body: "The product was successfully created💫",
            isError: false,
          );
          setState(() {
            isLoading = false;
          });
          resetValue();
        } else {
          setState(() {
            isLoading = false;
          });
          showNotification(
            title: "Add picture",
            body: "The picture you're trying to add already exists",
          );
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        showNotification(title: "Add picture", body: "Data logging error: $e");
      }
    }
  }

  void resetValue() {
    nameController.text = "";
    priceController.text = "";
    descriptionController.text = "";
    categoryController.text = "";
    quantityController.text = "";
    selectedCategory = null;
    file = null;
    fileName = null;
  }
}
