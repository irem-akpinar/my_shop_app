import 'package:my_shop_app/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0,4),
          ), // BoxShadow
        ],
      ), //BoxDecoration

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: Hero(
              tag: product.id ?? 0,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.vertical(
                  top: Radius.circular(12),
                ), //BorderRadiusGeometry.vertical

                child: Image.network(
                  product.image ?? "",
                  width: double.infinity,
                  fit: BoxFit.contain,
                ), //Image.network

              ), // ClipRRect
            ), //Hero
          ), // Expanded

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  product.title ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ), //Text

                SizedBox(height: 1),

                Text(
                  product.description ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ), //Text

                SizedBox(height: 1),

                Text(
                  "\$${product.price ?? 0}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ), //Text

              ],
            ), //Column
          ), //Padding

        ],
      ), //Column
    ); //Container
  }
}