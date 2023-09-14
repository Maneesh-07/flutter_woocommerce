// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class WooCommerceProductTable extends StatefulWidget {
//   const WooCommerceProductTable({super.key});

//   @override
//   _WooCommerceProductTableState createState() =>
//       _WooCommerceProductTableState();
// }

// class _WooCommerceProductTableState extends State<WooCommerceProductTable> {
//   List<dynamic> productData = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     final response = await http.get(
//         Uri.parse('https://your-wordpress-site.com/wp-json/wp/v2/products'),
//         headers: {
//           // Add authentication headers if needed
//           // 'Authorization': 'Bearer your_api_key',
//         });

//     if (response.statusCode == 200) {
//       setState(() {
//         productData = json.decode(response.body);
//       });
//     } else {
//       throw Exception('Failed to load product data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('WooCommerce Product Table'),
//       ),
//       body: ListView.builder(
//         itemCount: productData.length,
//         itemBuilder: (BuildContext context, int index) {
//           final product = productData[index];
//           return ListTile(
//             title: Text(product['name']),
//             subtitle: Text(product['price']),
//             // Add more details or customize the UI as needed
//           );
//         },
//       ),
//     );
//   }
// }
