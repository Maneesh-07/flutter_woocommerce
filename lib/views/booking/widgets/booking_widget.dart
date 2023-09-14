
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/services/api_services.dart';
import 'package:flutter_woocommerce/views/booking/cart/controller/cart_item_model.dart';
import 'package:flutter_woocommerce/views/booking/widgets/booking_list_widget.dart';

class BookingItemsList extends StatefulWidget {
  const BookingItemsList({Key? key}) : super(key: key);

  @override
  State<BookingItemsList> createState() => _BookingItemsListState();
}

class _BookingItemsListState extends State<BookingItemsList>
    with SingleTickerProviderStateMixin {
  late APIService apiServices;
  

  @override
  void initState() {
    super.initState();
    apiServices = APIService();
  
  }

 


  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                BookingListWidgets(apiCount: 7, title: 'Special Pooja'),
                BookingListWidgets(apiCount: 7, title: 'Pooja'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  double calculateTotalAmount(List<CartItem> cartItems) {
    double totalAmount = 0.0;
    for (var item in cartItems) {
      totalAmount += item.quantity * item.price;
    }
    return totalAmount;
  }
}
