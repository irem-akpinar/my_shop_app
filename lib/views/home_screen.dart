import 'package:my_shop_app/views/cart_screen.dart';
import 'package:my_shop_app/models/product_model.dart';
import 'package:my_shop_app/services/api_service.dart';
import 'package:my_shop_app/components/product_card.dart';
import 'package:my_shop_app/views/product_detail_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> allProducts = [];
  bool isLoading = false;
  String errorMessage = "";
  ApiService apiService = ApiService();
  Set<int> cartIds = {};

  Future<void> loadData () async {
    try {
      setState(() {
        isLoading = true;
      });

      final data = await apiService.fetchProducts();
  
      setState(() {
        allProducts = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Failed to load products";
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Discover",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ), // TextStyle
                  ), // Text

                  IconButton(
                    onPressed: (){
                      Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context)=> CartScreen(
                                products: allProducts, 
                                cartIds: cartIds,
                              ), // ProductDetailScreen
                            ), // MaterialPageRoute
                          );
                    }, 
                    icon: Icon(Icons.shopping_bag_outlined),
                    iconSize: 32,
                  ), //IconButton
                ],
              ), //Row

              SizedBox(height: 8),

              Text(
                "Find your perfect device.",
                style: TextStyle(fontSize:16, color: Colors.grey),
              ), //Text

              SizedBox(height: 14),

              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f5f7),
                  borderRadius: BorderRadius.circular(12),
                ), //BoxDecoration
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search products",
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                    border: InputBorder.none,
                  ), //InputDecoration
                ), // TextField
              ), // Container

              SizedBox(height: 16),

              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius : BorderRadius.circular(12),
                  image: DecorationImage
                    (image: NetworkImage(
                      "https://www.wantapi.com/assets/banner.png" // BANNER RESMİ BURDA
                    ), // NetworkImage
                    fit: BoxFit.fitWidth,
                  ), // DecorationImage
                ), //BoxDecoration
              ), // Container

              SizedBox(height: 16),

              if(isLoading)
                Center(child: CircularProgressIndicator())
              else if (errorMessage.isNotEmpty)
                Center(child: Text(errorMessage))
              else
                Expanded(
                  child: GridView.builder(
                    itemCount: allProducts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ), //SliverGridDelegateWithFixedCrossAxisCount

                    itemBuilder: (context, index){
                      final product = allProducts[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context)=>ProductDetailScreen(
                                product: product, 
                                cartIds: cartIds
                              ), // ProductDetailScreen
                            ), // MaterialPageRoute
                          );
                        },
                        child:ProductCard(product: product),
                      ); //GestureDetector
                    },
                  ) ,//GridView.builder
                ), // Expanded
            ], 
          ), // Column
        ), // Padding
      ), // SafeArea
    ); // Scaffold
  }
}