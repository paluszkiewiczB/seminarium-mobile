import 'package:mobile/lazy_list/domain/entities/item.dart';
import 'package:mobile/lazy_list/domain/entities/pageable.dart';

abstract class ListEvent{
  const ListEvent();
}

class LoadFirstPage extends ListEvent{
  const LoadFirstPage();
}

class ItemPresented extends ListEvent{
  final int index;
  final Pageable<Item> page;

  const ItemPresented(this.index, this.page);
}