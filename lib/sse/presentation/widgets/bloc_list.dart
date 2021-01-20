import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/sse/domain/entities/item.dart';
import 'package:mobile/sse/domain/entities/pageable.dart';
import 'package:mobile/sse/domain/use_cases/get_page.dart';
import 'package:mobile/sse/presentation/manager/sse_list_bloc.dart';
import 'package:mobile/sse/presentation/widgets/item_tile.dart';

class SseBlocListView extends StatefulWidget {
  const SseBlocListView({Key key}) : super(key: key);

  @override
  _SseBlocListViewState createState() => _SseBlocListViewState();
}

class _SseBlocListViewState extends State<SseBlocListView> {
  SseListBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => _bloc, child: BlocBuilder<SseListBloc, ListState>(builder: _buildBloc));
  }

  Widget _buildBloc(BuildContext context, ListState state) {
    if (state is FirstPageLoading)
      return Center(child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator()));

    if (state is NextPageLoading) return _listWithLoadingIndicator(state.page);

    if (state is PageLoaded) return _list(state.page);

    if (state is NoResults) return Center(child: Text("Brak elementów : ("));

    throw UnsupportedError("$runtimeType cannot handle state: ${state.runtimeType}");
  }

  Widget _list(Pageable<Item> page) {
    final list = page.content;
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, index) {
          _bloc.add(ItemPresented(index, page));
          return ItemTile(item: list[index]);
        });
  }

  Widget _listWithLoadingIndicator(Pageable<Item> page) {
    final list = page.content;
    return ListView.builder(
        itemCount: page.size + 1,
        itemBuilder: (_, index) {
          if (index == list.length) {
            return Center(child: SizedBox(width: 50, height: 50, child: CircularProgressIndicator()));
          }
          return ItemTile(item: list[index]);
        });
  }

  @override
  void initState() {
    super.initState();
    _bloc = SseListBloc(GetPage())..add(const LoadFirstPage());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
