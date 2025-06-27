import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  RxList<String> bannerUrl = RxList([]);

  @override
  void onInit() {
    super.onInit();

    fetchBannerData();
  }

  Future<void> fetchBannerData() async {
    try {
      QuerySnapshot bannersSnapshoot =
          await FirebaseFirestore.instance.collection('sliderImage').get();

      if (bannersSnapshoot.docs.isNotEmpty) {
        bannerUrl.value = bannersSnapshoot.docs
            .map((docs) => docs['images'] as String)
            .toList();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
