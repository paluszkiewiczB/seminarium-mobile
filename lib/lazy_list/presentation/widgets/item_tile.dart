import 'package:flutter/material.dart';
import 'package:mobile/lazy_list/domain/entities/item.dart';

class ItemTile extends StatelessWidget {
  final Item item;

  const ItemTile({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(leading: Text(item.number.toString()), trailing: Text(item.text));
  }
}
