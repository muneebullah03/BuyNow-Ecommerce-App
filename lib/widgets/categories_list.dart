import 'package:buynow/controller/category_controller.dart';
import 'package:buynow/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesList extends StatelessWidget {
  CategoriesList({super.key});

  final List<Map<String, String>> categories = [
    {"title": "lamp", "image": "assets/images/lamp.PNG"},
    {"title": "clothing", "image": "assets/images/cloths.PNG"},
    {"title": "bag", "image": "assets/images/bag.PNG"},
    {"title": "headphones", "image": "assets/images/headphone.PNG"},
    {"title": "shoes", "image": "assets/images/shoes.PNG"},
  ];

  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Categories",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () {
                  Get.toNamed(RoutesName.allproducscreen);
                },
                child: Text("See All"),
              ),
            ],
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => SizedBox(width: 12),
              itemBuilder: (context, index) {
                final category = categories[index];

                return GestureDetector(
                  onTap: () {
                    categoryController.setCategory(category["title"]!);
                    Get.toNamed(RoutesName.CategoryProductsScreen);
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(category["image"]!),
                      ),
                      SizedBox(height: 6),
                      Text(category["title"]!, style: TextStyle(fontSize: 12)),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
