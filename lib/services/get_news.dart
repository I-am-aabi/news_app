import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:news_app/models/news_model.dart';

class Services {}

Future<List<NewsData>> searchNews(String? query) async {
  String data = '';

  query != null ? data = query : data = 'world';


  final url = Uri.parse('https://timesofindia.indiatimes.com/topic/$data?toiPlusOnly=1');
  final response = await http.get(url);
  print(response.statusCode);
  dom.Document html = dom.Document.html(response.body);
// #storyBody > div > div.crmK8 > div > div.tabs_common > div > div:nth-child(1) > div > div:nth-child(3) > a > div > div.fHv_i.o58kM > span
  final titles = html
      .querySelectorAll(' div > div.fHv_i.o58kM ')
      .map((e) => e.innerHtml.trim())
      .toList();
      // #storyBody > div > div.crmK8 > div > div.tabs_common > div > div:nth-child(1) > div > div:nth-child(1) > a > div > p > span
  final subtitles = html
      .querySelectorAll(' div > p ')
      .map((e) => e.innerHtml.trim())
      .toList();
  final urls = html
      .querySelectorAll(' div.B1S3_content__wrap__9mSB6 > h3 > a')
      .map((e) => 'https://www.indiatoday.in${e.attributes['href']}')
      .toList();
  final images = html
      .querySelectorAll('div.B1S3_story__thumbnail___pFy6.undefined > a > img')
      .map((e) => '${e.attributes['src']}')
      .toList();
  print(titles);
  final List<NewsData> news = List.generate(
      titles.length,
      (index) => NewsData(
          title: titles[index],
          subtitle: subtitles[index],
          urlToContent: urls[index],
          urlToImage: images[index]));
  return news;
}

Future<List<NewsData>> fetchMainNews() async {
  final url = Uri.parse('https://www.indiatoday.in/topic/telangana');
  final response = await http.get(url);
  dom.Document html = dom.Document.html(response.body);
  final titles =
      html.querySelectorAll(' h3 > a').map((e) => e.innerHtml.trim()).toList();
  final subtitles = html
      .querySelectorAll('div.B1S3_story__shortcont__inicf > p')
      .map((e) => e.innerHtml.trim())
      .toList();
  final urls = html
      .querySelectorAll(' div.B1S3_content__wrap__9mSB6 > h3 > a')
      .map((e) => 'https://www.indiatoday.in${e.attributes['href']}')
      .toList();
  final images = html
      .querySelectorAll('div.B1S3_story__thumbnail___pFy6.undefined > a > img')
      .map((e) => '${e.attributes['src']}')
      .toList();
  final List<NewsData> news = List.generate(
      titles.length,
      (index) => NewsData(
          title: titles[index],
          subtitle: subtitles[index],
          urlToContent: urls[index],
          urlToImage: images[index]));
  return news;
}

Future<NewsDetails> getNewsDetails(String link) async {
  final url = Uri.parse(link);
  final response = await http.get(url);
  dom.Document html = dom.Document.html(response.body);
  final title = html
      .querySelector(
          'div.jsx-99cc083358cc2e2d.Story_story__content__body__qCd5E.story__content__body.widgetgap > h1')!
      .innerHtml
      .trim();
  final subtitle = html.querySelector(' div > h2')!.innerHtml.trim();
  final updateDetail = html
      .querySelector(
          'div.jsx-99cc083358cc2e2d.Story_stryupdates__wdMz_ > span.jsx-99cc083358cc2e2d.strydate')!
      .innerHtml
      .trim();
  final content = html
      .querySelectorAll(
          'div.jsx-99cc083358cc2e2d.Story_description__fq_4S.description > p')
      .map((e) => e.innerHtml.trim())
      .toList();
  final image = html
      .querySelector(
          'div.Story_srtymos__8Hq2k.srtymos > div.Story_associate__image__bYOH_.topImage > img')!
      .attributes['src'];

  final result = NewsDetails(
      title: title,
      subtitle: subtitle,
      updatedDetails: updateDetail,
      urlToImage: image,
      content: content);
  return result;
}
