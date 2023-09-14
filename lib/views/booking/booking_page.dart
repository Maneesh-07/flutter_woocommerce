
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/services/api_services.dart';
import 'package:flutter_woocommerce/utils/core/color.dart';
import 'package:flutter_woocommerce/utils/core/constants.dart';
import 'package:flutter_woocommerce/views/booking/cart/controller/cart_provider.dart';
import 'package:flutter_woocommerce/views/booking/widgets/booking_appbar.dart';
import 'package:flutter_woocommerce/views/booking/widgets/booking_widget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'cart/cart_page.dart';
import 'cart/controller/cart_item_model.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late APIService apiServices;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool isBuilderVisible = false;

  @override
  void initState() {
    super.initState();
    apiServices = APIService();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _initializeAnimation();
  }

  void _initializeAnimation() {
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleBottomPanel() {
    if (_animationController.status == AnimationStatus.completed) {
      // Hide sheet
      _animationController.reverse(from: 1.0);
      setState(() {
        isBuilderVisible = false;
      });
    } else {
      _animationController.forward();
      setState(() {
        isBuilderVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartModel>(context);
    final cartItemCount = cartProvider.cartItems.length;
    return Scaffold(
      key: scaffoldKey,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BookingAppBar(title: 'Pooja Booking'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height,
                  padding: const EdgeInsets.only(top: 1.0),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEDECF2),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child:  const Column(
                    children: [
                      Expanded(
                        child: BookingItemsList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (cartItemCount > 0)
            Positioned(
              bottom: -20,
              left: 0,
              top: 650,
              right: 0,
              child: Consumer<CartModel>(
                builder: (context, value, child) {
                  return AnimatedBuilder(
                    key: UniqueKey(),
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, -0 + (_animation.value)),
                        child: GestureDetector(
                          onTap: _toggleBottomPanel,
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                color: kColorBlack,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Total Amount:",
                                          style: bottomTextStyle,
                                        ),
                                        Text(
                                          '₹- ${calculateTotalAmount(value.cartItems)}',
                                          style: bottomTextStyle,
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 140,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: TextButton(
                                      onPressed: () {
                                        Get.to(() => const CartScreen());
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        'View Cart',
                                        style: bookingBottomTextStyle,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _toggleBottomPanel();
                                    },
                                    icon: const Icon(Icons.cancel),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget bottomSheetWrapper() {
    return Container();
  }

  double calculateTotalAmount(List<CartItem> cartItems) {
    double totalAmount = 0.0;
    for (var item in cartItems) {
      totalAmount += item.quantity * item.price;
    }
    return totalAmount;
  }
}



/**
 * 
                  GestureDetector(
                    // Custom bottom panel

                    child: Consumer<CartModel>(
                      builder: (context, value, child) {
                        return AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, -0 + (_animation.value * 100)),
                              child: GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                        color: kColorBlack,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Total Amount:",
                                                style: bottomTextStyle,
                                              ),
                                              Text(
                                                '₹- ${value.calculateTotalForQty()}',
                                                style: bottomTextStyle,
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: TextButton(
                                            onPressed: () {
                                              Get.to(() => const CartScreen());
                                            },
                                            style: TextButton.styleFrom(
                                              fixedSize: const Size(100, 40),
                                              foregroundColor: kWhiteColor,
                                              backgroundColor: kButtonColorBlue,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 5),
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
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
 */