import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_woocommerce/config.dart';
import 'package:flutter_woocommerce/models/booking_model.dart';
import 'package:flutter_woocommerce/models/category_model.dart';
import 'package:flutter_woocommerce/models/customers.dart';

class APIService {
  Future<bool> createCustomer(CustomerModel model) async {
    var authToken =
        base64.encode(utf8.encode(Config.key + ":" + Config.secret));

    bool ret = false;

    try {
      var response = await Dio().post(Config.url + Config.customerURL,
          data: model.toJson(),
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic $authToken',
            HttpHeaders.contentTypeHeader: "application/json"
          }));
      if (response.statusCode == 201) {
        ret = true;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        ret = false;
      } else {
        ret = false;
      }
    }
    return ret;
  }

  Future<List<Category>> getCategories() async {
    List<Category> data = [];
    try {
      String url = "${Config.key}${Config.categoryUrl}?consumer_key=${Config.key}&consumer_secret=${Config.secret}";

      var response = await Dio().get(url,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }));
      if (response.statusCode == 200) {
        data =
            (response.data as List).map((i) => Category.fromJson(i)).toList();
      }
    } on DioException catch (e) {
      print(e.response);
    }
    return data;
  }

  
// final Dio _dio = Dio();

  Future<List<Product>> getProducts(int count) async {
  List<Product> products = [];
  try {
    String url =
        "https://devasthanam.com/wp-json/wc/v3/products?consumer_key=${Config.key}&consumer_secret=${Config.secret}&per_page=$count";

    var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    if (response.statusCode == 200) {
      products =
          (response.data as List).map((productData) => Product.fromJson(productData)).toList();
    }
  } on DioException catch (e) {
    print(e.response);
  }
  return products;
}

}
