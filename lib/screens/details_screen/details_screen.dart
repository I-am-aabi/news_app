//now let's for the details screen

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/new_controller.dart';
import 'package:news_app/screens/details_screen/widgets/paragraph_widget.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({
    Key? key,
  }) : super(key: key);
  final NewsController newsController = Get.find();

  @override
  Widget build(BuildContext context) {
    final data = newsController.selectedNews;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.orange.shade900),
      ),
      body: Obx(
        () {
          if (!newsController.isloading.value) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  Text(
                    data!.title!,
                    style: const TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    data.updatedDetails!,
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Hero(
                    tag: data.title!,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image.network(data.urlToImage!),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.content.length,
                      itemBuilder: (context, index) {
                        return ParagraphWidget(text: data.content[index]!);
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
