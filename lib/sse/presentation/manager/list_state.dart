import 'package:mobile/sse/domain/entities/item.dart';
import 'package:mobile/sse/domain/entities/pageable.dart';

abstract class ListState {
  const ListState();
}

class FirstPageLoading extends ListState {
  const FirstPageLoading();
}

class PageLoaded extends ListState {
  final Pageable<Item> page;

  const PageLoaded(this.page);
}

class NextPageLoading extends ListState {
  final Pageable<Item> page;

  const NextPageLoading(this.page);
}

class NoResults extends ListState {
  const NoResults();
}
