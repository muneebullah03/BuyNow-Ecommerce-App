// ignore_for_file: use_key_in_widget_constructors

import 'dart:convert';

import 'package:buynow/controller/category_controller.dart';
import 'package:buynow/models/product_model.dart';
import 'package:buynow/routes/routes_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryProductsScreen extends StatelessWidget {
  final CategoryController categoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    String categoryName = categoryController.selectedCategory.value;

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('categore', isEqualTo: categoryName)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No products found in $categoryName"));
          }

          final products = snapshot.data!.docs;

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(
                    RoutesName.detailsscreen,
                    arguments: Product(
                      id: product.id,
                      title: product['title'],
                      description: product['description'],
                      imageUrl: product['imageUrl'],
                      price: product['price'],
                      categore: product['categore'],
                    ),
                  );
                },
                child: Card(
                  elevation: 4,
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.memory(
                            base64Decode(
                              product['imageUrl'],
                            ),
                            fit: BoxFit.cover),
                      ),
                      SizedBox(height: 5),
                      Text(product['title'],
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Price: \$${product['price']}"),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
