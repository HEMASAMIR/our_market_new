import 'package:flutter/material.dart';
import 'package:our_market/core/components/products_list.dart';
import 'package:our_market/core/functions/build_appbar.dart';

class SearchView extends StatelessWidget {
  const SearchView({
    super.key,
    required this.query,
    this.onReturn,
  });

  final String query;
  final Function(String)? onReturn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
        context,
        "Search Results",
        returnValue: query, // لتفعيل الرجوع مع القيمة
      ),
      body: ListView(
        children: [
          const SizedBox(height: 15),
          ProductsList(),
        ],
      ),
    );
  }
}
