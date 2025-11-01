import 'package:flutter/material.dart';
import 'package:our_market/core/components/custom_circle_pro_ind.dart';
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
            .from("comments_table")
            .stream(primaryKey: ["id"])
            .eq("for_product", productModel.productId!)
            .order("created_at", ascending: false),
        builder: (_, snapshot) {
          List<Map<String, dynamic>>? data = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CustomCircleProgIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error loading comments"));
          }

          if (data!.isEmpty) {
            return const Center(child: Text("No Comments Yet"));
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) =>
                UserComment(commentData: data[index]),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: data.length,
          );
        });
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
              commentData?["user_name"] ?? "User Name",
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
                        commentData?["replay"] ?? "Replay:-",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        commentData?["replay"] ?? "Replay",
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
