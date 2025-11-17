import 'package:flutter/material.dart';

AppBar buildCustomAppBar(BuildContext context, String title,
    {String? returnValue}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.blue, // خلي لون واضح
    title: Text(title, style: const TextStyle(color: Colors.white)),
    leading: IconButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        Navigator.pop(context, returnValue);
      },
      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
    ),
  );
}
