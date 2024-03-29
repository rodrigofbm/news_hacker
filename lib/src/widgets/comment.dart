import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../widgets/loading_container_tile.dart';

class Comment extends StatelessWidget {
  final int commentId;
  final double depth;
  final Map<int,Future<ItemModel>> itemMap;

  const Comment({this.commentId, this.itemMap, this.depth});
  
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[commentId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if(!snapshot.hasData) {
          return LoadingContainerTile();
        }

        final comment = snapshot.data;

        final children = <Widget>[
          ListTile(
            title: buildText(comment),
            subtitle: comment.by == "" ? Text("Deleted", style: TextStyle(fontStyle: FontStyle.italic)) :Text(comment.by),
            contentPadding: EdgeInsets.only(
              right: 16.0,
              left: depth * 16,
            ),
          ),
          Divider()
        ];

        comment.kids.forEach((kidId) {
          children.add(Comment(commentId: kidId, itemMap: itemMap, depth: depth + 1,));
        });

        return Column(
          children: children,
        );
      },
    );
  }

  Widget buildText(ItemModel item) {
    final text = item.text.replaceAll('&#x27;', "'");
    return Text(text);
  }
}