class NewsData {
  String? title;
  String? subtitle;
  String? urlToImage;
  String? urlToContent;
  String? content;
  NewsData({
    required this.title,
    required this.subtitle,
    required this.urlToContent,
    required this.urlToImage,
  });
}

class NewsDetails {
  late final String? title;
  late final String? subtitle;
  late final String? updatedDetails;
  late final String? urlToImage;
  late final List<String?> content;
  String? uid;
  NewsDetails(
      {required this.title,
      required this.subtitle,
      required this.updatedDetails,
      required this.urlToImage,
      required this.content,
      this.uid});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    // data['content'] = content;
    data['content'] = content;
    data['urlToImage'] = urlToImage;
    data['updatedDetails'] = updatedDetails;
    return data;
  }

  // late final String title;
  NewsDetails.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    content = json['content'];
    // content = json['url'];
    urlToImage = json['urlToImage'];
    updatedDetails = json['updatedDetails'];
  }
}
