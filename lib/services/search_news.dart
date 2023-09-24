import 'package:dio/dio.dart';
import 'package:news_app/models/news_search_model.dart';

Future<NewsSearch> fetchNewsResult(String? query) async {
  String search = '';
  query == null ? search = 'world' : search = query;
  final Dio dio = Dio();
  const String key = '3c62a112b7d1b8afab19f2a73e3a5530';
  final String url = 'https://gnews.io/api/v4/search?q=$search&apikey=$key';
  try {
    Response response = await dio.get(url);
    return NewsSearch.fromJson(response.data);
  } catch (error) {
    return NewsSearch.whithError("Data not found / Connection issue");
  }
}
