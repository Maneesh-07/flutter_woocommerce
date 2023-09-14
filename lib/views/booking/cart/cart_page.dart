
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/utils/core/color.dart';
import 'package:flutter_woocommerce/utils/core/constants.dart';
import 'package:flutter_woocommerce/views/booking/cart/controller/cart_item_model.dart';
import 'package:flutter_woocommerce/views/booking/cart/controller/cart_provider.dart';
import 'package:flutter_woocommerce/views/booking/cart/widgets/cart_appbar.dart';
import 'package:flutter_woocommerce/views/booking/order_page/order_details.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CartAppBar(title: 'My Cart'),
      ),
      body: Consumer<CartModel>(
        builder: (context, value, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: value.cartItems.length,
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    final item = value.cartItems[index];
                    final quantity = item.quantity;
                    final price = item.price;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15)),
                        child: ListTile(
                          title: Text(
                            item.product.name,
                            maxLines: 1,
                          ), // Use product name
                          subtitle: Text('Quantity: $quantity'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                  '₹${price * quantity}'), // Calculate total price
                              IconButton(
                                onPressed: () {
                                  Provider.of<CartModel>(context, listen: false)
                                      .removeItemFromCart(index);
                                },
                                icon: const Icon(Icons.cancel),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(36.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Amount",
                            style: bottomTextStyle,
                          ),
                          Text(
                            '₹${calculateTotalAmount(value.cartItems)}', // Calculate total cart amount
                            style: bottomTextStyle,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextButton(
                          onPressed: () {
                            Get.to(() => const OrderScreen());
                          },
                          style: TextButton.styleFrom(
                            fixedSize: const Size(70, 0),
                            foregroundColor: kWhiteColor,
                            backgroundColor: kButtonColorBlue,
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'View Cart',
                            style: bookingBottomTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Calculate the total cart amount
  double calculateTotalAmount(List<CartItem> cartItems) {
    double totalAmount = 0.0;
    for (var item in cartItems) {
      totalAmount += item.quantity * item.price;
    }
    return totalAmount;
  }
}
