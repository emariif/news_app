import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/ui/article_detail_page.dart';
import 'package:news_app/widgets/card_article.dart';
import 'package:news_app/widgets/platform_widget.dart';
import 'package:provider/provider.dart';

class ArticleListPage extends StatelessWidget {
  const ArticleListPage({super.key});

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('News_app'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<NewsProvider>(
      builder: (context, NewsProvider news, _) {
        if (news.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (news.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: news.result.articles.length,
            itemBuilder: (BuildContext context, int index) {
              var article = news.result.articles[index];
              return CardArticle(
                article: article,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    ArticleDetailPage.routeName,
                    arguments: article,
                  );
                },
              );
            },
          );
        } else if (news.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(news.message),
            ),
          );
        } else if (news.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(news.message),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text(''),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
