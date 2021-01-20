import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/sse/domain/use_cases/get_page.dart';

import 'list_event.dart';
import 'list_state.dart';

class SseListBloc extends Bloc<ListEvent, ListState> {
  final GetPage getPage;

  SseListBloc(this.getPage) : super(const FirstPageLoading());

  @override
  Stream<ListState> mapEventToState(ListEvent event) async* {
    if (event is ItemPresented)
      yield* _loadNextPageIfRequired(event);
    else if (event is LoadFirstPage) yield* _loadFirstPage();
  }

  Stream<ListState> _loadNextPageIfRequired(ItemPresented event) async* {
    if (_shouldLoadNextPage(event)) {
      yield NextPageLoading(event.page);
      yield* getPage.getNextPage(event.page).map((p) => PageLoaded(p));
    }
  }

  bool _shouldLoadNextPage(ItemPresented event) {
    return event.index + 1 == event.page.size;
  }

  Stream<ListState> _loadFirstPage() async* {
    yield const FirstPageLoading();
    yield* getPage.getFirstPage().map((p) => p.isEmpty ? const NoResults() : PageLoaded(p));
  }
}
