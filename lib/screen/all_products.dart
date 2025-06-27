// ignore_for_file: deprecated_member_use, invalid_use_of_protected_member

import 'dart:convert';
import 'package:buynow/controller/favirote_controller.dart';
import 'package:buynow/controller/product_controller.dart';
import 'package:buynow/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final ProductController _productController = Get.put(ProductController());
  final FaviroteController _faviroteController = Get.put(FaviroteController());

  @override
  void initState() {
    super.initState();
    _faviroteController.loadeFavoriteData();
    _productController.getAllProduct(); // ✅ Important call
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (_productController.productsList.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 3 / 4.5,
                  ),
                  itemCount: _productController.productsList.length,
                  itemBuilder: (context, index) {
                    final product = _productController.productsList[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RoutesName.detailsscreen,
                                  arguments: product);
                            },
                            child: Stack(children: [
                              SizedBox(
                                height: 140,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(10)),
                                  child: Image.memory(
                                    base64Decode(product.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Obx(() {
                                String productId = product.id;
                                bool isFavorite = _faviroteController
                                    .favoriteIds
                                    .contains(productId);
                                Map<String, dynamic> productData =
                                    product.toMap();

                                return Positioned(
                                  top: 7,
                                  right: 10,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Colors.white.withOpacity(0.7),
                                    child: IconButton(
                                      onPressed: () {
                                        _faviroteController.toggleFavorite(
                                            productId, productData);
                                      },
                                      icon: Icon(
                                        isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isFavorite
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 60, top: 10),
                            child: Text(
                              "Name: ${product.title}",
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Padding(
                            padding: const EdgeInsets.only(right: 60, top: 10),
                            child: Text(
                              "Price: \$${product.price}",
                              style: const TextStyle(
                                  color: Colors.green, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
