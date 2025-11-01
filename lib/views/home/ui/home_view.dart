import 'package:flutter/material.dart';
import 'package:our_market/core/components/custom_search_field.dart';
import 'package:our_market/core/components/products_list.dart';
import 'package:our_market/core/functions/navigate_to.dart';
import 'package:our_market/views/home/ui/search_view.dart';
import 'package:our_market/views/home/ui/widgets/categories_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode(); // ✅ أضفناها هنا

  @override
  void initState() {
    super.initState();

    // ✅ لما نرجع للصفحة، نقفل الكيبورد بعد البناء مباشرة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // ✅ لو ضغطت في أي مكان فاضي، يقفل الكيبورد
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(height: 15),
            CustomSearchField(
              controller: _searchController,
              focusNode: _searchFocusNode, // ✅ نمرره للتيكست فيلد
              onPressed: () async {
                // ✅ نقفل الكيبورد قبل ما ننتقل
                _searchFocusNode.unfocus();

                if (_searchController.text.isNotEmpty) {
                  await navigateTo(
                    context,
                    SearchView(query: _searchController.text),
                  );

                  // ✅ نقفل الكيبورد بعد الرجوع مباشرة
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _searchFocusNode.unfocus();
                  });

                  _searchController.clear();
                }
              },
            ),
            const SizedBox(height: 35),
            const Text("Popular Categories", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 15),
            const CategoriesList(),
            const SizedBox(height: 15),
            const Text("Recently Products", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 15),
            const ProductsList()
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }
}
