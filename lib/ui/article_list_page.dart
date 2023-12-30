import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/api/api_service.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/ui/article_detail_page.dart';
import 'package:news_app/widgets/card_article.dart';
import 'package:news_app/widgets/platform_widget.dart';

class ArticleListPage extends StatefulWidget {
  const ArticleListPage({super.key});

  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  late Future<ArticlesResult> _article;

  @override
  void initState() {
    super.initState();
    _article = ApiService().topHeadlines();
  }

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
    return FutureBuilder<ArticlesResult>(
      future: _article,
      builder: (context, AsyncSnapshot<ArticlesResult> snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          );
        } else {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.articles.length,
              itemBuilder: (BuildContext context, int index) {
                var article = snapshot.data?.articles[index];
                return CardArticle(
                  article: article!,
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
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: Text(''),
            );
          }
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
