class Item {
  final int number;
  final String text;

  const Item(this.number, this.text);

  factory Item.number(int number) => Item(number, "Jestem numerem $number");

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(json['number'] as int, json['text'] as String);
  }
}
