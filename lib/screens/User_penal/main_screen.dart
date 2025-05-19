import 'package:flutter/material.dart';
import 'package:shoopingapp/utlis/app_constain.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:shoopingapp/widgets/heading.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Map<String, dynamic>> imageList = [
    {"id": 1, "imageurl": "assets/pic/slider1.jpg"},
    {"id": 2, "imageurl": "assets/pic/slider2.jpg"},
    {"id": 3, "imageurl": "assets/pic/slider3.jpg"},
    {"id": 4, "imageurl": "assets/pic/slider4.jpg"},
  ];

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text(AppConstent.appmainApp),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CarouselSlider(
            items:
                imageList.map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          item['imageurl'],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      );
                    },
                  );
                }).toList(),
            // Removed controller for now
            options: CarouselOptions(
              scrollPhysics: const BouncingScrollPhysics(),
              autoPlay: true,
              aspectRatio: 2,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),

          Container(
            child: headingwidget(
              HeadingTitle: "Categories",
              HeadingSubTitle: "According to Yuor Budget",
              onTap: () {},
              buttonText: "See More",
            ),
          ),

          Container(
            child: headingwidget(
              HeadingTitle: "Categories",
              HeadingSubTitle: "According to Yuor Budget",
              onTap: () {},
              buttonText: "See More",
            ),
          ),
        ],
      ),
    );
  }
}
