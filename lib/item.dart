import 'package:flutter/material.dart';

class Item {
  final int number;
  final String text;

  const Item(this.number) : this.text = "Jestem numerem $number";
}

class ItemTile extends StatelessWidget {
  final Item item;

  const ItemTile({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(leading: Text(item.number.toString()), trailing: Text(item.text));
  }
}
