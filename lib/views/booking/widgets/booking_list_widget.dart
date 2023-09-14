import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/models/booking_model.dart';
import 'package:flutter_woocommerce/services/api_services.dart';
import 'package:flutter_woocommerce/utils/core/color.dart';
import 'package:flutter_woocommerce/utils/core/constants.dart';
import 'package:flutter_woocommerce/views/booking/cart/controller/cart_provider.dart';
import 'package:flutter_woocommerce/views/booking/widgets/quantity_widget.dart';
import 'package:provider/provider.dart';

class BookingListWidgets extends StatefulWidget {
  const BookingListWidgets(
      {Key? key, required this.apiCount, required this.title})
      : super(key: key);

  final int apiCount;
  final String title;

  @override
  State<BookingListWidgets> createState() => _BookingListWidgetsState();
}

class _BookingListWidgetsState extends State<BookingListWidgets>
    with SingleTickerProviderStateMixin {
  late APIService apiServices;
  late TextEditingController inputQtyController;
  late int selectedQuantity = 1;

  @override
  void initState() {
    super.initState();
    apiServices = APIService();
    inputQtyController = TextEditingController(text: '1');

    // _animation = CurvedAnimation(
    //   parent: _animationController,
    //   curve: Curves.easeInOut,
    // );
  }

  void resetQuantity() {
    inputQtyController.text = '1';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              widget.title,
              style: fontStyle,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height / 2.5 * 0.9,
            child: FutureBuilder<List<Product>>(
              future: apiServices.getProducts(widget.apiCount),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final products = snapshot.data;
                  if (products != null && products.isNotEmpty) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 110,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: kWhiteColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            margin: const EdgeInsets.only(
                                                right: 15),
                                            child: Image.asset(
                                                'assets/images/pexels-photo-2733918.jpeg'),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      truncateProductName(
                                                          product.name, 33),
                                                      style: bookingPageTiltle,
                                                    ),
                                                    Consumer<CartModel>(
                                                      builder: (context,
                                                          cartModel, _) {
                                                        // final existingCartItem =
                                                        //     cartModel.cartItems
                                                        //         .firstWhere(
                                                        //   (item) =>
                                                        //       item.product ==
                                                        //       product,
                                                        //   orElse: () =>
                                                        //       CartItem(
                                                        //     product: product,
                                                        //     quantity:
                                                        //         1, // Set the initial quantity to 0
                                                        //     price: double.parse(
                                                        //         product.price),
                                                        //   ),
                                                        // );

                                                        return TextButton(
                                                          onPressed: () {
                                                            // int updatedQuantity =
                                                            //     existingCartItem
                                                            //             .quantity +
                                                            //         1;
                                                            // cartModel
                                                            //     .addItemToCart(
                                                            //   product,
                                                            //   updatedQuantity,
                                                            //   double.parse(
                                                            //       product
                                                            //           .price),
                                                            // );
                                                            cartModel
                                                                .addItemToCart(
                                                              product,
                                                              selectedQuantity, // Set the quantity to 1
                                                              double.parse(
                                                                  product
                                                                      .price),
                                                            );
                                                            // if (selectedQuantity >
                                                            //     0) {
                                                            // } else {
                                                            //   // Show an error message or handle the case where no quantity is selected.
                                                            //   showToast(
                                                            //       'Please select a quantity before booking.');
                                                            // }
                                                          },
                                                          style: TextButton
                                                              .styleFrom(
                                                            minimumSize:
                                                                const Size(
                                                                    10, 15),
                                                            foregroundColor:
                                                                kWhiteColor,
                                                            backgroundColor:
                                                                backgroundcolor,
                                                          ),
                                                          child: const Text(
                                                              'Book'),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Flexible(
                                                      flex: 1,
                                                      child:
                                                          Text(product.price),
                                                    ),
                                                    Consumer<CartModel>(
                                                      builder: (context,
                                                              cartModel, _) =>
                                                          QuantityWidget(
                                                        product: product,
                                                        onQuantityChanged:
                                                            (newQuantity) {
                                                          selectedQuantity =
                                                              newQuantity;
                                                          cartModel
                                                              .updateItemQuantity(
                                                                  product,
                                                                  selectedQuantity);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Text("No Product Available");
                  }
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  String truncateProductName(String productName, int maxLength) {
    if (productName.length > maxLength) {
      return productName.substring(0, maxLength ~/ 2);
    }
    return productName;
  }

  // void showToast(String message) {
  //   Fluttertoast.showToast(
  //     msg: message,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.SNACKBAR,
  //     timeInSecForIosWeb: 1000,
  //     backgroundColor: Colors.black.withOpacity(0.7),
  //     textColor: Colors.white,
  //     fontSize: 16.0,
  //   );
  // }
}
