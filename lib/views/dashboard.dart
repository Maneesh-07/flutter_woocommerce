import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/models/booking_model.dart';
import 'package:flutter_woocommerce/services/api_services.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  late APIService apiServices;

  @override
  void initState() {
    apiServices = APIService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.white,
              height: 250,
              child: Column(
                children: [
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Special Pooja",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.sizeOf(context).height,
                      color: Colors.white,
                      child: FutureBuilder<List<Product>>(
                        future: apiServices.getProducts(35),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            final products = snapshot.data;
                            if (products != null && products.isNotEmpty) {
                              return ListView.builder(
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  final product = products[index];
                                  return ListTile(
                                    title: Text(
                                      product.name,
                                      maxLines: 1,
                                    ),
                                    subtitle: Text(product.price),
                                    onTap: () {
                                      // Handle item tap here
                                    },
                                  );
                                },
                              );
                            } else {
                              return const Text('No products available.');
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pooja",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.sizeOf(context).height,
                    color: Colors.white,
                    child: FutureBuilder<List<Product>>(
                      future: apiServices.getProducts(35),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          final products = snapshot.data;
                          if (products != null && products.isNotEmpty) {
                            return ListView.builder(
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return ListTile(
                                  title: Text(
                                    product.name,
                                    maxLines: 1,
                                  ),
                                  subtitle: Text(product.price),
                                  onTap: () {
                                    // Handle item tap here
                                  },
                                );
                              },
                            );
                          } else {
                            return const Text('No products available.');
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget imageCarousel(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 200.0,
      child: Carousel(
        overlayShadow: false,
        borderRadius: true,
        boxFit: BoxFit.none,
        autoplay: true,
        dotSize: 4.0,
        images: [
          FittedBox(
            fit: BoxFit.fill,
            child:
                Image.asset("assets/images/istockphoto-521812367-170667a.webp"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.asset("assets/images/pexels-photo-2449665.jpeg"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.asset("assets/images/pexels-photo-2733918.jpeg"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.asset("assets/images/pexels-photo-5745903.jpeg"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.asset("assets/images/pexels-photo-6152382.jpeg"),
          ),
        ],
      ),
    );
  }
}
