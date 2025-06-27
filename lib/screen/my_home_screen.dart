// ignore_for_file: unused_field, unused_local_variable

import 'dart:convert';

import 'package:buynow/controller/product_controller.dart';
import 'package:buynow/routes/routes_name.dart';
import 'package:buynow/widgets/categories_list.dart';
import 'package:buynow/widgets/custome_drawer.dart';
import 'package:buynow/widgets/custome_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/banner_controller.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final TextEditingController searchController = TextEditingController();
  final BannerController _bannerController = Get.put(BannerController());
  final ProductController _productController = Get.put(ProductController());
  List<String> categories = ['All', 'Women', 'Men', 'Sports', 'Jewelry'];

  String selectedCategory = 'All'; // default selected

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {}, icon: Icon(Icons.shopping_cart_checkout)),
          )
        ],
      ),
      drawer: CustomeDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            CustomTextFormField(
              hintText: 'Search',
              prefixIcon: Icons.search,
              controller: searchController,
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (contex, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  selectedCategory == categories[index]
                                      ? const Color.fromARGB(255, 247, 237, 237)
                                      : Colors.white),
                          onPressed: () {
                            setState(() {
                              selectedCategory = categories[index];
                            });
                            if (selectedCategory == 'All') {
                              _productController.getAllProduct();
                            } else {
                              _productController.getCategoryData(
                                  selectedCategory.toLowerCase());
                            }
                          },
                          child: Text(
                            categories[index],
                            style: TextStyle(
                                color: selectedCategory == categories[index]
                                    ? Colors.orange
                                    : Colors.black),
                          )),
                    );
                  }),
            ),
            SizedBox(height: 20),
            Obx(() {
              if (_bannerController.bannerUrl.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: CarouselSlider.builder(
                  itemCount: _bannerController.bannerUrl.length,
                  itemBuilder: (context, index, realIndex) {
                    final imageUrl = _bannerController.bannerUrl[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error, color: Colors.red),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                  ),
                ),
              );
            }),
            CategoriesList(),
            Padding(
              padding: const EdgeInsets.only(right: 240),
              child: Text(
                'New Arrivals',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(() {
              if (_productController.isloading.value) {
                return Center(child: CircularProgressIndicator());
              }
              final productList = _productController.productsList;
              if (productList.isEmpty) {
                return Center(child: Text('No data found'));
              }
              return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 3.5 / 5.0),
                  itemCount: _productController.productsList.length,
                  itemBuilder: (context, index) {
                    final products = _productController.productsList[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 4,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RoutesName.detailsscreen,
                                  arguments: products);
                            },
                            child: SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10)),
                                child: Image.memory(
                                  base64Decode(products.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 60, top: 10),
                            child: Text(
                              "Name :${products.title}",
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                          SizedBox(height: 4),
                          Padding(
                            padding: const EdgeInsets.only(right: 60, top: 10),
                            child: Text(
                              '\$${"Price : ${products.price}"}',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            })
          ],
        ),
      ),
    );
  }
}
