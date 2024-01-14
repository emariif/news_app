import 'package:flutter/material.dart';
import 'package:news_app/common/navigation.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/provider/database_provider.dart';
import 'package:news_app/ui/article_detail_page.dart';
import 'package:provider/provider.dart';

class CardArticle extends StatelessWidget {
  final Article article;

  const CardArticle({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBookmarked(article.url),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Material(
              // color: primaryColor,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                trailing: isBookmarked
                    ? IconButton(
                        onPressed: () => provider.removerBookmark(article.url),
                        icon: const Icon(Icons.bookmark),
                        color: Colors.red,
                      )
                    : IconButton(
                        onPressed: () => provider.addBookmark(article),
                        icon: const Icon(Icons.bookmark_border),
                        color: Colors.red,
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
                onTap: () => Navigation.intentWithData(
                    ArticleDetailPage.routeName, article),
              ),
            );
          },
        );
      },
    );
  }
}
