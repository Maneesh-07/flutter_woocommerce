import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/views/booking/booking_page.dart';
import 'package:flutter_woocommerce/views/booking/cart/controller/cart_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
            useMaterial3: true,
          ),
          home: const BookingScreen()),
    );
  }
}
