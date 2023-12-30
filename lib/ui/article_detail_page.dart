import 'package:flutter/material.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/ui/article_web_view.dart';

class ArticleDetailPage extends StatelessWidget {
  static const routeName = '/article_detail';

  final Article article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            article.urlToImage == null
                ? const SizedBox(
                    height: 200,
                    child: Icon(Icons.error),
                  )
                : Hero(
                    tag: article.urlToImage!,
                    child: Image.network(article.urlToImage!),
                  ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.description ?? "",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Divider(color: Colors.grey),
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Divider(color: Colors.grey),
                  Text(
                    'Date: ${article.publishedAt}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Author: ${article.author}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Divider(color: Colors.grey),
                  Text(
                    article.content!,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ArticleWebView.routeName,
                          arguments: article.url);
                    },
                    child: const Text('Read more'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
