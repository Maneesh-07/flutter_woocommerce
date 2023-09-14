import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/models/booking_model.dart';
import 'package:flutter_woocommerce/views/booking/cart/controller/cart_item_model.dart';
import 'package:http/http.dart' as http;

class CartModel extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addItemToCart(Product product, int quantity, double price) {
    final existingCartItemIndex =
        _cartItems.indexWhere((item) => item.product == product);

    if (existingCartItemIndex != -1) {
      _cartItems[existingCartItemIndex].quantity = quantity + 1;
    } else {
      final newItem =
          CartItem(product: product, quantity: quantity, price: price);
      _cartItems.add(newItem);
    }

    notifyListeners();
  }

  updateItemQuantity(Product product, int quantity) {
    final existingCartItem = _cartItems.firstWhere(
      (item) => item.product == product,
      orElse: () => CartItem(product: product, quantity: 0, price: 0.0),
    );

    existingCartItem.quantity = quantity;
    notifyListeners();
  }

  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void incrementQuantity(CartItem item) {
    item.quantity += 1;

    notifyListeners();
  }

  void decrementQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity -= 1;
      notifyListeners();
    }
  }


  Future<void> createOrder({
    required String name,
    required String email,
    required String phone,
    required String address,
  }) async {
    final apiUrl = 'YOUR_WOOCOMMERCE_API_ENDPOINT/orders'; // Replace with your WooCommerce API orders endpoint
    final apiKey = 'YOUR_API_KEY'; // Replace with your WooCommerce API key

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final orderData = {
      'billing': {
        'first_name': name,
        'email': email,
        'phone': phone,
        'address_1': address,
        // Add other billing details as needed
      },
      'line_items': cartItems.map((item) {
        return {
          'product_id': item.product.id, // Replace with your product ID
          'quantity': item.quantity,
        };
      }).toList(),
      // Add other order details as needed
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(orderData),
    );

    if (response.statusCode == 201) {
      // Order creation successful
      final responseData = jsonDecode(response.body);
      print('Order created successfully: $responseData');
      // Handle success as needed
    } else {
      // Order creation failed
      print('Order creation failed: ${response.statusCode}');
      print('Response body: ${response.body}');
      // Handle errors as needed
    }
  }
}
