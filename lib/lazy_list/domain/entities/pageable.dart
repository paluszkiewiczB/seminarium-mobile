class Pageable<T> {
  final int number;
  final List<T> content;

  bool get isEmpty => content?.isEmpty ?? true;

  Pageable<T> appendTo(Pageable<T> oldPage)
  => Pageable([...oldPage.content, ...content], number);

  static Pageable empty() => _EmptyPage();

  int get size => content.length;

  T operator [](int index) => content[index];

  const Pageable(this.content, this.number);
}

class _EmptyPage extends Pageable {
  const _EmptyPage() : super(const [], 0);

  @override
  Pageable appendTo(Pageable oldPage) => oldPage;
}


