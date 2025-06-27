// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:buynow/controller/product_controller.dart';
import 'package:buynow/models/product_model.dart';
import 'package:buynow/widgets/custom_button.dart';
import 'package:buynow/widgets/custome_drawer.dart';
import 'package:buynow/widgets/custome_text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final priceController = TextEditingController();
  final productKey = GlobalKey<FormState>();

  final ProductController _productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        centerTitle: true,
      ),
      drawer: CustomeDrawer(),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  _productController.pickedImageFromGallary();
                },
                child: Obx(() {
                  final pickedFile = _productController.pickedImage.value;
                  if (pickedFile != null) {
                    return Container(
                      width: width * 0.75,
                      height: height * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: FileImage(File(pickedFile.path)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      width: width * 0.75,
                      height: height * 0.25,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 216, 212, 212),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text('Select Image'),
                      ),
                    );
                  }
                }),
              ),
            ),
            SizedBox(height: 30),
            Form(
                key: productKey,
                child: Column(
                  children: [
                    CustomeTextForm(
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Product Name';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                        hintText: 'Name'),
                    SizedBox(height: 10),
                    CustomeTextForm(
                        controller: descriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Product Description';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                        hintText: 'Description'),
                    SizedBox(height: 10),
                    CustomeTextForm(
                        controller: categoryController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Product Category';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                        hintText: 'Category'),
                    SizedBox(height: 10),
                    CustomeTextForm(
                        controller: priceController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Product Price';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                        hintText: 'Price'),
                  ],
                )),
            SizedBox(height: 30),
            Obx(
              () => CustomButton(
                  widget: _productController.isloading.value
                      ? Center(
                          child: CircularProgressIndicator(color: Colors.white))
                      : Center(
                          child: Text(
                          'Submitt',
                          style: TextStyle(color: Colors.white),
                        )),
                  ontap: () {
                    if (productKey.currentState!.validate()) {
                      final newProduct = Product(
                          id: '',
                          title: nameController.text.trim(),
                          description: descriptionController.text.trim(),
                          price: double.parse(priceController.text),
                          imageUrl: _productController.imageUrl.value,
                          categore: categoryController.text.trim());

                      _productController
                          .addProductToFirebase(newProduct)
                          .then((value) {
                        nameController.clear();
                        descriptionController.clear();
                        categoryController.clear();
                        priceController.clear();
                        _productController.pickedImage.value = null;
                        _productController.imageUrl.value = '';
                      });
                    }
                  }),
            )
          ],
        )),
      ),
    );
  }
}
