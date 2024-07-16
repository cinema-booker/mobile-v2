import 'package:cinema_booker/theme/theme_color.dart';
import 'package:flutter/material.dart';

class InfiniteList<T> extends StatefulWidget {
  final Widget Function(BuildContext, T) builder;
  final Future<List<T>> Function(
    BuildContext context,
    int page,
    int limit,
  ) fetch;

  const InfiniteList({
    super.key,
    required this.builder,
    required this.fetch,
  });

  @override
  State<InfiniteList<T>> createState() => _InfiniteListState<T>();
}

class _InfiniteListState<T> extends State<InfiniteList<T>> {
  List<T> _items = [];
  int _page = 1;
  bool _hasMore = true;
  bool _isLoading = false;

  final int _limit = 10;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _refetch();
      }
    });
    _fetch();
  }

  Future<void> _fetch() async {
    if (_isLoading) return;
    _isLoading = true;

    setState(() {
      _items = [];
      _page = 1;
    });
    List<T> items = await widget.fetch(context, _page, _limit);
    setState(() {
      _items = items;
      _page++;
      _isLoading = false;
      if (items.length < _limit) {
        _hasMore = false;
      }
    });
  }

  Future<void> _refetch() async {
    List<T> items = await widget.fetch(context, _page, _limit);
    setState(() {
      _items.addAll(items);
      _page++;
      if (items.length < _limit) {
        _hasMore = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                _fetch();
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _items.length + 1,
                itemBuilder: (context, index) {
                  if (index == _items.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      child: Center(
                        child: _hasMore
                            ? const CircularProgressIndicator()
                            : const Text(
                                'No more data to load',
                                style: TextStyle(
                                  color: ThemeColor.white,
                                ),
                              ),
                      ),
                    );
                  }

                  T item = _items[index];
                  return widget.builder(context, item);
                },
              ),
            ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }
}
