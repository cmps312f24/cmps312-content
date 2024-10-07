import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:state_management/models/category.dart';
import 'package:state_management/models/product.dart';

class ProductRepository {
  static Future<List<Product>> getProducts() async {
    final String response =
        await rootBundle.loadString('assets/data/products.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Product.fromJson(json)).toList();
  }

  static Future<List<String>> getCategories() async {
    final String response =
        await rootBundle.loadString('assets/data/categories.json');
    final List<dynamic> data = json.decode(response);
    final categories = data.map((json) => Category.fromJson(json)).toList();
    return categories.map((category) => category.name).toList();
  }
}
