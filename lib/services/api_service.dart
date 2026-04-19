import 'dart:convert';
import 'package:my_shop_app/models/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {

  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(
      Uri.parse("https://fakestoreapi.com/products"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.map((item) => ProductModel.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

}