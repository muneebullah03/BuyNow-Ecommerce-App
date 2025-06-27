// ignore_for_file: unused_field, prefer_final_fields

import 'package:buynow/controller/banner_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannersWidget extends StatefulWidget {
  const BannersWidget({super.key});

  @override
  State<BannersWidget> createState() => _BannersWidgetState();
}

class _BannersWidgetState extends State<BannersWidget> {
  final CarouselController carouselController = CarouselController();
  BannerController _bannerController = Get.put(BannerController());
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(),
        items: _bannerController.bannerUrl
            .map(
              (images) => ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: images,
                  fit: BoxFit.cover,
                  width: Get.width - 10,
                ),
              ),
            )
            .toList());
  }
}
