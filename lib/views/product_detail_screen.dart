import 'package:flutter/material.dart';
import 'package:my_shop_app/models/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;
  final Set<int> cartIds;
  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.cartIds,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Back"), backgroundColor: Colors.white),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Hero(
                    tag: widget.product.id ?? 0,
                    child: Image.network(
                      widget.product.image ?? "",
                      height: 350,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ), //Image.network
                  ), //Hero

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          widget.product.category ?? "",
                          style: TextStyle(fontSize: 13, color: Colors.grey, letterSpacing: 1.2),
                        ), //Text

                        SizedBox(height: 4),

                        Text(
                          widget.product.title ?? "",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                        ), //Text

                        SizedBox(height: 6),

                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 18),
                            SizedBox(width: 4),
                            Text(
                              "${widget.product.rating?.rate ?? 0}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ), //Text

                            SizedBox(width: 4),
                            
                            Text(
                              "(${widget.product.rating?.count ?? 0} reviews)",
                              style: TextStyle(color: Colors.grey, fontSize: 13),
                            ), //Text
                          ],
                        ), //Row

                        SizedBox(height: 16),

                        Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ), //Text

                        SizedBox(height: 4),

                        Text(
                          widget.product.description ?? "",
                          style: TextStyle(fontSize: 14),
                        ), //Text

                      ],
                    ), //Column
                  ), //Padding

                ],
              ), //Column
            ), //SingleChildScrollView
          ), //Expanded

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "\$${widget.product.price ?? 0}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ), //Text

                SizedBox(height: 8),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 45), // ✅ tam genişlik
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ), //RoundedRectangleBorder
                  ), //ElevatedButton.styleFrom
                  onPressed: () {
                    setState(() {
                      widget.cartIds.add(widget.product.id ?? 0);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Added to cart")),
                    ); //showSnackBar
                  },
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(color: Colors.white),
                  ), //Text
                ), //ElevatedButton

              ],
            ), //Column
          ), //Padding
        ],
      ), //Column - body
    ); //Scaffold
  }
}