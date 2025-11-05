import 'package:flutter/material.dart';
import 'package:our_market/core/models/product_model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client
          .from('comments_table')
          .stream(primaryKey: ['id'])
          .eq('for_product', productModel.productId!)
          .order('created_at', ascending: false),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.data!.isEmpty) {
          return const Center(child: Text("No comments yet"));
        } else if (snapshot.hasData) {}
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => UserComment(
            commentData: snapshot.data![index],
          ),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: snapshot.data!.length,
        );
      },
    );
  }
}

class UserComment extends StatelessWidget {
  const UserComment({
    super.key,
    required this.commentData,
  });
  // instrucure programming
  final Map<String, dynamic>? commentData; // OR MODEL

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              commentData?["name"] ?? "User Name",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              commentData?["comment"] ?? "Comment",
            ),
          ],
        ),
        commentData?["replay"] != null
            ? Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Replay:-",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Replay",
                      ),
                    ],
                  ),
                ],
              )
            : Container()
      ],
    );
  }
}
