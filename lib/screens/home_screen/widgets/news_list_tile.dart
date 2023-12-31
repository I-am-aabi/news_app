import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/new_controller.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/screens/details_screen/details_screen.dart';

class NewsListTile extends StatelessWidget {
  NewsListTile(this.data, {Key? key}) : super(key: key);
  NewsData data;
  final NewsController newsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        newsController.changeLoadingState();
        Get.to(DetailsScreen());
        await newsController.onTapNews(data);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 20.0),
        padding: const EdgeInsets.all(12.0),
        height: 150,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(26.0),
        ),
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: Hero(
                tag: "${data.title}",
                child: SizedBox(
                  height: 100.0,
                  width: 100,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        data.urlToImage!,
                        fit: BoxFit.fill,
                      )),
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Flexible(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data.title!,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(data.subtitle!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white54,
                        ))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
