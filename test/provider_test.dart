import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app/data/api/api_provider_test.dart';
import 'package:news_app/data/models/article.dart';

import 'provider_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ApiProviderTest apiProviderTest;
  late http.Client client;

  setUp(() {
    client = MockClient();
    apiProviderTest = ApiProviderTest(client: client);
  });

  group('fetchNews', () {
    test('returns Article News if the http call completes successfully',
        () async {
      when(client.get(Uri.parse(ApiProviderTest.baseUrl))).thenAnswer(
          (_) async => http.Response(
              '{"status": "ok", "totalResults": 68, "articles": []}', 200));

      expect(await apiProviderTest.topHeadlines(), isA<ArticlesResult>());
    });

    test("throwns an exception if the http call completes with an error", () {
      when(client.get(Uri.parse(ApiProviderTest.baseUrl)))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(apiProviderTest.topHeadlines(), throwsException);
    });
  });
}
