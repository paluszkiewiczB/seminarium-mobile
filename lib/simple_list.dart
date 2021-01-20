import 'package:flutter/material.dart';

import 'item.dart';

  class SimpleListPage extends StatelessWidget {
    @override
  Widget build(BuildContext context) =>
      SimpleList(loader: _loadPage, pageSize: 10, shouldLoad: (index, itemsCount) => itemsCount * 0.9 < index);

  Future<List<Item>> _loadPage(int pageNumber, int pageSize) =>
        Future.delayed(Duration(seconds: 1), () => _generate(pageNumber, pageSize).toList());

    Iterable<Item> _generate(int pageNumber, int pageSize) =>
        Iterable<int>.generate(pageSize, (index) => pageNumber * pageSize + index).map((i) => Item(i));
  }

  typedef Future<List<T>> PageLoader<T>(int pageNumber, int pageSize);
  typedef bool ShouldLoad(int index, int itemsCount);

  class SimpleList extends StatefulWidget {
    final PageLoader<Item> loader;
    final ShouldLoad shouldLoad;
    final int pageSize;

    const SimpleList({Key key, @required this.loader, @required this.pageSize, @required this.shouldLoad}) : super(key: key);

    @override
    _SimpleListState createState() => _SimpleListState();
  }

  class _SimpleListState extends State<SimpleList> {
    List<Item> _items = [];

    @override
    Widget build(BuildContext context) {
      return ListView.builder(
        itemCount: _items.length + 1,
        itemBuilder: (_, index) {
          if (widget.shouldLoad(index, _items.length)) {
            _loadPage(index);
            return Center(child: SizedBox(width: 30, height: 30, child: CircularProgressIndicator()));
          }
          return ItemTile(item: _items[index]);
        },
      );
    }

    void _loadPage(int index) {
      final pageNumber = (_items.length / widget.pageSize).floor();
      widget.loader(pageNumber, widget.pageSize).then((_newPage) => setState(() => _items.addAll(_newPage)));
    }
  }
