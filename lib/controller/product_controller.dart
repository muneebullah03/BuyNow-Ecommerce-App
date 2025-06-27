import 'dart:convert';
import 'dart:io';

import 'package:buynow/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Rx<XFile?> pickedImage = Rx<XFile?>(null);
  final RxString imageUrl = ''.obs;
  final RxBool isloading = false.obs;
  RxList<Product> productsList = <Product>[].obs;
  RxList<Product> categoryList = <Product>[].obs;

  final ImagePicker _imagePicker = ImagePicker();
  @override
  void onInit() {
    getAllProduct();
    super.onInit();
  }

// picked Image
  Future<void> pickedImageFromGallary() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      pickedImage.value = image;
      File file = File(image.path);
      List<int> imageBytes = await file.readAsBytes();
      imageUrl.value = base64Encode(imageBytes);
    }
  }

  /// add to firestore the data

  Future<void> addProductToFirebase(Product product) async {
    isloading.value = true;
    try {
      await _firebaseFirestore.collection('products').add({
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageUrl': imageUrl.value, // stored directly
        'categore': product.categore,
      });
      Get.snackbar('Success', 'Product added successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isloading.value = false;
    }
  }

// get the data

  Future<void> getAllProduct() async {
    try {
      _firebaseFirestore.collection('products').snapshots().listen((snapshot) {
        final List<Product> loadedProducts = snapshot.docs.map((doc) {
          return Product.fromMap(doc.data(), doc.id);
        }).toList();
        productsList.assignAll(loadedProducts); // Automatically update the list
      });
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // get category data
  Future<void> getCategoryData(String category) async {
    try {
      isloading.value = true;
      print('Fetching category: $category');
      QuerySnapshot snapshot = await _firebaseFirestore
          .collection('products')
          .where('categore', isEqualTo: category)
          .get();

      final fetched = snapshot.docs
          .map((doc) =>
              Product.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      categoryList.value = fetched;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch products");
    } finally {
      isloading.value = false;
    }
  }
}
