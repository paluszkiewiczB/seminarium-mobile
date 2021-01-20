import 'package:mobile/sse/domain/entities/item.dart';
import 'package:mobile/sse/domain/entities/pageable.dart';

class SsePage extends Pageable<Item> {
  final int pageSize;

  @override
  int get size => (number + 1) * pageSize;

  const SsePage(List<Item> content, int number, this.pageSize) : super(content, number);
}
