
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_woocommerce/utils/core/color.dart';
import 'package:flutter_woocommerce/views/booking/cart/cart_page.dart';
import 'package:flutter_woocommerce/views/booking/cart/controller/cart_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BookingAppBar extends StatelessWidget {
  final String title;

  const BookingAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firstLetter = title.isNotEmpty ? title[0] : '';
    final restOfTitle = title.substring(1);

    final cartProvider = Provider.of<CartModel>(context);
    final cartItemCount = cartProvider.cartItems.length;

    return AppBar(
      backgroundColor: const Color.fromARGB(255, 213, 168, 45),
      title: Row(
        children: [
          RichText(
            text: TextSpan(
                text: firstLetter,
                style: GoogleFonts.robotoSlab(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 4,
                  ),
                ),
                children: [
                  TextSpan(
                    text: restOfTitle,
                    style: GoogleFonts.robotoSlab(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: backgroundcolor),
                    ),
                  ),
                ]),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Ionicons.ios_cart,
                  size: 30,
                  color: backgroundcolor,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                ),
              ),
              if (cartItemCount >
                  0) // Display the counter only if items are in the cart
                Positioned(
                  right: 12,
                  top: 1,
                  bottom: 30,
                  child: CircleAvatar(
                    backgroundColor: Colors.red, // You can customize the color
                    radius: 10,
                    child: Text(
                      cartItemCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
