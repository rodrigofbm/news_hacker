import 'package:flutter/material.dart';
import 'dart:async';
import '../models/item_model.dart';
import '../blocs/comments_provider.dart';

class NewsDetail extends StatelessWidget {
  final int id;

  NewsDetail({this.id});

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvides.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if(!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        
        return FutureBuilder(
          future: snapshot.data[id],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if(!itemSnapshot.hasData) {
              return Text('getting comments...');
            }

            return buildTitle(itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildTitle(ItemModel item) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(10.0),
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}