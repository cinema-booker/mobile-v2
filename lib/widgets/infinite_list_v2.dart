import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:flutter/material.dart';

class InfiniteList<T> extends StatefulWidget {
  final Widget Function(BuildContext, T) builder;
  final Future<ApiResponse<List<T>>> Function(
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
  String? _error;

  int _page = 1;
  bool _hasMore = true;

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
    setState(() {
      _items = [];
      _error = null;
      _page = 1;
    });
    ApiResponse<List<T>> response = await widget.fetch(context, _page, _limit);
    setState(() {
      if (response.data != null) {
        _items = response.data!;
      }
      _error = response.error;
      _page++;
      if (response.data != null && response.data!.length < _limit) {
        _hasMore = false;
      }
    });
  }

  Future<void> _refetch() async {
    ApiResponse<List<T>> response = await widget.fetch(context, _page, _limit);
    setState(() {
      if (response.data != null) {
        _items.addAll(response.data!);
      }
      _error = response.error;
      _page++;
      if (response.data != null && response.data!.length < _limit) {
        _hasMore = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (_items.isEmpty && _error == null)
          ? const Center(
              child: CircularProgressIndicator(
              color: ThemeColor.yellow,
            ))
          : _error != null
              ? Center(
                  child: Text(
                    _error!,
                    style: const TextStyle(
                      color: ThemeColor.white,
                    ),
                  ),
                )
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
                                      fontSize: 12,
                                      color: ThemeColor.gray,
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
