import 'dart:convert';

import 'package:mobile/sse/domain/entities/item.dart';
import 'package:mobile/sse/domain/entities/pageable.dart';
import 'package:mobile/sse/domain/entities/sse_page.dart';
import 'package:sse_client/sse_client.dart';

const String URL = 'http://10.5.155.106:8080/nextPage';

class GetPage {
  Stream<Pageable<Item>> getFirstPage() async* {
    var page = SsePage([], 0, 10);
    yield* _get(0, 10).map((p) {
      page = SsePage([...page.content, p], 0, 10);
      return page;
    });
  }

  Stream<Pageable<Item>> getNextPage(SsePage page) async* {
    final newNumber = page.number + 1;

    yield* _get(newNumber, (page.size / newNumber).ceil()).map((p) {
      page = SsePage([...page.content, p], newNumber, page.pageSize);
      return page;
    });
  }

  Stream<Item> _get(int pageNumber, int pageSize) async* {
    final client = SseClient.connect(Uri.parse('$URL?size=$pageSize&number=$pageNumber'));
    yield* client.stream.map(_toItem).take(pageSize);
  }

  Item _toItem(dynamic itemString) => Item.fromJson(json.decode(itemString));
}
