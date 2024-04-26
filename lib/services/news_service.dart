import 'package:final_project/model/news_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsService {
  Future<List<Article>> getArticles() async {
    final response = await http.get(Uri.parse(
        'https://gnews.io/api/v4/search?q=example&apikey=2c853125c89d5af5a3dcf31d6aae09b3'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final articles = jsonData['articles'] as List<dynamic>;
      return articles.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
