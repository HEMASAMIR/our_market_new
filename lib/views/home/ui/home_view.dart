import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_market_new_fixed/core/app_colors.dart';
import 'package:our_market_new_fixed/core/components/custom_search_field.dart';
import 'package:our_market_new_fixed/core/components/products_list.dart';
import 'package:our_market_new_fixed/core/cubit/home_cubit.dart';
import 'package:our_market_new_fixed/core/functions/navigate_to.dart';
import 'package:our_market_new_fixed/views/home/ui/search_view.dart';
import 'package:our_market_new_fixed/views/home/ui/widgets/categories_list.dart';
import 'package:our_market_new_fixed/views/store/sensetive.dart';

import 'package:pay_with_paymob/pay_with_paymob.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  String? query;
  @override
  void initState() {
    PaymentData.initialize(
      apiKey:
          apiKey, // Required: Found under Dashboard -> Settings -> Account Info -> API Key
      iframeId: iframeId, // Required: Found under Developers -> iframes
      integrationCardId:
          integrationId, // Required: Found under Developers -> Payment Integrations -> Online Card ID
      integrationMobileWalletId:
          integrationMobileWalletId, // Required: Found under Developers -> Payment Integrations -> Mobile Wallet ID
      // // Optional User Data
      // userData: UserData(
      //   email: "User Email", // Optional: Defaults to 'NA'
      //   phone: "User Phone", // Optional: Defaults to 'NA'
      //   name: "User First Name", // Optional: Defaults to 'NA'
      //   lastName: "User Last Name", // Optional: Defaults to 'NA'
      // ),

      // Optional Style Customizations
      style: Style(
        primaryColor: AppColors.kPrimaryColor, // Default: Colors.blue
        scaffoldColor: Colors.white, // Default: Colors.white
        appBarBackgroundColor: AppColors.kPrimaryColor, // Default: Colors.blue
        appBarForegroundColor: Colors.white, // Default: Colors.white

        buttonStyle: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kPrimaryColor,
          textStyle: const TextStyle(color: AppColors.kWhiteColor),
        ), // Default: ElevatedButton.styleFrom()
        circleProgressColor: AppColors.kPrimaryColor, // Default: Colors.blue
        unselectedColor: Colors.grey, // Default: Colors.grey
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is AddToFavoriteSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Product added to favorites"),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is AddToFavoriteError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Product removed from favorites"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              const SizedBox(height: 15),
              CustomSearchField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                onPressed: () async {
                  _searchFocusNode.unfocus();
                  if (_searchController.text.isNotEmpty) {
                    final currentQuery = _searchController.text;
                    setState(() {
                      query = currentQuery;
                    });
                    await navigateTo(
                      context,
                      SearchView(query: _searchController.text),
                    ).then((value) {
                      if (value != null && value.isNotEmpty) {
                        setState(() {
                          query = value;
                          _searchController.text = value;
                        });
                      }
                    });
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
              ProductsList(query: query), // مجرد UI   // Builder
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();

    _searchFocusNode.dispose();
    super.dispose();
  }
}
