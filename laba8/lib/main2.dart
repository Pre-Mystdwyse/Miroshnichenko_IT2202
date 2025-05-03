import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as intl;

class CustomHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (_, __, ___) => true;
  }
}

Future<List<NewsItem>> fetchNews(http.Client client) async {
  final response = await client.get(
    Uri.parse('https://kubsau.ru/api/getNews.php?key=6df2f5d38d4e16b5a923a6d4873e2ee295d0ac90'),
  );
  return parseNews(response.body);
}

List<NewsItem> parseNews(String body) {
  final decoded = jsonDecode(body) as List<dynamic>;
  return decoded.map((data) => NewsItem.fromJson(data)).toList();
}

class NewsItem {
  final int id;
  final String date;
  final String title;
  final String previewText;
  final String previewPicture;
  final String detailUrl;

  const NewsItem({
    required this.id,
    required this.date,
    required this.title,
    required this.previewText,
    required this.previewPicture,
    required this.detailUrl,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      id: int.parse(json['ID'] as String),
      date: json['ACTIVE_FROM'] as String,
      title: json['TITLE'] as String,
      previewText: json['PREVIEW_TEXT'] as String,
      previewPicture: json['PREVIEW_PICTURE_SRC'] as String,
      detailUrl: json['DETAIL_PAGE_URL'] as String,
    );
  }
}

void main() {
  HttpOverrides.global = CustomHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Новости КубГАУ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Новости КубГАУ')),
      body: FutureBuilder<List<NewsItem>>(
        future: fetchNews(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Ошибка запроса!'));
          } else if (snapshot.hasData) {
            return NewsList(newsItems: snapshot.data!);
          } else {
            return const Center(child: Text('Нет данных'));
          }
        },
      ),
    );
  }
}

class NewsList extends StatelessWidget {
  const NewsList({Key? key, required this.newsItems}) : super(key: key);
  final List<NewsItem> newsItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsItems.length,
      itemBuilder: (context, index) {
        final item = newsItems[index];
        final cleanedTitle = intl.Bidi.stripHtmlIfNeeded(item.title);
        final cleanedText = intl.Bidi.stripHtmlIfNeeded(item.previewText);

        return NewsCard(newsItem: item, cleanedTitle: cleanedTitle, cleanedText: cleanedText);
      },
    );
  }
}

class NewsCard extends StatelessWidget {
  final NewsItem newsItem;
  final String cleanedTitle;
  final String cleanedText;

  const NewsCard({
    Key? key,
    required this.newsItem,
    required this.cleanedTitle,
    required this.cleanedText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (newsItem.previewPicture.isNotEmpty)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                newsItem.previewPicture,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 150,
                    child: Center(child: Text('Изображение не доступно')),
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              newsItem.date,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              cleanedTitle,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              cleanedText,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}