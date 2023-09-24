//let's start by our home screen
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/new_controller.dart';
import 'package:news_app/screens/home_screen/widgets/breaking_news_card.dart';

import 'package:news_app/screens/home_screen/widgets/news_list_tile.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final NewsController newsController = Get.put(NewsController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Breaking News",
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //let's build our caroussel
          Obx(
            () => CarouselSlider.builder(
                itemCount: newsController.latestnews.length,
                itemBuilder: (context, index, id) =>
                    BreakingNewsCard(newsController.latestnews[index]),
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                )),
          ),
          const SizedBox(
            height: 40.0,
          ),
          const Text(
            "Recent News",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          //now let's create the cards for the recent news
          Obx(
            () => Column(
              children:
                  newsController.allnews.map((e) => NewsListTile(e)).toList(),
            ),
          ),
        ],
      ),
    ));
  }
}
