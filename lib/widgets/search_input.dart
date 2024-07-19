import 'dart:async';

import 'package:cinema_booker/widgets/text_input.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final Duration debounceDuration;

  const SearchInput({
    super.key,
    required this.onChanged,
    this.debounceDuration = const Duration(milliseconds: 500),
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(widget.debounceDuration, () {
      widget.onChanged(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextInput(
      hint: "Search",
      controller: _searchController,
      icon: Icons.search,
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();

    super.dispose();
  }
}
