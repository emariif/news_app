import 'package:flutter/material.dart';
import 'package:news_app/common/styles.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/ui/article_detail_page.dart';

class CardArticle extends StatelessWidget {
  final Article article;
  final Function() onPressed;

  const CardArticle({
    super.key,
    required this.article,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: Hero(
          tag: article.urlToImage!,
          child: Image.network(
            article.urlToImage!,
            width: 100,
          ),
        ),
        title: Text(
          article.title,
        ),
        subtitle: Text(article.author ?? ""),
        onTap: onPressed,
      ),
    );
  }
}