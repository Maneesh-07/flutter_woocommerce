import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/models/booking_model.dart';
import 'package:flutter_woocommerce/models/category_model.dart';
import 'package:flutter_woocommerce/services/api_services.dart';

class WidgetCategories extends StatefulWidget {
  const WidgetCategories({super.key});

  @override
  State<WidgetCategories> createState() => _WidgetCategoriesState();
}

class _WidgetCategoriesState extends State<WidgetCategories> {
  late APIService apiServices;

  @override
  void initState() {
    apiServices = APIService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder<List<Product>>(
        future: apiServices.getProducts(35),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
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
                    title: Text(product.name),
                    subtitle: Text(product.price),
                    onTap: () {
                      // Handle item tap here
                    },
                  );
                },
              );
            } else {
              return Text('No products available.');
            }
          }
        },
      ),
    );
  }

 Widget _categoriesList() {
  return FutureBuilder(
    future: apiServices.getCategories(),
    builder: (BuildContext context, AsyncSnapshot<List<Category>> model) {
     if (model.hasData) {
       return _buildCategoryList(model.data);
     }
     return CircularProgressIndicator();
    },
  );
}

  Widget _buildCategoryList(List<Category>? categories) {
    return Container(
      height: 150,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories!.length,
        itemBuilder: (context, index) {
          var data = categories[index];
          return Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                width: 80,
                height: 80,
                alignment: Alignment.center,
                decoration:
                    const BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 5),
                    blurRadius: 15,
                  )
                ]),
                child: CachedNetworkImage(
                  imageUrl: data.image!.url,
                  height: 80,
                ),
              ),
              Row(
                children: [
                  Text(data.categoryName.toString()),
                  const Icon(
                    Icons.keyboard_arrow_right,
                    size: 14,
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
