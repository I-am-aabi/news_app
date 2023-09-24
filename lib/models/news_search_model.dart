class NewsSearch {
  NewsSearch({
    required this.totalArticles,
    required this.articles,
  });
  late final int totalArticles;
  late final List<Articles> articles;
  String? error;
  NewsSearch.fromJson(Map<String, dynamic> json) {
    totalArticles = json['totalArticles'];
    articles =
        List.from(json['articles']).map((e) => Articles.fromJson(e)).toList();
  }
  NewsSearch.whithError(String message) {
     error = message;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['totalArticles'] = totalArticles;
    data['articles'] = articles.map((e) => e.toJson()).toList();
    return data;
  }
}

class Articles {
  Articles({
    required this.title,
    required this.description,
    required this.content,
    required this.url,
    required this.image,
    required this.publishedAt,
  });
  late final String title;
  late final String description;
  late final String content;
  late final String url;
  late final String image;
  late final String publishedAt;

  Articles.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    content = json['content'];
    url = json['url'];
    image = json['image'];
    publishedAt = json['publishedAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['content'] = content;
    data['url'] = url;
    data['image'] = image;
    data['publishedAt'] = publishedAt;

    return data;
  }
}
