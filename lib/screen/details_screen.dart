import 'dart:convert';

import 'package:buynow/models/product_model.dart';
import 'package:buynow/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final Product _product = Get.arguments as Product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 70),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.memory(
              base64Decode(_product.imageUrl),
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20),
          Text("Title: ${_product.title}", style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text("Price: \$${_product.price}",
              style: TextStyle(fontSize: 18, color: Colors.green)),
          SizedBox(height: 10),
          Text("Category: ${_product.categore}",
              style: TextStyle(fontSize: 16)),
          SizedBox(height: 10),
          Text("Description:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(_product.description, style: TextStyle(fontSize: 14)),
          ),
          SizedBox(height: 85),
          CustomButton(
              widget: Center(
                  child: Text(
                'Add to Cart',
                style: TextStyle(color: Colors.white),
              )),
              ontap: () {})
        ],
      ),
    );
  }
}
