import 'package:flutter/material.dart';
import 'package:food_saver/home_screen.dart';
import 'package:food_saver/model/customer_model.dart';
import 'package:food_saver/screens/customer/home_customer.dart';
import 'package:food_saver/util/env.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: SUPABASE_URL, anonKey: SUPABASE_ANON_KEY);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
        home: MaterialApp(
          title: 'Food saver',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a purple toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),

          home: HomeScreen(),
          /*
          home: HomeSellerScreen(
            seller: SellerModel(
              id: 1,
              name: "name",
              localisation: "localisation",
              image: "image",
              phoneNumber: "phoneNumber",
            ),
          ),*/
        ),
      ),
    );
  }
}
