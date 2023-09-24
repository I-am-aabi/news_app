import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/models/news_search_model.dart';
import 'package:news_app/services/get_news.dart';
import 'package:news_app/services/search_news.dart';

class NewsController extends GetxController {
  RxList<NewsData> allnews = RxList<NewsData>();
  RxList<NewsData> latestnews = RxList<NewsData>();
  RxList<NewsDetails> savedNews = RxList<NewsDetails>();

  RxList<Articles> searchResult = RxList<Articles>();
  final CollectionReference newsCollection =
      FirebaseFirestore.instance.collection('news');
  User? user = FirebaseAuth.instance.currentUser;

  NewsDetails? selectedNews;
  String? selectedNewsUrl;
  RxBool isloading = true.obs;

  @override
  void onInit() async {
    final List<NewsData> result = await fetchMainNews();
    latestnews.value = result.sublist(0, 4);
    allnews.value = result.sublist(4);
    isloading.value = false;
    final data = await fetchNewsResult(null);
    searchResult.value = data.articles;
    super.onInit();
  }

  changeLoadingState() {
    isloading.value = true;
  }

  NewsDetails articleToNewsData(Articles data) {
    return NewsDetails(
        title: data.title,
        subtitle: data.description,
        urlToImage: data.image,
        content: [data.content],
        updatedDetails: data.publishedAt,
        uid: user!.uid);
  }

  onTapNews(NewsData news) async {
    selectedNewsUrl = news.urlToContent;
    isloading.value = true;
    selectedNews = await getNewsDetails(selectedNewsUrl!);
    isloading.value = false;
    // selectedNews = news;
  }

  onTapSearchResult(Articles data) {
    final news = NewsDetails(
        title: data.title,
        subtitle: data.description,
        updatedDetails: data.publishedAt,
        urlToImage: data.image,
        content: [data.content]);
    selectedNews = news;
    isloading.value = false;
  }

  newsSearch(String? query) async {
    isloading.value = true;
    final data = await fetchNewsResult(query);
    searchResult.value = data.articles;
    isloading.value = false;
  }

  saveNews(NewsDetails data) {
    try {
      newsCollection.doc().set(data.toJson());
      Fluttertoast.showToast(
          msg: 'Saved Successfully', backgroundColor: Colors.green);
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Error while saving try again', backgroundColor: Colors.red);
    }
  }

  fetchSavedNews() async {
    try {
      isloading.value = true;
      final data =
          await newsCollection.where('uid', isEqualTo: user!.uid).get();
      List<NewsDetails> newsList = data.docs.map((e) {
        Map<String, dynamic> newsResult = e.data() as Map<String, dynamic>;
        return NewsDetails.fromJson(newsResult);
      }).toList();
      savedNews.value = newsList;
      isloading.value = false;
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Error while fetching news try again',
          backgroundColor: Colors.red);
    }
  }

  Future<void> deleteNews() async {
    try {
      QuerySnapshot querySnapshot = await newsCollection
          .where('title', isEqualTo: selectedNews!.title)
          .where('uid', isEqualTo: selectedNews!.uid)
          .get();

      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        await docSnapshot.reference.delete();
        Fluttertoast.showToast(
            msg: 'Successfully deleted', backgroundColor: Colors.green);

        await fetchMainNews();
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Error while deleting try again', backgroundColor: Colors.red);
      return;
    }
  }
}
