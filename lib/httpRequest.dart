import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Article {
  final int id;
  final int userId;
  final String title;
  final String body;

  Article({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }
}

class ApiService {
  final Dio _dio = Dio();
  static const String _cacheKey = 'cached_articles';
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Article>> fetchArticles() async {
    try {
      final response = await _dio.get('$_baseUrl/posts');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<Article> articles =
            data.map((json) => Article.fromJson(json)).toList();

        // Cache the articles locally
        await _cacheArticles(articles);

        return articles;
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (e) {
      // If network request fails, try to load from cache
      print('Network error: $e');
      return await _getCachedArticles();
    }
  }

  Future<void> _cacheArticles(List<Article> articles) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final articlesJson = articles.map((article) => article.toJson()).toList();
      await prefs.setString(_cacheKey, jsonEncode(articlesJson));
    } catch (e) {
      print('Error caching articles: $e');
    }
  }

  Future<List<Article>> _getCachedArticles() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString(_cacheKey);

      if (cachedData != null) {
        List<dynamic> jsonList = jsonDecode(cachedData);
        return jsonList.map((json) => Article.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error loading cached articles: $e');
    }

    return []; // Return empty list if no cache or error
  }

  Future<bool> hasCachedData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_cacheKey);
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Articles App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ArticlesScreen(),
    );
  }
}

class ArticlesScreen extends StatefulWidget {
  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  final ApiService _apiService = ApiService();
  List<Article> _articles = [];
  bool _isLoading = true;
  bool _isFromCache = false;

  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  Future<void> _loadArticles() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Check if we have cached data first
      bool hasCached = await _apiService.hasCachedData();

      final articles = await _apiService.fetchArticles();

      setState(() {
        _articles = articles;
        _isLoading = false;
        _isFromCache = hasCached && articles.isNotEmpty;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading articles: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _refreshArticles() async {
    await _loadArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Articles'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshArticles,
          ),
        ],
      ),
      body: Column(
        children: [
          if (_isFromCache)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              color: Colors.orange[100],
              child: Text(
                'Showing cached data (offline mode)',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.orange[800]),
              ),
            ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _articles.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline,
                                size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text('No articles available'),
                            SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: _refreshArticles,
                              child: Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _refreshArticles,
                        child: ListView.builder(
                          itemCount: _articles.length,
                          itemBuilder: (context, index) {
                            final article = _articles[index];
                            return Card(
                              margin: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: ListTile(
                                title: Text(
                                  article.title,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  article.body,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: CircleAvatar(
                                  child: Text('${article.id}'),
                                ),
                                onTap: () {
                                  _showArticleDetails(article);
                                },
                              ),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  void _showArticleDetails(Article article) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(article.title),
        content: SingleChildScrollView(
          child: Text(article.body),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
