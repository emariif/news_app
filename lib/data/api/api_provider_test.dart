import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/data/models/article.dart';

class ApiProviderTest {
  final http.Client client;

  ApiProviderTest({required this.client});

  static const String _baseUrl = 'https://newsapi.org/v2/';
  static const String _apiKey = '93b7c385d3d24a60946b3c049ddc2c11';
  static const String _category = 'business';
  static const String _country = 'us';
  
  static const String baseUrl = "${_baseUrl}top-headlines?country=$_country&category=$_category&apiKey=$_apiKey";

  Future<ArticlesResult> topHeadlines() async {
    final response = await client.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return ArticlesResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}