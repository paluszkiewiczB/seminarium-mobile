import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/lazy_list/domain/entities/item.dart';
import 'package:mobile/lazy_list/domain/entities/pageable.dart';

import 'list_event.dart';
import 'list_state.dart';

const int PAGE_SIZE = 10;

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc() : super(const FirstPageLoading());

  @override
  Stream<ListState> mapEventToState(ListEvent event) async* {
    if (event is ItemPresented)
      yield* _loadNextPageIfRequired(event);
    else if (event is LoadFirstPage) yield* _loadFirstPage();
  }

  Stream<ListState> _loadNextPageIfRequired(ItemPresented event) async* {
    if (_shouldLoadNextPage(event)) {
      yield NextPageLoading(event.page);
      final page = await _getNextPage(event.page);
      yield PageLoaded(page);
    }
  }

  bool _shouldLoadNextPage(ItemPresented event) {
    final page = event.page;
    final pageSize = page.size / (page.number + 1).ceil();
    final result = (pageSize * 0.1).ceil() + event.index == page.size;
    return result;
  }

  Stream<ListState> _loadFirstPage() async* {
    yield const FirstPageLoading();
    final firstPage = await _getFirstPage();
    yield firstPage.isEmpty ? const NoResults() : PageLoaded(firstPage);
  }

  Future<Pageable<Item>> _getFirstPage() => Future.delayed(Duration(seconds: 5), () => _generatePage(0, PAGE_SIZE));

  Future<Pageable<Item>> _getNextPage(Pageable<Item> page) =>
      Future.delayed(Duration(seconds: 5), () => _generatePage(page.number + 1, PAGE_SIZE).appendTo(page));

  Pageable<Item> _generatePage(int pageNumber, int pageSize) {
    final items =
        Iterable<int>.generate(pageSize, (index) => pageNumber * pageSize + index).map((i) => Item.number(i)).toList();
    return Pageable(items, pageNumber);
  }
}
