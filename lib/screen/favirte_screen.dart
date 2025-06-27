import 'dart:convert';

import 'package:buynow/controller/favirote_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavirteScreen extends StatefulWidget {
  const FavirteScreen({super.key});

  @override
  State<FavirteScreen> createState() => _FavirteScreenState();
}

class _FavirteScreenState extends State<FavirteScreen> {
  final FaviroteController _faviroteController = Get.put(FaviroteController());

  @override
  void initState() {
    super.initState();
    _faviroteController.loadeFavoriteData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final item = _faviroteController.favoriteProducts[index];
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(19),
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
                itemCount: _faviroteController.favoriteProducts.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
